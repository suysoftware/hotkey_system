// ignore_for_file: avoid_print

import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hotkey_system/src/enums/key_code.dart';
import 'package:hotkey_system/src/enums/key_modifier.dart';
import 'package:hotkey_system/src/hotkey.dart';

typedef HotKeyHandler = void Function(HotKey hotKey);

class HotKeySystem {
  HotKeySystem._();

  /// The shared instance of [HotKeySystem].
  static final HotKeySystem instance = HotKeySystem._();

  final MethodChannel _channel = const MethodChannel('hotkey_system');

  bool _inited = false;
  final List<HotKey> _hotKeyList = [];
  final Map<String, HotKeyHandler> _keyDownHandlerMap = {};
  final Map<String, HotKeyHandler> _keyUpHandlerMap = {};

  HotKey? _lastPressedHotKey;

  void _init() {
    ServicesBinding.instance.keyboard.addHandler(_handleLocalKeyEvent);
    _channel.setMethodCallHandler(_methodCallHandler);
    _inited = true;
  }

  bool _handleLocalKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      // KeyDownEvent
      HotKey? hotKey = _findHotKey(event.logicalKey, _getKeyModifiers());
      if (hotKey != null) {
        HotKeyHandler? handler = _keyDownHandlerMap[hotKey.identifier];
        if (handler != null) {
          handler(hotKey);
          _lastPressedHotKey = hotKey;
          return true;
        }
      }
    } else if (event is KeyUpEvent) {
      // KeyUpEvent
      if (_lastPressedHotKey != null && event.logicalKey == _lastPressedHotKey!.keyCode.logicalKey) {
        HotKeyHandler? handler = _keyUpHandlerMap[_lastPressedHotKey!.identifier];
        if (handler != null) {
          handler(_lastPressedHotKey!);
          _lastPressedHotKey = null;
          return true;
        }
      }
    }
    return false;
  }

  HotKey? _findHotKey(LogicalKeyboardKey key, List<KeyModifier> currentModifiers) {
    // Find equal hotkey
    return _hotKeyList.firstWhereOrNull((hotKey) {
      return hotKey.keyCode == KeyCodeParser.fromLogicalKey(key) && Set.from(currentModifiers).containsAll(hotKey.modifiers ?? []);
    });
  }

  List<KeyModifier> _getKeyModifiers() {
    List<KeyModifier> keyModifiers = [];

    // Pressed logical keys
    var logicalKeysPressed = HardwareKeyboard.instance.logicalKeysPressed;

    // Pressed modifiers
    if (logicalKeysPressed.contains(LogicalKeyboardKey.controlLeft) || logicalKeysPressed.contains(LogicalKeyboardKey.controlRight)) {
      if (!keyModifiers.any((element) => element == KeyModifier.control)) {
        keyModifiers.add(KeyModifier.control);
      }
    }
    if (logicalKeysPressed.contains(LogicalKeyboardKey.shiftLeft) || logicalKeysPressed.contains(LogicalKeyboardKey.shiftRight)) {
      if (!keyModifiers.any((element) => element == KeyModifier.shift)) {
        keyModifiers.add(KeyModifier.shift);
      }
    }
    if (logicalKeysPressed.contains(LogicalKeyboardKey.altLeft) || logicalKeysPressed.contains(LogicalKeyboardKey.altRight)) {
      if (!keyModifiers.any((element) => element == KeyModifier.alt)) {
        keyModifiers.add(KeyModifier.alt);
      }
    }
    if (logicalKeysPressed.contains(LogicalKeyboardKey.metaLeft) || logicalKeysPressed.contains(LogicalKeyboardKey.metaRight)) {
      if (!keyModifiers.any((element) => element == KeyModifier.meta)) {
        keyModifiers.add(KeyModifier.meta);
      }
    }

    //

    return keyModifiers;
  }

  Future<void> _methodCallHandler(MethodCall call) async {
    String identifier = call.arguments['identifier'];
    HotKey? hotKey = _hotKeyList.firstWhereOrNull(
      (e) => e.identifier == identifier,
    );
    if (hotKey == null) {
      return;
    }

    switch (call.method) {
      case 'onKeyDown':
        if (_keyDownHandlerMap.containsKey(identifier)) {
          _keyDownHandlerMap[identifier]!(hotKey);
        }
        break;
      case 'onKeyUp':
        if (_keyUpHandlerMap.containsKey(identifier)) {
          _keyUpHandlerMap[identifier]!(hotKey);
        }
        break;
      default:
        UnimplementedError();
    }
  }

  List<HotKey> get registeredHotKeyList => _hotKeyList;

  Future<void> register(
    HotKey hotKey, {
    HotKeyHandler? keyDownHandler,
    HotKeyHandler? keyUpHandler,
  }) async {
    if (!_inited) _init();

    if (hotKey.scope == HotKeyScope.system) {
      await _channel.invokeMethod('register', hotKey.toJson());
    }
    if (keyDownHandler != null) {
      _keyDownHandlerMap.update(
        hotKey.identifier,
        (_) => keyDownHandler,
        ifAbsent: () => keyDownHandler,
      );
    }
    if (keyUpHandler != null) {
      _keyUpHandlerMap.update(
        hotKey.identifier,
        (_) => keyUpHandler,
        ifAbsent: () => keyUpHandler,
      );
    }

    _hotKeyList.add(hotKey);
  }

  Future<void> unregister(HotKey hotKey) async {
    if (!_inited) _init();

    if (hotKey.scope == HotKeyScope.system) {
      await _channel.invokeMethod('unregister', hotKey.toJson());
    }
    if (_keyDownHandlerMap.containsKey(hotKey.identifier)) {
      _keyDownHandlerMap.remove(hotKey.identifier);
    }
    if (_keyUpHandlerMap.containsKey(hotKey.identifier)) {
      _keyUpHandlerMap.remove(hotKey.identifier);
    }

    _hotKeyList.removeWhere((e) => e.identifier == hotKey.identifier);
  }

  Future<void> unregisterAll() async {
    if (!_inited) _init();

    await _channel.invokeMethod('unregisterAll');

    _keyDownHandlerMap.clear();
    _keyUpHandlerMap.clear();
    _hotKeyList.clear();
  }
}

final hotKeySystem = HotKeySystem.instance;
