import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prototype/models/bluetooth_device.dart';
import 'package:mobx/mobx.dart';

import 'device_state.dart';

class DeviceCubit extends Cubit<DeviceState> {
  DeviceCubit() : super(DeviceInitial());

  @observable
  var devices = ObservableList<BTDevice>();

  @action
  void addItem(BTDevice device) {
    final knownDeviceIndex = devices.indexWhere((d) => d.id == device.id);
    if (knownDeviceIndex >= 0) {
      if (device.rssi == 127) {
        devices.removeAt(knownDeviceIndex);
      } else {
        devices[knownDeviceIndex] = device;
      }
    } else {
      devices.add(device);
    }
    devices.sort((a, b) => b.name.compareTo(a.name));
  }

  Future<void> discoverDevices(
      Future<void> Function() deviceDiscoveryFunction) async {
    try {
      debugPrint('Cubit: Discovering devices');
      emit(DeviceLoading(devices));
      await deviceDiscoveryFunction();
      emit(DeviceLoaded(devices));
      debugPrint('Cubit: Discovery finished');
    } catch (e, s) {
      debugPrint('Device discovery failed, exception: $e - stack: $s');
      emit(DeviceError(e, s));
    }
  }
}
