import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final ImageProvider? bgImage;
  const BackgroundImage({super.key, this.bgImage});

  static const fallback =
  AssetImage('assets/images/bg.png', package: 'jio_ird');

  @override
  Widget build(BuildContext context) {
    if (bgImage == null) {
      return const Image(image: fallback, fit: BoxFit.cover);
    }

    return Image(
      image: bgImage!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
      const Image(image: fallback, fit: BoxFit.cover),
    );
  }
}