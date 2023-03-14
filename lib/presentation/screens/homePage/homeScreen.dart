import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_app/constants/utils.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../../../common/widgets/music_player_card.dart';
import '../../../constants/color_pallete.dart';
import '../../../logic/blocs & cubits/music_cubit/music_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late List<SongModel> songs;

  @override
  void initState() {
    BlocProvider.of<MusicCubit>(context).checkPermmision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "My",
              style: TextStyle(color: Constants.customWhiteColor, fontSize: 24),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Music",
              style: TextStyle(color: Constants.primaryColor, fontSize: 22),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _makeHeadingContainer(),
          Expanded(child: BlocBuilder<MusicCubit, MusicState>(
            builder: (context, state) {
              if (state is MusicList) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final song = state.songs[index];
                    return Card(
                      color: Constants.mainBackgrdColor,
                      child: ListTile(
                        leading: QueryArtworkWidget(
                            nullArtworkWidget: const CircleAvatar(
                              backgroundImage: NetworkImage(Utils.imageUrl),
                            ),
                            id: song.id,
                            type: ArtworkType.AUDIO),
                        title: Text(
                          song.displayName,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        subtitle: Text(
                          song.artist ?? "No data",
                          style: TextStyle(
                              fontSize: 16, color: Constants.customWhiteColor),
                        ),
                        onTap: () {
                          //navigate to music player
                          Navigator.of(context).pushNamed('/music-player',
                              arguments: {'songModel': song});
                        },
                        trailing: IconButton(
                            onPressed: () {
                              //add to favourites
                            },
                            icon: const Icon(
                              Icons.favorite,
                              size: 15,
                              color: Constants.primaryColor,
                            )),
                      ),
                    );
                  },
                  itemCount: state.songs.length,
                );
              } else if (state is ErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            },
          ))
        ],
      ),
    );
  }

  _makeHeadingContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: MusicImageCard(
              diameter: 150,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    //add to favourites
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Constants.primaryColor,
                  )),
              MusicImageCard(
                diameter: 60,
                color: Constants.primaryColor,
                child: IconButton(
                    onPressed: () {
                      //pause or play the music
                      print('Button is working');
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Constants.customWhiteColor,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
