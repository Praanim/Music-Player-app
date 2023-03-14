import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'music_player_event.dart';
part 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final _player = AudioPlayer();
  bool _isMusicPlaying =
      true; //(this variable was just created so that in update positon ma musicPlaying cha ki nai thahapauna)

  var duration = '';
  var position = '';

  var max = 0.0;
  var value = 0.0;

  MusicPlayerBloc() : super(MusicPlayerInitial()) {
    on<OnButtonTapEvent>((event, emit) {
      if (event.isPlaying) {
        _player.pause();
        _isMusicPlaying = false;
        emit(MusicStatus(
            isMusicPlaying: _isMusicPlaying,
            duration: duration,
            position: position));
      } else {
        _isMusicPlaying = true;

        emit(MusicStatus(
            isMusicPlaying: _isMusicPlaying,
            duration: duration,
            position: position));

        _player
            .play(); //eslai emit mathi rakheko vaye play complete huni bela samma kurthyo
      }
    });
    updatePosition();
  }

  //first time song play huda
  void playSong({String? uri}) async {
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(uri!)));

      _player.play();
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  //update position of the slider
  updatePosition() {
    _player.durationStream.listen((d) {
      print(d.toString());
      duration = d.toString().split('.')[0];
      max = d!.inSeconds.toDouble();
    });

    _player.positionStream.listen((pos) {
      position = pos.toString().split('.')[0];
      value = pos.inSeconds.toDouble();

      emit(MusicStatus(
          isMusicPlaying: _isMusicPlaying,
          duration: duration,
          position:
              position)); //yo emit garena vaney continously change hudaina
    });
  }

  //use slider to skip to certain position of the song
  changeSecondsToDuration(seconds) {
    var duration = Duration(seconds: seconds);
    _player.seek(duration);
  }

  //for pausing the song
  void pauseSong() async {
    await _player.pause();
  }

//clears out all the resources
  void stopSong() async {
    await _player.stop();
  }
}
