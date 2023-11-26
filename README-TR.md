# hotkey_system

[![pub version][pub-image]][pub-url] 


[pub-url]: https://pub.dev/packages/hotkey_system


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
    - [Usage](#usage)
  - [Who's using it?](#whos-using-it)
  - [API](#api)
    - [HotKeySystem](#hotkeysystem)
  - [Related Links](#related-links)
  - [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Platform Desteği

| macOS |
| :---: |
|   ✔️   |

## Hızlı Başlangıç

### Kurulum

Bu alanı pubspec.yaml dosyasına ekleyiniz.

```yaml
dependencies:
  hotkey_system: ^0.1.7
```

Yada

```yaml
dependencies:
  hotkey_system:
    git:
      url: https://github.com/suysoftware/hotkey_system.git
      ref: main
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

Use `HotKeyRecorder` Hotkey kaydetmek için bunu çağırabilirsiniz.

```dart
HotKeyRecorder(
  onHotKeyRecorded: (hotKey) {
    _hotKey = hotKey;
    setState(() {});
  },
),
```

> Lütfen example app isimli örnek uygulamadan diğer detayları inceleyiniz.

## Kimler kullanıyor?

- [ThinkBuddy](https://thinkbuddy.ai) - MacOS deneyimi ile bütünleşik yapay zeka

## API

### HotKeySystem

| Metod         | Açıklama                                                | macOS | 
| ------------- | ------------------------------------------------------- | ----- | 
| register      | Bir sistem/içerik genelinde kısayol kaydet              | ✔️     |
| unregister    | Bir sistem/içerik genelinde kısayolu kaydı sil          | ✔️     |
| unregisterAll | Tüm sistem/içerik genelinde kısayolları kayıtlardan sil | ✔️     |

## İlgili linkler

- https://github.com/soffes/HotKey
- https://github.com/kupferlauncher/keybinder
- https://github.com/leanflutter/hotkey_manager

## Lisans

[MIT](./LICENSE)