part of 'music_player_bloc.dart';

abstract class MusicPlayerState extends Equatable {
  const MusicPlayerState();

  @override
  List<Object> get props => [];
}

class MusicPlayerInitial extends MusicPlayerState {}

//to know the status of the music like isplaying or not
class MusicStatus extends MusicPlayerState {
  String duration;
  String position;
  bool isMusicPlaying;
  MusicStatus({
    this.duration = '',
    this.position = '',
    this.isMusicPlaying = true,
  });

  @override
  List<Object> get props => [isMusicPlaying, position];
}

class ErrorState extends MusicPlayerState {
  final String message;
  ErrorState({
    required this.message,
  });
}
