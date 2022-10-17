import 'package:equatable/equatable.dart';

import 'package:flutter_prototype/models/bluetooth_device.dart';

abstract class DeviceState extends Equatable {}

class DeviceInitial extends DeviceState {
  @override
  List<Object?> get props => [];
}

class DeviceLoading extends DeviceState {
  DeviceLoading(this.devices);

  final List<BTDevice> devices;

  @override
  List<Object?> get props => [devices];
}

class DeviceLoaded extends DeviceState {
  DeviceLoaded(this.devices);

  final List<BTDevice> devices;

  @override
  List<Object?> get props => [devices];
}

class DeviceError extends DeviceState {
  DeviceError(this.exception, this.stack);

  final Object exception;
  final StackTrace stack;

  @override
  List<Object?> get props => [exception, stack];
}
