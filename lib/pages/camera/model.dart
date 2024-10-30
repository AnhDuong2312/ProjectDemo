

import 'package:flutter/material.dart';

///ISO Card formats
///https://www.iso.org/standard/70483.html
enum OverlayFormat {

  normal,
  normalColorBlack
}
enum OverlayOrientation { landscape, portrait }

abstract class OverlayModel {
  ///ratio between maximum allowable lengths of shortest and longest sides
  double? ratio;

  ///ratio between maximum allowable radius and maximum allowable length of shortest side
  double? cornerRadius;

  ///natural orientation for overlay
  OverlayOrientation? orientation;

  ///color overlay
  Color? color;
}

class CardOverlay implements OverlayModel {
  CardOverlay(
      {this.ratio = 1.5,
      this.cornerRadius = 0,
      this.orientation = OverlayOrientation.landscape, this.color = Colors.black54});

  @override
  double? ratio;
  @override
  double? cornerRadius;
  @override
  OverlayOrientation? orientation;
  @override
  Color? color;

  static byFormat(OverlayFormat format) {
    switch (format) {
      case (OverlayFormat.normal):
        return CardOverlay(ratio: 1.59, cornerRadius: 0.05);
      case (OverlayFormat.normalColorBlack):
        return CardOverlay(ratio: 1.59, cornerRadius: 0.05, color: Colors.black);

    }
  }
}
