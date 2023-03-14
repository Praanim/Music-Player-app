part of 'music_player_bloc.dart';

abstract class MusicPlayerEvent extends Equatable {
  const MusicPlayerEvent();

  @override
  List<Object> get props => [];
}

class OnButtonTapEvent extends MusicPlayerEvent {
  final bool isPlaying;
  OnButtonTapEvent({
    required this.isPlaying,
  });
}
