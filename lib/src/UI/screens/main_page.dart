import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:music_player_app/src/UI/widgets/music_list_widgets.dart';
import 'package:music_player_app/src/UI/widgets/music_player.dart';
import 'package:music_player_app/src/UI/widgets/search_bar.dart';
import 'package:music_player_app/src/bloc/music_cubit/music_cubit.dart';
import 'package:music_player_app/src/bloc/player_cubit/player_cubit.dart';
import 'package:music_player_app/src/injections/get_it.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MusicCubit musicCubit;
  late PlayerCubit playerCubit;

  @override
  void initState() {
    musicCubit = getItInstance<MusicCubit>();
    playerCubit = getItInstance<PlayerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => musicCubit,
        ),
        BlocProvider(
          create: (context) => playerCubit,
        ),
      ],
      child: SafeArea(
        child: Column(
          children: const [
            SearchBar(),
            Flexible(child: MusicListItems()),
            MusicPlayer(),
          ],
        ),
      ),
    );
  }
}
