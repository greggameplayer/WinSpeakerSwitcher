//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <auto_updater/auto_updater_plugin.h>
#include <hotkey_manager/hotkey_manager_plugin.h>
#include <screen_retriever/screen_retriever_plugin.h>
#include <win32audio/win32audio_plugin_c_api.h>
#include <window_manager/window_manager_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AutoUpdaterPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AutoUpdaterPlugin"));
  HotkeyManagerPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("HotkeyManagerPlugin"));
  ScreenRetrieverPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ScreenRetrieverPlugin"));
  Win32audioPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("Win32audioPluginCApi"));
  WindowManagerPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowManagerPlugin"));
}
