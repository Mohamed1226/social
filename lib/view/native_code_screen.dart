import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCodeScreen extends StatefulWidget {
  @override
  _NativeCodeScreenState createState() => _NativeCodeScreenState();
}

class _NativeCodeScreenState extends State<NativeCodeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  // Get battery level.
  String batteryLevel = 'Unknown battery level.';

  void getBatteryLevel() {


    platform.invokeMethod('getBatteryLevel').then((value) {
      setState(() {
        batteryLevel = 'Battery level at $value % .';
      });
    }).catchError((e) {
      setState(() {
        batteryLevel = "Failed to get battery level: '${e.message}'.";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: getBatteryLevel, child: Text("Get Battery Level")),
            Text(batteryLevel),
          ],
        ),
      ),
    );
  }
}
