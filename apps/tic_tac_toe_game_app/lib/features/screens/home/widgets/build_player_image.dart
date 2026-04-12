// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tic_tac_toe_game_app/core/constants/enum_all.dart';

class BuildPlayerImage extends StatelessWidget {
  const BuildPlayerImage({Key? key, required this.player}) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      player.imagePath,
      fit: BoxFit.contain,
      width: 80,
      height: 80,
    );
  }
}
