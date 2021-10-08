import 'package:flutter/material.dart';
import 'package:last_fm_challenge/utilities/colors.dart';
import 'package:last_fm_challenge/utilities/sizes.dart';

class DividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ThemeColors.border.secondary,
      thickness: 0.5,
      height: 0.5,
      indent: Sizes.padding.standard,
      endIndent: Sizes.padding.standard,
    );
  }
}
