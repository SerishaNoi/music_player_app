import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_app/src/UI/widgets/item_widget.dart';
import 'package:music_player_app/src/bloc/music_cubit/music_cubit.dart';
import 'package:music_player_app/src/bloc/player_cubit/player_cubit.dart';

class MusicListItems extends StatefulWidget {
  const MusicListItems({Key? key}) : super(key: key);

  @override
  State<MusicListItems> createState() => _MusicListItemsState();
}

class _MusicListItemsState extends State<MusicListItems> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicCubit, MusicCubitState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.music.length,
          itemBuilder: (context, index) {
            return ItemWidget(
              onTap: () {
                final music = context.read<MusicCubit>().selectedMusic(index);
                context.read<PlayerCubit>().loadTrack(music);
              },
              index: index,
              albumName: state.music[index].collectionName,
              artistName: state.music[index].artistName,
              songName: state.music[index].trackName,
              imageUrl: state.music[index].artworkUrl100,
            );
          },
        );
      },
    );
  }
}
