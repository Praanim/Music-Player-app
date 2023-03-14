import 'package:flutter/material.dart';
import 'package:music_player_app/constants/color_pallete.dart';

import '../../constants/utils.dart';

class MusicImageCard extends StatelessWidget {
  final double diameter;
  String? imageUrl; //aile initial phase ko lagi
  Widget? child;
  Color? color;

  MusicImageCard(
      {Key? key, required this.diameter, this.imageUrl, this.child, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
          border: Border.all(color: Constants.secBackgrdColor, width: 3),
          image: imageUrl == null
              ? null
              : const DecorationImage(
                  image: NetworkImage(
                    Utils.imageUrl,
                  ),
                  fit: BoxFit.cover),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(106, 255, 255, 255),
              offset: Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 0.1,
            ),
            BoxShadow(
              color: Color.fromARGB(197, 0, 0, 0),
              offset: Offset(8, 5),
              blurRadius: 10.0,
              spreadRadius: 0.1,
            ),
          ],
          shape: BoxShape.circle,
          color: color ?? Constants.secBackgrdColor),
      child: imageUrl == null ? child : null,
    );
  }
}
