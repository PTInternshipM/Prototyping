import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'cubits/device/device_cubit.dart';
import 'cubits/device/device_state.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({Key? key}) : super(key: key);

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  final _biggerFont = const TextStyle(fontSize: 18);

  DeviceCubit get _deviceCubit => context.read<DeviceCubit>();

  @override
  Widget build(BuildContext context) {
    return deviceListView();
  }

  Widget deviceListView() {
    return Observer(
      builder: (context) {
        return ListView.separated(
          itemBuilder: (context, i) {
            final device = _deviceCubit.devices[i];
            return ListTile(
              title: Text(
                (device.name.isEmpty ? "Unnamed" : device.name),
                style: _biggerFont,
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon((device.rssi >= -70
                      ? Icons.signal_wifi_4_bar
                      : Icons.signal_wifi_0_bar)),
                  Text(device.rssi.toString()),
                ],
              ),
            );
          },
          separatorBuilder: (context, i) => const Divider(),
          itemCount: _deviceCubit.devices.length,
        );
      },
    );
  }
}
