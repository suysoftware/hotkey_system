//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <hotkey_system/hotkey_system_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) hotkey_system_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HotkeySystemPlugin");
  hotkey_system_plugin_register_with_registrar(hotkey_system_registrar);
}
