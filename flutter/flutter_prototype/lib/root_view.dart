import 'dart:async';

import 'package:bluetooth_low_energy/bluetooth_low_energy.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_lib_ios_15/flutter_ble_lib.dart' as ble_lib;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart' as blue_plus;
import 'package:flutter_prototype/cubits/device/device_state.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:quick_blue/quick_blue.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart' as uuid_gen;

import 'cubits/device/device_cubit.dart';
import 'device_list.dart';
import 'models/bluetooth_device.dart';

class RootView extends StatefulWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  late Completer completer;
  late StreamSubscription streamSubscription;

  DeviceCubit get _deviceCubit => context.read<DeviceCubit>();

  List<DropdownMenuItem<Future<void> Function()>> blePackageOptions = [];

  // Flutter Reactive BLE
  final flutterReactiveBle = FlutterReactiveBle();

  // Flutter Blue
  // blue.FlutterBlue flutterBlue = blue.FlutterBlue.instance;

  // Flutter Blue Plus
  blue_plus.FlutterBluePlus flutterBlue = blue_plus.FlutterBluePlus.instance;

  // Flutter BLE Lib iOS 15
  ble_lib.BleManager bleManager = ble_lib.BleManager();

  @override
  void initState() {
    blePackageOptions
        .add(packageDropdownItem('Bluetooth low energy', discoverBleDevices));
    blePackageOptions
        .add(packageDropdownItem('Ble Lib', discoverBleLibDevices));
    blePackageOptions
        .add(packageDropdownItem('Blue Plus', discoverBluePlusDevices));
    // blePackageOptions
    //     .add(packageDropdownItem('Blue', discoverBlueDevices));
    blePackageOptions
        .add(packageDropdownItem('Reactive BLE', discoverReactiveBLEDevices));
    blePackageOptions
        .add(packageDropdownItem('Quick Blue', discoverQuickBlueDevices));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 78.h,
              child: const DeviceList(),
            ),
            SizedBox(
              width: 80.w,
              height: 6.h,
              child: BlocBuilder<DeviceCubit, DeviceState>(
                  builder: (context, state) {
                return (state is DeviceLoading
                    ? ElevatedButton(
                        onPressed: () {
                          stopScan();
                        },
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          customButton: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: (state is DeviceLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Scan',
                                    style: TextStyle(color: Colors.white),
                                  )),
                          ),
                          items: blePackageOptions,
                          onChanged: (value) {
                            if (value is Future<void> Function()) {
                              _deviceCubit.discoverDevices(value);
                            }
                          },
                          itemHeight: 48,
                          itemPadding:
                              const EdgeInsets.only(left: 16, right: 16),
                          dropdownWidth: 160,
                          dropdownPadding:
                              const EdgeInsets.symmetric(vertical: 6),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          dropdownElevation: 8,
                        ),
                      ));
              }),
            )
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<Future<void> Function()> packageDropdownItem(
      String name, Future<void> Function() discoverFunction) {
    return DropdownMenuItem<Future<void> Function()>(
      value: discoverFunction,
      child: Text(name),
    );
  }

  Future<void> discoverReactiveBLEDevices() async {
    completer = Completer();
    streamSubscription =
        flutterReactiveBle.scanForDevices(withServices: []).listen(
      (device) {
        _deviceCubit.addItem(BTDevice.fromReactiveDevice(device));
      },
      onError: streamErrorHandler,
      onDone: streamDoneHandler,
    );
    await completer.future;
  }

  Future<void> discoverBluePlusDevices() async {
    completer = Completer();
    flutterBlue.startScan(
      scanMode: blue_plus.ScanMode.balanced,
      allowDuplicates: true,
    );

    flutterBlue.state.listen((state) {
      if (state == blue_plus.BluetoothState.on) {
        streamSubscription = flutterBlue.scanResults.listen(
          (devices) {
            for (blue_plus.ScanResult device in devices) {
              _deviceCubit.addItem(BTDevice.fromBluePlusDevice(device));
            }
          },
          onError: streamErrorHandler,
          onDone: streamDoneHandler,
        );
      }
    });
    await completer.future;
    flutterBlue.stopScan();
  }

  Future<void> discoverBleLibDevices() async {
    completer = Completer();
    if (!await bleManager.isClientCreated()) {
      await bleManager.createClient(
        restoreStateIdentifier: const uuid_gen.Uuid().v4(),
      );
    }
    bleManager.observeBluetoothState().listen((state) {
      if (state == ble_lib.BluetoothState.POWERED_ON) {
        streamSubscription = bleManager
            .startPeripheralScan(
          scanMode: ble_lib.ScanMode.balanced,
          allowDuplicates: true,
        )
            .listen(
          (ble_lib.ScanResult device) {
            _deviceCubit.addItem(BTDevice.fromBleLibDevice(device));
          },
          onError: streamErrorHandler,
          onDone: streamDoneHandler,
        );
      }
    });
    await completer.future;
    bleManager.stopPeripheralScan();
    bleManager.destroyClient();
  }

  Future<void> discoverQuickBlueDevices() async {
    completer = Completer();
    streamSubscription = QuickBlue.scanResultStream.listen(
      (device) {
        _deviceCubit.addItem(BTDevice.fromQuickBlueDevice(device));
      },
      onError: streamErrorHandler,
      onDone: streamDoneHandler,
    );
    QuickBlue.startScan();
    await completer.future;
    QuickBlue.stopScan();
  }

  Future<void> discoverBleDevices() async {
    completer = Completer();
    await CentralManager.instance.authorize();
    streamSubscription = CentralManager.instance.scanned.listen(
      (device) {
        _deviceCubit.addItem(BTDevice.fromBleDevice(device));
      },
      onError: streamErrorHandler,
      onDone: streamDoneHandler,
    );
    CentralManager.instance.startScan();
    await completer.future;
    CentralManager.instance.stopScan();
  }

  Future<void> discoverBlueDevices() async {
    completer = Completer();
    // flutterBlue.startScan(
    //   scanMode: blue.ScanMode.balanced,
    //   allowDuplicates: true,
    // );
    //
    // flutterBlue.state.listen((state) {
    //   if (state == blue.BluetoothState.on) {
    //     streamSubscription = flutterBlue.scanResults.listen(
    //       (devices) {
    //         for (blue.ScanResult device in devices) {
    //           _deviceCubit.addItem(BTDevice.fromBlueDevice(device));
    //         }
    //       },
    //       onError: streamErrorHandler,
    //       onDone: streamDoneHandler,
    //     );
    //   }
    // });
    await completer.future;
    flutterBlue.stopScan();
  }

  void stopScan() {
    streamSubscription.cancel();
    completer.complete();
    _deviceCubit.devices.clear();
  }

  void streamErrorHandler(dynamic error, dynamic stacktrace) {
    debugPrint('There was an issue scanning for devices');
    if (error is ble_lib.BleError) {
      debugPrint(error.toString());
    } else {
      debugPrint(error);
    }
    debugPrint(stacktrace.toString());
    completer.completeError(error, stacktrace);
  }

  void streamDoneHandler() {
    debugPrint('Reactive Device stream done');
    if (!completer.isCompleted) {
      completer.complete();
    }
  }
}
