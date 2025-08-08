// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_2/view/pages/audio_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerPage extends StatefulWidget {
  final String songTitle;
  final String artist;
  final String imagePath;
  final String audioPath;

  const PlayerPage({
    super.key,
    required this.songTitle,
    required this.artist,
    required this.imagePath,
    required this.audioPath,
  });

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final _audioPlayer = AudioManager.instance;
  bool isShuffling = false;
  LoopMode loopMode = LoopMode.off;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage(widget.imagePath), context);
  }

  Future<void> _initAudioPlayer() async {
    try {
      await _audioPlayer.setAudioSource(
        AudioSource.asset(
          widget.audioPath,
          tag: {
            'title': widget.songTitle,
            'artist': widget.artist,
            'image': widget.imagePath,
          },
        ),
      );
    } catch (e) {
      debugPrint("Error loading audio: $e");
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_downward),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Album Art
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Song Title and Artist
            FittedBox(
              child: Text(
                widget.songTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FittedBox(
              child: Text(
                widget.artist,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 60),

            // 🎛️ Overlay buttons above control buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 🎶 Queue above Shuffle
                IconButton(
                  icon: const Icon(Icons.queue_music),
                  onPressed: () {
                    _showQueuePopup(context);
                  },
                ),

                // ❤️ Favorite above Play/Pause (centered)
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () async {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool(widget.songTitle, isFavorite);
                  },
                ),

                // ➕ Add above Repeat
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added to playlist'),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.grey,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Progress Bar
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 8,
                        ),
                        activeTrackColor: const Color.fromARGB(255, 1, 53, 95),
                        inactiveTrackColor: Colors.grey[300],
                        trackHeight: 4,
                      ),
                      child: Slider(
                        min: 0,
                        max:
                            positionData?.duration.inMilliseconds.toDouble() ??
                            1,
                        value:
                            positionData?.position.inMilliseconds.toDouble() ??
                            0,
                        onChanged: (value) {
                          _audioPlayer.seek(
                            Duration(milliseconds: value.toInt()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(
                              positionData?.position ?? Duration.zero,
                            ),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _formatDuration(
                              positionData?.duration ?? Duration.zero,
                            ),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),

            // Controls row1

            //controls row2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    isShuffling ? Icons.shuffle_on : Icons.shuffle,
                    color: isShuffling ? const Color(0xFF6657E7) : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isShuffling = !isShuffling;
                    });
                    _audioPlayer.setShuffleModeEnabled(isShuffling);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 40,
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                StreamBuilder<bool>(
                  stream: _audioPlayer.playingStream,
                  builder: (context, snapshot) {
                    final isPlaying = snapshot.data ?? false;
                    return IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        size: 60,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          _audioPlayer.pause();
                        } else {
                          _audioPlayer.play();
                        }
                      },
                    );
                  },
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 40,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    loopMode == LoopMode.off
                        ? Icons.repeat
                        : loopMode == LoopMode.all
                        ? Icons.repeat_on
                        : Icons.repeat_one_on,
                    color: loopMode == LoopMode.off
                        ? Colors.grey
                        : const Color(0xFF6657E7),
                  ),
                  onPressed: () {
                    setState(() {
                      if (loopMode == LoopMode.off) {
                        loopMode = LoopMode.all;
                      } else if (loopMode == LoopMode.all) {
                        loopMode = LoopMode.one;
                      } else {
                        loopMode = LoopMode.off;
                      }
                    });
                    _audioPlayer.setLoopMode(loopMode);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return hours > 0
        ? '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}'
        : '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  void _showQueuePopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.builder(
          itemCount: 10, // replace with your actual queue
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.music_note),
              title: Text('Song ${index + 1}'),
              subtitle: Text('Artist ${index + 1}'),
              onTap: () {
                // jump to that song in queue if you manage it
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
