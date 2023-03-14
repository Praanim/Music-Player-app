import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_app/presentation/screens/homePage/homeScreen.dart';
import 'package:music_player_app/presentation/screens/music_player_screen/music_player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../logic/blocs & cubits/music_cubit/music_cubit.dart';
import '../logic/blocs & cubits/music_player_bloc/music_player_bloc.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MusicCubit>(
            create: (context) => MusicCubit(),
            child: HomePage(),
          ),
        );

      case '/music-player':
        final temp = settings.arguments as Map;
        final songModel = temp['songModel'] as SongModel;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MusicPlayerBloc>(
            create: (context) => MusicPlayerBloc()..emit(MusicStatus()),
            child: MusicPlayerScreen(
              songModel: songModel,
            ),
          ),
        );

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(
                    child: Text("U are in Heaven...haha"),
                  ),
                ));
    }
  }
}
