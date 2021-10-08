import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
export 'package:last_fm_challenge/utilities/image_urls.dart';

class ImageWidget extends StatelessWidget {
  final String iconName;
  final double width;
  final double height;
  final BoxFit fit;
  final Color color;
  final AlignmentGeometry alignment;

  const ImageWidget(
    this.iconName, {
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.alignment = Alignment.center, // default value taken from flutters Image widget
  });

  @override
  Widget build(BuildContext context) {
    if (this.iconName.endsWith('.svg')) {
      return SvgPicture.asset(
        this.iconName,
        width: this.width,
        height: this.height,
        fit: this.fit,
        color: this.color,
        alignment: this.alignment,
      );
    }
    return Image.asset(
      this.iconName,
      width: this.width,
      height: this.height,
      fit: this.fit,
      color: this.color,
      alignment: this.alignment,
    );
  }
}
