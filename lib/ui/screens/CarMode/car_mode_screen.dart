import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '/ui/player/player_controller.dart';

class CarModeScreen extends StatefulWidget {
  const CarModeScreen({super.key});

  @override
  State<CarModeScreen> createState() => _CarModeScreenState();
}

class _CarModeScreenState extends State<CarModeScreen> {
  final PlayerController playerController = Get.find<PlayerController>();

  @override
  void initState() {
    super.initState();
    // Enable Wakelock
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    // Disable Wakelock
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Exit Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Text(
                    "Car Mode",
                    style: TextStyle(
                      color: Color(0xFF00FFFF), // Neon Blue
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 32),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Song Info
                    Obx(() {
                      final song = playerController.currentSong.value;
                      return Column(
                        children: [
                          Text(
                            song?.title ?? "No Song",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            song?.artist ?? "Unknown Artist",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      );
                    }),

                    const SizedBox(height: 50),

                    // Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Previous
                        IconButton(
                          iconSize: 80,
                          icon: const Icon(Icons.skip_previous, color: Colors.white),
                          onPressed: playerController.prev,
                        ),

                        const SizedBox(width: 20),

                        // Play/Pause
                        Obx(() {
                          final isPlaying = playerController.buttonState.value == PlayButtonState.playing;
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF00FFFF), // Neon Blue
                                width: 4,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFF00FFFF),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ]
                            ),
                            child: IconButton(
                              iconSize: 100,
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: const Color(0xFF00FFFF), // Neon Blue
                              ),
                              onPressed: playerController.playPause,
                            ),
                          );
                        }),

                        const SizedBox(width: 20),

                        // Next
                        IconButton(
                          iconSize: 80,
                          icon: const Icon(Icons.skip_next, color: Colors.white),
                          onPressed: playerController.next,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
