import 'package:auto_updater/auto_updater.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:win_speaker_switcher/pages/home_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  String feedURL = 'https://update.gregsvc.fr/WinSpeakerSwitcher.xml';
  await autoUpdater.setFeedURL(feedURL);
  await autoUpdater.checkForUpdates();

  // For hot reload, `unregisterAll()` needs to be called.
  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: false,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    title: 'WinSpeakerSwitcher',
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await hotKeyManager.unregisterAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage()
    );
  }
}
