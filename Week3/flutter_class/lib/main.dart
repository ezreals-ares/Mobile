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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Spotify KW'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'I Miss You',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Image.asset(
                'assets/MIMU.webp',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 20),

              Text(
                lyrics[0].text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                lyrics[1].text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,

                ),
              ),

              const SizedBox(height: 30),

              Text(
                lyrics[2].text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                lyrics[3].text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                lyrics[4].text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {},
                child: const Text('Play Music'),
              ),

              const SizedBox(height: 10),

              OutlinedButton(
                onPressed: () {},
                child: const Text('Favorite'),
              ),

              const SizedBox(height: 10),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Masukkan nama',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('I Miss You'),
                  subtitle: const Text('Song Lyrics'),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

