import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_app/src/bloc/music_cubit/music_cubit.dart';
import 'package:music_player_app/src/bloc/player_cubit/player_cubit.dart';
import 'package:music_player_app/src/bloc/player_cubit/player_state_enum.dart';

class ItemWidget extends StatefulWidget {
  final Function() onTap;
  final String imageUrl;
  final String songName;
  final String artistName;
  final String albumName;
  final int index;

  const ItemWidget({
    Key? key,
    required this.onTap,
    required this.imageUrl,
    required this.songName,
    required this.artistName,
    required this.albumName,
    required this.index,
  }) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    final PlayerCubit musicPlayerCubit = context.watch<PlayerCubit>();
    final mediaQuary = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: mediaQuary.width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 234, 234, 234),
          border: Border(
            bottom: BorderSide(
              width: 1.4,
              color: Color.fromARGB(255, 181, 181, 181),
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 181, 181, 181),
                  ),
                ),
                child: CachedNetworkImage(
                    errorWidget: (context, url, error) {
                      return Container(
                        color: const Color.fromARGB(255, 55, 55, 55),
                        child: const Center(child: Icon(Icons.error)),
                      );
                    },
                    progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                          padding: const EdgeInsets.all(12),
                          child: CircularProgressIndicator(value: downloadProgress.progress),
                        ),
                    imageUrl: widget.imageUrl),
              ),
            ),
            BlocBuilder<MusicCubit, MusicCubitState>(
              builder: (BuildContext context, state) {
                return Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.songName,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 84, 83, 83),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                widget.artistName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 114, 114, 114),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                widget.albumName,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color.fromARGB(255, 145, 143, 143),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        musicPlayerCubit.state.playerState == MusicPlayerState.playing &&
                                state.currentIndex == widget.index
                            ? Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'lib/assets/sound.gif',
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 181, 181, 181),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
