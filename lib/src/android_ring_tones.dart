import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
//import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
//import 'package:flutter_sound_lite/flutter_sound.dart' as flutter_sound;



class AndroidRingTones extends StatefulWidget {
  const AndroidRingTones({super.key});

  @override
  State<AndroidRingTones> createState() => _AndroidRingTonesState();
}

class _AndroidRingTonesState extends State<AndroidRingTones> {
  List ringtones = [];
  var player = FlutterSoundPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Android Ring Tones'),
      ),
      body: Center(
        child: Column(
          children: [
            if (ringtones.isNotEmpty)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: ringtones.length,
                itemBuilder: (_, index) {
                  print('Ringtone index: $index');
                  final ringtone = ringtones[index];
                  return Card(
                    child: ListTile(
                      /* onTap: () async {
                        player = (await player.openPlayer())!;
                        player.startPlayer(
                          fromURI: '/system/media/audio/ringtones/$ringtone.ogg',
                          codec: Codec.opusOGG,
                        );
                      }, */
                      title: Text(ringtone),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                print(  'Getting ringtones...' );
                const channel = MethodChannel('flutter_channel');
                ringtones = await channel.invokeMethod('getRingtones');
                setState(() {});
              },
              child: const Text('Get Ringtones'),
            ),
          ],
        ),
      ),
    );
  }
}