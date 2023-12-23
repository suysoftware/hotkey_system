import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_system/src/enums/key_code.dart';
import 'package:hotkey_system/src/enums/key_modifier.dart';
import 'package:hotkey_system/src/hotkey.dart';
import 'package:hotkey_system/src/widgets/hotkey_virtual_view.dart';

class HotKeyRecorder extends StatefulWidget {
  const HotKeyRecorder({
    Key? key,
    this.initialHotKey,
    required this.onHotKeyRecorded,
  }) : super(key: key);
  final HotKey? initialHotKey;
  final ValueChanged<HotKey> onHotKeyRecorded;

  @override
  State<HotKeyRecorder> createState() => _HotKeyRecorderState();
}

class _HotKeyRecorderState extends State<HotKeyRecorder> {
  HotKey? _hotKey;

  @override
  void initState() {
    super.initState();
    _hotKey = widget.initialHotKey;
    HardwareKeyboard.instance.addHandler(_handleHardwareKeyEvent);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleHardwareKeyEvent);
    super.dispose();
  }

  bool _handleHardwareKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {

      KeyCode? keyCode = KeyCodeParser.fromLogicalKey(event.logicalKey);
      List<KeyModifier> keyModifiers = _getKeyModifiers();

      if (keyCode != null && keyModifiers.isNotEmpty && !isKeyCodeModifier(keyCode)) {
        _hotKey = HotKey(
          keyCode,
          modifiers: keyModifiers,
        );
        if (widget.initialHotKey != null) {
          _hotKey?.identifier = widget.initialHotKey!.identifier;
          _hotKey?.scope = widget.initialHotKey!.scope;
        }

        widget.onHotKeyRecorded(_hotKey!);
        setState(() {});
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  List<KeyModifier> _getKeyModifiers() {
    List<KeyModifier> keyModifiers = [];

    // Pressed logical keys
    var logicalKeysPressed = HardwareKeyboard.instance.logicalKeysPressed;

    // Pressed logical modifier keys
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

    //remove simillar modifiers

    return keyModifiers;
  }

  bool isKeyCodeModifier(KeyCode keyCode) {
    // Check modifiers
    if (keyCode.logicalKey == KeyCode.control.logicalKey || keyCode.logicalKey == KeyCode.controlLeft.logicalKey || keyCode.logicalKey == KeyCode.controlRight.logicalKey) {
      return true;
    }
    if (keyCode.logicalKey == KeyCode.shift.logicalKey || keyCode.logicalKey == KeyCode.shiftLeft.logicalKey || keyCode.logicalKey == KeyCode.shiftRight.logicalKey) {
      return true;
    }
    if (keyCode.logicalKey == KeyCode.alt.logicalKey || keyCode.logicalKey == KeyCode.altLeft.logicalKey || keyCode.logicalKey == KeyCode.altRight.logicalKey) {
      return true;
    }
    if (keyCode.logicalKey == KeyCode.meta.logicalKey || keyCode.logicalKey == KeyCode.metaLeft.logicalKey || keyCode.logicalKey == KeyCode.metaRight.logicalKey) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (_hotKey == null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Text(
          'eg. ⌘ ⌥ B',
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.35),
          ),
        ),
      );
    }
    return HotKeyVirtualView(hotKey: _hotKey!);
  }
}
