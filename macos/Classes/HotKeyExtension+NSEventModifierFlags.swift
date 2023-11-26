//
//  HotKeyExtension+NSEventModifierFlags.swift
//  hotkey_system
//
//  Created by SUY on 2023/11/26.
//

extension NSEvent.ModifierFlags {
    public init(pluginModifiers: Array<String>) {
        self.init()
        if (pluginModifiers.contains("capsLock")) {
            insert(.capsLock)
        }
        if (pluginModifiers.contains("shift")) {
            insert(.shift)
        }
        if (pluginModifiers.contains("control")) {
            insert(.control)
        }
        if (pluginModifiers.contains("alt")) {
            insert(.option)
        }
        if (pluginModifiers.contains("meta")) {
            insert(.command)
        }
        if (pluginModifiers.contains("fn")) {
            insert(.function)
        }
    }
}