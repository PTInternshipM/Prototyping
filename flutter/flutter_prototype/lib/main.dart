import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prototype/root_view.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'cubits/device/device_cubit.dart';

void main() {
  Phoenix returnApp() {
    return Phoenix(
      child: MultiProvider(
        providers: [
          BlocProvider(create: (_) => DeviceCubit()),
        ],
        child: ResponsiveSizer(
          builder: (context, orientation, screenSize) {
            return const MaterialApp(
              title: 'BLE Prototype',
              home: RootView(),
            );
          },
        ),
      ),
    );
  }

  runApp(
    returnApp(),
  );
}
