import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlashLightToggle(),
    );
  }
}

class FlashLightToggle extends StatefulWidget {
  const FlashLightToggle({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FlashLightToggleState();
  }
}

class _FlashLightToggleState extends State<FlashLightToggle> {
  static const platform = MethodChannel('com.example/flashlight');
  bool _isFlashOn = false;

  Future<void> _toggleFlashlight(bool value) async {
    try {
      if (value) {
        await platform.invokeMethod('turnOn');
      } else {
        await platform.invokeMethod('turnOff');
      }
      setState(() {
        _isFlashOn = value;
      });
    } on PlatformException catch (error) {
      // ignore: avoid_print
      print("Error: ${error.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flashlight"),
        centerTitle: true,
      ),
      body: Center(
        child: SwitchListTile(
          title: _isFlashOn
              ? Text("Flashlight Turn Off ")
              : Text("Flashlight Turn On"),
          value: _isFlashOn,
          onChanged: (value) {
            _toggleFlashlight(value);
          },
        ),
      ),
    );
  }
}
