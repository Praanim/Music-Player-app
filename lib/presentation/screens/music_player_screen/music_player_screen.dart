import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_app/logic/blocs%20&%20cubits/music_player_bloc/music_player_bloc.dart';

import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_player_app/common/widgets/music_player_card.dart';
import 'package:music_player_app/constants/color_pallete.dart';

class MusicPlayerScreen extends StatefulWidget {
  final SongModel songModel;
  MusicPlayerScreen({
    Key? key,
    required this.songModel,
  }) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  bool isPlaying = true;

  @override
  void initState() {
    BlocProvider.of<MusicPlayerBloc>(context)
        .playSong(uri: widget.songModel.uri);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                BlocProvider.of<MusicPlayerBloc>(context).stopSong();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          title: const Text(
            "PLAYING NOW",
            style: TextStyle(color: Constants.customWhiteColor),
          ),
        ),
        body: Column(
          children: [
            MusicImageCard(
              diameter: MediaQuery.of(context).size.height * 0.4,
              child: QueryArtworkWidget(
                  id: widget.songModel.id, type: ArtworkType.AUDIO),
            ),
            BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
              builder: (context, state) {
                if (state is MusicStatus) {
                  return Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    // color: Colors.blue,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.songModel.displayName,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.songModel.artist ?? "Not Specified",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Constants.customWhiteColor),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  //add to favourites
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: Constants.primaryColor,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Text(
                                state.position,
                                style: TextStyle(
                                    color: Constants.customWhiteColor),
                              ),
                            ),
                            Expanded(
                                child: Slider(
                              thumbColor: Constants.primaryColor,
                              activeColor: Constants.primaryColor,
                              inactiveColor: Constants.customWhiteColor,
                              min: const Duration(seconds: 0)
                                  .inSeconds
                                  .toDouble(),
                              max: context.read<MusicPlayerBloc>().max,
                              value: context.read<MusicPlayerBloc>().value,
                              onChanged: (value) {
                                //do something
                                context
                                    .read<MusicPlayerBloc>()
                                    .changeSecondsToDuration(value.toInt());
                              },
                            )),
                            Text(
                              state.duration,
                              style:
                                  TextStyle(color: Constants.customWhiteColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.skip_previous_rounded,
                                  color: Constants.customWhiteColor,
                                  size: 40,
                                )),
                            CircleAvatar(
                              backgroundColor: Constants.primaryColor,
                              radius: 35,
                              child: Transform.translate(
                                  offset: Offset(-10, -10),
                                  child: IconButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {
                                        BlocProvider.of<MusicPlayerBloc>(
                                                context)
                                            .add(OnButtonTapEvent(
                                                isPlaying: isPlaying));
                                      },
                                      icon: BlocBuilder<MusicPlayerBloc,
                                          MusicPlayerState>(
                                        buildWhen: (previous, current) {
                                          //previous ko ra current ko equal vayena vaney matra build
                                          final bool = (previous
                                                      is MusicStatus &&
                                                  previous.isMusicPlaying) !=
                                              (current is MusicStatus &&
                                                  current.isMusicPlaying);

                                          return bool;
                                        },
                                        builder: (context, state) {
                                          if (state is MusicStatus) {
                                            isPlaying = state.isMusicPlaying;

                                            return Icon(
                                              isPlaying
                                                  ? Icons.pause_circle_rounded
                                                  : Icons.play_arrow_rounded,
                                              color: Constants.customWhiteColor,
                                              size: 54,
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ))),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.skip_next_rounded,
                                    color: Constants.customWhiteColor,
                                    size: 40)),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ));
  }
}
