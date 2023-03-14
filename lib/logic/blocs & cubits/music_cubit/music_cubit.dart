import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';
part 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  final _audioQuery = OnAudioQuery();
  MusicCubit() : super(MusicInitial());

  checkPermmision() async {
    try {
      var permission = await Permission.storage.request();
      if (permission.isGranted) {
        final listOfSongs = await getSongs();
        emit(MusicList(songs: listOfSongs));
      } else {
        emit(ErrorState(
            message: "Permission Given Status : ${permission.isGranted}"));
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<List<SongModel>> getSongs() async {
    final listofSongs = await _audioQuery.querySongs();
    print(listofSongs[0]);
    return listofSongs;
  }
}
