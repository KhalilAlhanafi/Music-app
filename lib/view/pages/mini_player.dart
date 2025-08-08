import 'package:flutter/material.dart';
import 'package:flutter_application_2/view/pages/audio_manager.dart';
import 'package:flutter_application_2/view/pages/player.dart';
import 'package:just_audio/just_audio.dart';

class MiniPlayer extends StatefulWidget {
  final VoidCallback onExpand;

  const MiniPlayer({super.key, required this.onExpand});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  final _audioPlayer = AudioManager.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: _audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final metadata = snapshot.data?.currentSource?.tag;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: metadata != null
              ? _buildMiniPlayer(metadata)
              : const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildMiniPlayer(dynamic metadata) {
    final title = metadata['title'] ?? 'Loading...';
    final artist = metadata['artist'] ?? '';
    final image = metadata['image'] ?? 'assets/images/default.jpg';

    return GestureDetector(
      key: ValueKey(title), // Unique key for animation switch
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlayerPage(
              songTitle: metadata['title'],
              artist: metadata['artist'],
              imagePath: metadata['image'],
              audioPath:
                  '', // Optional: you don't need to re-pass audioPath since it's already playing
            ),
          ),
        );
      },

      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            // Album Art
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // Title & Artist
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            // Play/Pause Button
            StreamBuilder<bool>(
              stream: _audioPlayer.playingStream,
              builder: (context, snapshot) {
                final isPlaying = snapshot.data ?? false;
                return IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    isPlaying ? _audioPlayer.pause() : _audioPlayer.play();
                  },
                );
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
