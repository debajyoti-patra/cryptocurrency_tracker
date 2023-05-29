import 'package:flutter/material.dart';

class TileDetail extends StatelessWidget {
  final String header;
  final String detail;
  final CrossAxisAlignment alignment;
  const TileDetail(
      {Key? key,
      required this.header,
      required this.detail,
      required this.alignment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          header,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          detail,
          style: const TextStyle(fontSize: 15),
        )
      ],
    );
  }
}
