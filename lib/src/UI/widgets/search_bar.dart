import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/src/bloc/music_cubit/music_cubit.dart';
import 'package:music_player_app/src/bloc/player_cubit/player_cubit.dart';

import '../../injections/get_it.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = getItInstance<AudioPlayer>();

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 234, 234, 234),
        border: Border(
          bottom: BorderSide(
            width: 1.4,
            color: Color.fromARGB(255, 181, 181, 181),
          ),
        ),
      ),
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Search Artirs',
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            errorBorder: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.blue),
            ),
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          onChanged: (query) {
            if (_debounce?.isActive ?? false) _debounce!.cancel();
            _debounce = Timer(
              const Duration(seconds: 1),
              () async {
                await context.read<PlayerCubit>().unloadTrack();
               await context.read<MusicCubit>().loadMusic(query: query);
              },
            );
          },
        ),
      ),
    );
  }
}
