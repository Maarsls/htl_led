// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:htl_led/models/BluetoothManager.dart';
import 'models/globals.dart' as globals;

class RGB extends StatefulWidget {
  final BluetoothManager manager;

  const RGB(
    this.manager,
  );

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<RGB> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Padding(
                  child: SpinBox(
                    min: 0,
                    max: 30,
                    value: globals.leds,
                    onChanged: (value) {
                      if (widget.manager.isTime()) {
                        setState(() {
                          globals.leds = value;
                        });
                        widget.manager.sendMessageToBluetooth(
                            "B " + globals.leds.toInt().toString());
                      }
                    },
                    decoration: const InputDecoration(labelText: 'LEDs'),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 150),
                ),
              ),
            ],
          ),
          const Text('RED'),
          Slider(
            value: globals.r,
            onChangeEnd: (newRating) {
              if (widget.manager.isTime()) {
                widget.manager.sendMessageToBluetooth(
                    "A " + globals.r.toInt().toString());
              }
            },
            onChanged: (value) => setState(() => globals.r = value),
            activeColor: Colors.red,
            label: "${globals.r}",
            min: 0,
            max: 255,
          ),
          const Text('GREEN'),
          Slider(
            value: globals.g,
            onChangeEnd: (newRating) {
              if (widget.manager.isTime()) {
                widget.manager.sendMessageToBluetooth(
                    "B " + globals.g.toInt().toString());
              }
            },
            onChanged: (value) => setState(() => globals.g = value),
            activeColor: Colors.green,
            label: "${globals.g}",
            min: 0,
            max: 255,
          ),
          const Text('BLUE'),
          Slider(
            value: globals.b,
            onChangeEnd: (newRating) {
              if (widget.manager.isTime()) {
                widget.manager.sendMessageToBluetooth(
                    "C " + globals.b.toInt().toString());
              }
            },
            onChanged: (value) => setState(() => globals.b = value),
            activeColor: Colors.blue,
            label: "${globals.b}",
            min: 0,
            max: 255,
          )
        ],
      ),
    );
  }
}
