


import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget{
  const CarouselImage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,

        ),
      ),
    );
  }
}