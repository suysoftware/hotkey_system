<p align="center">
<img src="https://firebasestorage.googleapis.com/v0/b/think-buddy.appspot.com/o/default_files%2Fhs_logo.png?alt=media&token=76ffec3d-0d9b-460b-8e62-f5fbec586989" height="256" alt="HotkeySystem" />
</p>




Bu eklenti, Flutter masaüstü uygulamalarının sistem/genel kullanım veya içerik genelinde kısayol (shortcut) tanımlamalarına olanak sağlar.

---

[English](./README.md) | Turkish

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

## Platform Desteği

| Linux | macOS | Windows |
| :---: | :---: | :-----: |
|   ✔️   |   ✔️   |    ✔️    |

## Hızlı Başlangıç

### Kurulum

Bu alanı pubspec.yaml dosyasına ekleyiniz.

```yaml
dependencies:
  hotkey_system: ^0.0.4
```

Yada

```yaml
dependencies:
  hotkey_system:
    git:
      url: https://github.com/suysoftware/hotkey_system.git
      ref: main
```
#### Linux gereklilikleri

- [`keybinder-3.0`](https://github.com/kupferlauncher/keybinder)

Run the following command

```
sudo apt-get install keybinder-3.0
```


### Kullanım

```dart
import 'package:hotkey_system/hotkey_system.dart';

void main() async {
  // Bu satırı yazmalısınız
  WidgetsFlutterBinding.ensureInitialized();
  // Hot Reload özelliğini kullanabilmek için bu işlemi çağırmalısınız
  await hotKeySystem.unregisterAll();

  runApp(MyApp());
}
```

Bir sistem/içerik genelinde kısayol kaydet/sil

```dart
// ⌥ + Q
HotKey _hotKey = HotKey(
  KeyCode.keyQ,
  modifiers: [KeyModifier.alt],
  // Hotkey'in global olarak mı yoksa uygulama odağında mı çalışacağını ayarla (default is HotKeyScope.system)
  scope: HotKeyScope.inapp, // Bu şekilde uygulama odağında çalışması için ayarlayabilirsiniz.
);
await hotKeySystem.register(
  _hotKey,
  keyDownHandler: (hotKey) {
    print('onKeyDown+${hotKey.toJson()}');
  },
  // Sadece macOS'ta çalışır.
  keyUpHandler: (hotKey){
    print('onKeyUp+${hotKey.toJson()}');
  } ,
);

await hotKeySystem.unregister(_hotKey);

await hotKeySystem.unregisterAll();
```

`HotKeyRecorder` Hotkey kaydetmek için bunu çağırabilirsiniz.

```dart
HotKeyRecorder(
  onHotKeyRecorded: (hotKey) {
    _hotKey = hotKey;
    setState(() {});
  },
),
```

`HotKeyRecorder` widget'ın initialHotKey ile kullanımı

```dart
HotKeyRecorder(
  onHotKeyRecorded: (hotKey) {
    _hotKey = hotKey;
    setState(() {});
  },
  initialHotKey: HotKey.fromJson({"keyCode":"keyR","modifiers":["meta"],"identifier":"fdf8484b-5249-42bb-b473-d99bfb7bb3e8","scope":"system"})
),
```

HotKey'i identifier özelliği ile kaydet

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
Hotkey.fromJson kullanımı

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

HotKeyVirtualView kullanımı

```dart
 
return HotKeyVirtualView(HotKey.fromJson({"keyCode":"keyR","modifiers":["meta"],"identifier":"fdf8484b-5249-42bb-b473-d99bfb7bb3e8","scope":"system"}));

```

> Lütfen example app isimli örnek uygulamadan diğer detayları inceleyiniz.

## Kimler kullanıyor?

- [ThinkBuddy](https://thinkbuddy.ai) - MacOS deneyimi ile bütünleşik yapay zeka

## API

### HotKeySystem

| Metod         | Açıklama                                                | Linux | macOS | Windows |
| ------------- | ------------------------------------------------------- | ----- | ----- | ------- |
| register      | Bir sistem/içerik genelinde kısayol kaydet              | ✔️     | ✔️     | ✔️       |
| unregister    | Bir sistem/içerik genelinde kısayolu kaydı sil          | ✔️     | ✔️     | ✔️       |
| unregisterAll | Tüm sistem/içerik genelinde kısayolları kayıtlardan sil | ✔️     | ✔️     | ✔️       |

## İlgili linkler

- https://github.com/soffes/HotKey
- https://github.com/kupferlauncher/keybinder
- https://github.com/leanflutter/hotkey_manager

## Lisans

[MIT](./LICENSE)