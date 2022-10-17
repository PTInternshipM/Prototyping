import 'package:bluetooth_low_energy/bluetooth_low_energy.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as blue_plus;
// import 'package:flutter_blue/flutter_blue.dart' as blue;
import 'package:flutter_ble_lib_ios_15/flutter_ble_lib.dart' as ble_lib;
import 'package:quick_blue/quick_blue.dart';

class BTDevice {
  final String id;
  final String name;
  final int rssi;

  BTDevice(this.id, this.name, this.rssi);

  BTDevice.fromReactiveDevice(DiscoveredDevice device)
      : id = device.id,
        name = device.name,
        rssi = device.rssi;

  BTDevice.fromBluePlusDevice(blue_plus.ScanResult device)
      : id = device.device.id.id,
        name = device.device.name,
        rssi = device.rssi;

  // BTDevice.fromBlueDevice(blue.ScanResult device)
  //     : id = device.device.id.id,
  //       name = device.device.name,
  //       rssi = device.rssi;

  BTDevice.fromBleLibDevice(ble_lib.ScanResult device)
      : id = device.peripheral.identifier,
        name = device.peripheral.name ?? " Unnamed",
        rssi = device.rssi;

  BTDevice.fromQuickBlueDevice(BlueScanResult device)
      : id = device.deviceId,
        name = device.name,
        rssi = device.rssi;

  BTDevice.fromBleDevice(Broadcast device)
      : id = device.peripheral.uuid.toString(),
        name = device.localName ?? " Unnamed",
        rssi = device.rssi;
}
