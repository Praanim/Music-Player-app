part of 'music_cubit.dart';

@immutable
abstract class MusicState {}

class MusicInitial extends MusicState {}

//this is the state where we will have out list of music(songModel)
//retrieved from the device storage
class MusicList extends MusicState {
  final List<SongModel> songs;
  MusicList({
    required this.songs,
  });
}

class ErrorState extends MusicState {
  final String message;
  ErrorState({
    required this.message,
  });
}
