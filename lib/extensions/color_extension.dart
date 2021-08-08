import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

extension ColorExtension on Color {
  Color get combineWhite40 => Color.alphaBlend(Colors.white.withOpacity(.4), this);

  Color get combineWhite55 => Color.alphaBlend(Colors.white.withOpacity(.55), this);

  Color get combineWhite70 => Color.alphaBlend(Colors.white.withOpacity(.7), this);

  Color get combineWhite90 => Color.alphaBlend(Colors.white.withOpacity(.9), this);

  MaterialColor get materialColor {
    final Map<int, Color> swatch = {};
    final shadeValues = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
    final primaryShade = 500;
    shadeValues.forEach((shade) {
      if (shade <= primaryShade) {
        final double _opacity = 1.0 - (1.0 / primaryShade.toDouble() * shade);
        swatch.putIfAbsent(shade, () => Color.alphaBlend(Colors.white.withOpacity(_opacity), this));
      } else {
        final double _opacity = 1.0 / primaryShade.toDouble() * (shade - primaryShade);
        swatch.putIfAbsent(shade, () => Color.alphaBlend(Colors.black.withOpacity(_opacity), this));
      }
    });

    return MaterialColor(this.value, swatch);
  }
}
