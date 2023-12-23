<p align="center">
<img src="https://firebasestorage.googleapis.com/v0/b/think-buddy.appspot.com/o/default_files%2Fhs_logo.png?alt=media&token=76ffec3d-0d9b-460b-8e62-f5fbec586989" height="256" alt="HotkeySystem" />
</p>


This plugin allows Flutter desktop apps to defines system/inapp wide hotkey (i.e. shortcut).

---

English | [Turkish](./README-TR.md)

---

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [hotkey_system](#hotkey_system)
  - [Platform Support](#platform-support)
  - [Quick Start](#quick-start)
    - [Installation](#installation)
      - [Linux requirements](#linux-requirements)
    - [Usage](#usage)
  - [Who's using it?](#whos-using-it)
  - [API](#api)
    - [HotKeySystem](#hotkeysystem)
  - [Related Links](#related-links)
  - [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Platform Support

| macOS |
| :---: |
|   ✔️   |

## Quick Start

### Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  hotkey_system: ^0.0.4
```

Or

```yaml
dependencies:
  hotkey_system:
    git:
      url: https://github.com/suysoftware/hotkey_system.git
      ref: main
```
#### Linux requirements

- [`keybinder-3.0`](https://github.com/kupferlauncher/keybinder)

Run the following command

```
sudo apt-get install keybinder-3.0
```

### Usage

```dart
import 'package:hotkey_system/hotkey_system.dart';

void main() async {
  // Must add this line.
  WidgetsFlutterBinding.ensureInitialized();
  // For hot reload, `unregisterAll()` needs to be called.
  await hotKeySystem.unregisterAll();

  runApp(MyApp());
}
```

Register/Unregsiter a system/inapp wide hotkey.

```dart
// ⌥ + Q
HotKey _hotKey = HotKey(
  KeyCode.keyQ,
  modifiers: [KeyModifier.alt],
  // Set hotkey scope (default is HotKeyScope.system)
  scope: HotKeyScope.inapp, // Set as inapp-wide hotkey.
);
await hotKeySystem.register(
  _hotKey,
  keyDownHandler: (hotKey) {
    print('onKeyDown+${hotKey.toJson()}');
  },
  // Only works on macOS.
  keyUpHandler: (hotKey){
    print('onKeyUp+${hotKey.toJson()}');
  } ,
);

await hotKeySystem.unregister(_hotKey);

await hotKeySystem.unregisterAll();
```

Use `HotKeyRecorder` widget to help you record a hotkey.

```dart
HotKeyRecorder(
  onHotKeyRecorded: (hotKey) {
    _hotKey = hotKey;
    setState(() {});
  },
),
```


Use `HotKeyRecorder` widget with initialHotkey

```dart
HotKeyRecorder(
  onHotKeyRecorded: (hotKey) {
    _hotKey = hotKey;
    setState(() {});
  },
  initialHotKey: HotKey.fromJson({"keyCode":"keyR","modifiers":["meta"],"identifier":"fdf8484b-5249-42bb-b473-d99bfb7bb3e8","scope":"system"})
),
```

Register with identifier

```dart
// ⌥ + Q
HotKey _hotKey = HotKey(
  KeyCode.keyQ,
  modifiers: [KeyModifier.alt],
  identifier: "examleidentifier"
  // Set hotkey scope (default is HotKeyScope.system)
  scope: HotKeyScope.inapp, // Set as inapp-wide hotkey.
);
await hotKeySystem.register(
  _hotKey,
  keyDownHandler: (hotKey) {
    print('onKeyDown+${hotKey.toJson()}');
  },
  // Only works on macOS.
  keyUpHandler: (hotKey){
    print('onKeyUp+${hotKey.toJson()}');
  } ,
);

```
Hotkey.fromJson usage

```dart
HotKey _hotKey = HotKey.fromJson({"keyCode":"keyR","modifiers":["meta"],"identifier":"fdf8484b-5249-42bb-b473-d99bfb7bb3e8","scope":"system"})
await hotKeySystem.register(
  _hotKey,
  keyDownHandler: (hotKey) {
    print('onKeyDown+${hotKey.toJson()}');
  },
  // Only works on macOS.
  keyUpHandler: (hotKey){
    print('onKeyUp+${hotKey.toJson()}');
  } ,
);

```


HotKeyVirtualView usage

```dart
 
return HotKeyVirtualView(HotKey.fromJson({"keyCode":"keyR","modifiers":["meta"],"identifier":"fdf8484b-5249-42bb-b473-d99bfb7bb3e8","scope":"system"}));

```


> Please see the example app of this plugin for a full example.

## Who's using it?

- [ThinkBuddy](https://thinkbuddy.ai) - Made for native MacOS experience integrated with AI

## API

### HotKeySystem

| Method        | Description                               | Linux | macOS | Windows |
| ------------- | ----------------------------------------- | ----- | ----- | ------- |
| register      | register an system/inapp wide hotkey.     | ✔️     | ✔️     | ✔️       |
| unregister    | unregister an system/inapp wide hotkey.   | ✔️     | ✔️     | ✔️       |
| unregisterAll | unregister all system/inapp wide hotkeys. | ✔️     | ✔️     | ✔️       |

## Related Links

- https://github.com/soffes/HotKey
- https://github.com/kupferlauncher/keybinder
- https://github.com/leanflutter/hotkey_manager

## License

[MIT](./LICENSE)