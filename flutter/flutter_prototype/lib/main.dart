// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_prototype/BTDevice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
                child: RandomWords(),
              ),
              // SizedBox(height: 100,),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                onPressed: () { },
                child: const Text('Scan'),
              )
            ],
          )
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _biggerFont = const TextStyle(fontSize: 18);
  
  final _devices = [
    BTDevice("abcd", 80, "China", "Device A"),
    BTDevice("efgh", 69, "China", "Device B"),
    BTDevice("ijkl", 1, "China", "Device C"),
    BTDevice("mnop", 50, "China", "Device D"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(
              _devices[i].name,
              style: _biggerFont,
            ),
          );
        },
        separatorBuilder: (context, i) => const Divider(),
        itemCount: _devices.length);
  }
}
