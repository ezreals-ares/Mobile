import 'package:flutter/material.dart';

import 'lyrics.dart';

void main() {
  runApp(const LyricsApp());
}

class LyricsApp extends StatelessWidget {
  const LyricsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lyrics App',
      home: const LyricsPage(),
    );
  }
}

class LyricsPage extends StatelessWidget {
  const LyricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spotify KW'), centerTitle: true),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Marry Chrismast, I Miss You',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 30),

                      Text(
                        lyrics[0].text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),

                      const SizedBox(height: 30),

                      Text(
                        lyrics[1].text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),

                      const SizedBox(height: 30),

                      Text(
                        lyrics[2].text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),

                      const SizedBox(height: 30),

                      Text(
                        lyrics[3].text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),

                      const SizedBox(height: 30),

                      Text(
                        lyrics[4].text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Previous
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous, size: 35),
                  ),

                  // Play / Pause
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.play_circle_fill, size: 55),
                  ),

                  // Next
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next, size: 35),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
