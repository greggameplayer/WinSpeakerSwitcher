import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:win_speaker_switcher/models/home/home.dart';
import '../../widgets/animated_progress_bar.dart';
import '../../widgets/record_hotkey_dialog.dart';
import 'home_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 150), (timer) async {
      ref.read(homeNotifierProvider.notifier).audioMixersUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Home> homeNotifier = ref.watch(homeNotifierProvider);
    return homeNotifier.when(
        data: (home) {
          return Scaffold(
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
                        onPressed:
                        ref.read(homeNotifierProvider.notifier).onPressGetButton,
                        child: Text(
                          home.fetchStatus,
                          style: const TextStyle(color: Colors.white),
                          strutStyle: const StrutStyle(forceStrutHeight: true),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: FutureBuilder(
                future: ref
                    .read(homeNotifierProvider.notifier)
                    .service
                    .localStorage
                    .ready,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
                            "Volume:${(home.volume * 100).toStringAsFixed(0)}%",
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
                          value: home.volume,
                          min: 0,
                          max: 1,
                          divisions: 25,
                          onChanged:
                          ref.read(homeNotifierProvider.notifier).onChangedSlider,
                        ),
                      ),
                      //? LIST AUDIO DEVICES
                      Flexible(
                          flex: 3,
                          fit: FlexFit.loose,
                          child: ListView.builder(
                              itemCount: home.audioDevices.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    leading: (home.audioIcons.containsKey(
                                        home.audioDevices[index].id))
                                        ? Image.memory(
                                      ref.read(homeNotifierProvider.notifier).getIcon(home.audioDevices[index].id),
                                      width: 32,
                                      height: 32,
                                    )
                                        : const Icon(Icons.spoke_outlined),
                                    title: Text(
                                        home.audioDevices[index].name),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onSecondaryTap: () async => ref
                                              .read(homeNotifierProvider.notifier)
                                              .onSecondaryTapShortcutButton(index),
                                          onTap: () async {
                                            await showDialog<void>(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return RecordHotKeyDialog(
                                                    onHotKeyRecorded:
                                                        (newHotKey) async => ref
                                                        .read(homeNotifierProvider
                                                        .notifier)
                                                        .onHotKeyRecorded(
                                                        newHotKey, index));
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
                                              child: (home
                                                  .audioDevices[index]
                                                  .hotKey !=
                                                  null)
                                                  ? HotKeyVirtualView(
                                                hotKey: home
                                                    .audioDevices[index]
                                                    .hotKey!,
                                              )
                                                  : Container()),
                                        ),
                                        IconButton(
                                            icon: Icon((home
                                                .audioDevices[index]
                                                .isActive ==
                                                true
                                                ? Icons.check_box_outlined
                                                : Icons.check_box_outline_blank)),
                                            onPressed: () async => ref
                                                .read(homeNotifierProvider.notifier)
                                                .setDefaultDevice(index))
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
                          value: home.stateFetchAudioMixerPeak,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: ref
                              .read(homeNotifierProvider.notifier)
                              .onChangedContinuouslyFetchCheckbox,
                        ),
                      ),
                      //? LIST AUDIO MIXER
                      Flexible(
                        flex: 3,
                        child: ListView.builder(
                            itemCount: home.mixerList.length,
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
                                              leading: (home.audioIcons.containsKey(
                                                  home
                                                      .mixerList[index]
                                                      .processPath))
                                                  ? Image.memory(
                                                ref.read(homeNotifierProvider.notifier).getIcon(home
                                                    .mixerList[index]
                                                    .processPath),
                                                width: 32,
                                                height: 32,
                                              )
                                                  : const Icon(Icons.spoke_outlined),
                                              title: Text(home
                                                  .mixerList[index].processPath))),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 20),
                                          child: Column(
                                            children: [
                                              Slider(
                                                value: home.mixerList[index].maxVolume,
                                                min: 0,
                                                max: 1,
                                                divisions: 25,
                                                onChanged: (e) async => ref
                                                    .read(
                                                    homeNotifierProvider.notifier)
                                                    .onChangedProcessSlider(e, index),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 25),
                                                child: FAProgressBar(
                                                  currentValue: home
                                                      .mixerList[index]
                                                      .peakVolume *
                                                      home
                                                          .mixerList[index]
                                                          .maxVolume *
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
          );
        },
        loading: () {
          ref.read(homeNotifierProvider.notifier).init();
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          if (kDebugMode) {
            print(error);
          }

          return const Center(
            child: Text("Error"),
          );
        });


  }
}
