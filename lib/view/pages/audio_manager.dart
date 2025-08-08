import 'package:just_audio/just_audio.dart';

class AudioManager {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static AudioPlayer get instance => _audioPlayer;
}
