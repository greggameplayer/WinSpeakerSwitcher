import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:localstorage/localstorage.dart';
import 'package:process_run/shell.dart';
import 'dart:async';
import 'dart:typed_data';

import 'package:win32audio/win32audio.dart';
import 'package:win_speaker_switcher/models/audio_extended.dart';
import 'package:win_speaker_switcher/widgets/record_hotkey_dialog.dart';
import 'package:window_manager/window_manager.dart';
import 'models/audio_device_extended.dart';
import 'widgets/animated_progress_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

Map<String, Uint8List?> _audioIcons = {};

class _MyAppState extends State<MyApp> {
  LocalStorage localStorage = LocalStorage('win_speaker_switcher');
  bool initialized = false;
  var defaultDevice = AudioDeviceExtended();
  var audioDeviceType = AudioDeviceType.output;
  var shell = Shell();
  var jsonDecoder = const JsonDecoder();
  var jsonEncoder = const JsonEncoder();
  var winIcons = WinIcons();

  var audioDevices = <AudioDeviceExtended>[];

  var mixerList = <ProcessVolume>[];
  bool _stateFetchAudioMixerPeak = false;

  double __volume = 0.0;
  String fetchStatus = "";

  void _keyDownHandler(HotKey hotKey) async {
    if (!audioDevices
        .firstWhere((element) => element.hotKey == hotKey)
        .isActive) {
      await Audio.setDefaultDevice(
          audioDevices.firstWhere((element) => element.hotKey == hotKey).id);
      fetchAudioDevices();
    }
  }

  void _handleHotKeyRegister(HotKey hotKey, int index) async {
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: _keyDownHandler,
    );
    /*setState(() {
      audioDevices[index].hotKey = hotKey;
      localStorage.setItem("audioDevices", audioDevices.map((element) => element.toMap()).toList());
    });*/
  }

  void _handleHotKeyUnregister(HotKey hotKey) async {
    await hotKeyManager.unregister(hotKey);
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 150), (timer) async {
      if (_stateFetchAudioMixerPeak) {
        mixerList = await Audio.enumAudioMixer() ?? [];

        for (var mixer in mixerList) {
          if (_audioIcons[mixer.processPath] == null) {
            _audioIcons[mixer.processPath] =
                await winIcons.extractFileIcon(mixer.processPath);
          }
        }
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    hotKeyManager.unregisterAll();
  }

  Future<void> fetchAudioDevices() async {
    if (!mounted) return;
    audioDevices =
        await AudioExtended.enumDevices(audioDeviceType, audioDevices) ?? [];
    __volume = await Audio.getVolume(audioDeviceType);
    defaultDevice = (await AudioExtended.getDefaultDevice(audioDeviceType))!;

    _audioIcons = {};
    for (var audioDevice in audioDevices) {
      if (_audioIcons[audioDevice.id] == null) {
        _audioIcons[audioDevice.id] = await winIcons
            .extractFileIcon(audioDevice.iconPath, iconID: audioDevice.iconID);
      }
    }

    mixerList = await Audio.enumAudioMixer() ?? [];
    for (var mixer in mixerList) {
      if (_audioIcons[mixer.processPath] == null) {
        _audioIcons[mixer.processPath] =
            await winIcons.extractFileIcon(mixer.processPath);
      }
    }

    setState(() {
      fetchStatus = "Get";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: double.infinity),
            child: //write a widget that expands to the whole screen and has three elements, one on the left and two on the right.
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 100,
                  child: TextButton(
                    child: Text(
                      fetchStatus,
                      style: const TextStyle(color: Colors.white),
                      strutStyle: const StrutStyle(forceStrutHeight: true),
                    ),
                    onPressed: () async {
                      setState(() {
                        fetchStatus = 'Getting...';
                      });
                      fetchAudioDevices();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: FutureBuilder(
            future: localStorage.ready,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!initialized) {
                var tmpAudioDevices =
                    localStorage.getItem("audioDevices") ?? [];

                audioDevices = List<AudioDeviceExtended>.from(
                    (tmpAudioDevices as List)
                        .map((item) => AudioDeviceExtended.fromMap(item)));

                fetchAudioDevices();

                initialized = true;
              }

              for (var element in audioDevices) {
                if (element.hotKey != null) {
                  _handleHotKeyRegister(
                      element.hotKey!, audioDevices.indexOf(element));
                }
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //? VOLUME INFO
                  Flexible(
                    //VOLUME
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Center(
                      child: Text(
                        "Volume:${(__volume * 100).toStringAsFixed(0)}%",
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                  //? VOLUMESCROLLER
                  Flexible(
                    //SLIDER
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Slider(
                      value: __volume,
                      min: 0,
                      max: 1,
                      divisions: 25,
                      onChanged: (e) async {
                        await Audio.setVolume(e.toDouble(), audioDeviceType);
                        __volume = e;
                        setState(() {});
                      },
                    ),
                  ),
                  //? LIST AUDIO DEVICES
                  Flexible(
                      flex: 3,
                      fit: FlexFit.loose,
                      child: ListView.builder(
                          itemCount: audioDevices.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: (_audioIcons
                                        .containsKey(audioDevices[index].id))
                                    ? Image.memory(
                                        _audioIcons[audioDevices[index].id] ??
                                            Uint8List(0),
                                        width: 32,
                                        height: 32,
                                      )
                                    : const Icon(Icons.spoke_outlined),
                                title: Text(audioDevices[index].name),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onSecondaryTap: () async {
                                        if (audioDevices[index].hotKey !=
                                            null) {
                                          _handleHotKeyUnregister(
                                              audioDevices[index].hotKey!);

                                          setState(() {
                                            audioDevices[index].hotKey = null;
                                          });

                                          await localStorage.setItem(
                                              "audioDevices",
                                              audioDevices
                                                  .map((element) =>
                                                      element.toMap())
                                                  .toList());
                                        }
                                      },
                                      onTap: () async {
                                        await showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return RecordHotKeyDialog(
                                              onHotKeyRecorded:
                                                  (newHotKey) async {
                                                if (audioDevices[index]
                                                        .hotKey !=
                                                    null) {
                                                  _handleHotKeyUnregister(
                                                      audioDevices[index]
                                                          .hotKey!);
                                                }
                                                _handleHotKeyRegister(
                                                    newHotKey, index);

                                                setState(() {
                                                  audioDevices[index].hotKey =
                                                      newHotKey;
                                                });
                                                await localStorage.setItem(
                                                    "audioDevices",
                                                    audioDevices
                                                        .map((element) =>
                                                            element.toMap())
                                                        .toList());
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.all(6),
                                          padding: const EdgeInsets.all(3),
                                          constraints: const BoxConstraints(
                                              minWidth: 32, minHeight: 32),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 70, 70, 70),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                          ),
                                          child: (audioDevices[index].hotKey !=
                                                  null)
                                              ? HotKeyVirtualView(
                                                  hotKey: audioDevices[index]
                                                      .hotKey!,
                                                )
                                              : Container()),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                          (audioDevices[index].isActive == true
                                              ? Icons.check_box_outlined
                                              : Icons.check_box_outline_blank)),
                                      onPressed: () async {
                                        await Audio.setDefaultDevice(
                                            audioDevices[index].id);
                                        fetchAudioDevices();
                                        setState(() {});
                                      },
                                    )
                                  ],
                                ));
                          })),
                  const Divider(
                    thickness: 5,
                    height: 10,
                    color: Color.fromARGB(12, 0, 0, 0),
                  ),
                  //? AUDIO MIXER
                  SizedBox(
                    child: CheckboxListTile(
                      title: const Text("Countinously Fetch Audio Mixer"),
                      value: _stateFetchAudioMixerPeak,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (e) {
                        setState(() {
                          _stateFetchAudioMixerPeak = e!;
                        });
                      },
                    ),
                  ),
                  //? LIST AUDIO MIXER
                  Flexible(
                    flex: 3,
                    child: ListView.builder(
                        itemCount: mixerList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const Divider(
                                height: 6,
                                thickness: 3,
                                color: Color.fromARGB(10, 0, 0, 0),
                                indent: 100,
                                endIndent: 100,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                      child: ListTile(
                                          leading: (_audioIcons.containsKey(
                                                  mixerList[index].processPath))
                                              ? Image.memory(
                                                  _audioIcons[mixerList[index]
                                                          .processPath] ??
                                                      Uint8List(0),
                                                  width: 32,
                                                  height: 32,
                                                )
                                              : const Icon(
                                                  Icons.spoke_outlined),
                                          title: Text(
                                              mixerList[index].processPath))),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Column(
                                        children: [
                                          Slider(
                                            value: mixerList[index].maxVolume,
                                            min: 0,
                                            max: 1,
                                            divisions: 25,
                                            onChanged: (e) async {
                                              await Audio.setAudioMixerVolume(
                                                  mixerList[index].processId,
                                                  e.toDouble());
                                              mixerList[index].maxVolume = e;
                                              setState(() {});
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: FAProgressBar(
                                              currentValue: mixerList[index]
                                                      .peakVolume *
                                                  mixerList[index].maxVolume *
                                                  100,
                                              size: 12,
                                              maxValue: 100,
                                              changeColorValue: 100,
                                              changeProgressColor: Colors.pink,
                                              progressColor: Colors.lightBlue,
                                              animatedDuration: const Duration(
                                                  milliseconds: 300),
                                              direction: Axis.horizontal,
                                              verticalDirection:
                                                  VerticalDirection.up,
                                              formatValueFixed: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  )
                ],
              );
            }),
      ),
    );
  }
}
