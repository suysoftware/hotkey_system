import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_system/hotkey_system.dart';
import 'package:hotkey_system_example/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await hotKeySystem.unregisterAll();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff416ff4),
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Color(0xffF7F9FB),
        dividerColor: Colors.grey.withOpacity(0.3),
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: HomePage(),
    );
  }
}
