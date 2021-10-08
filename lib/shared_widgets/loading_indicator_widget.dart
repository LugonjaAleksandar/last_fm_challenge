import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class LoadingIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Double container with a border prevents appearance of the unwanted border
    /// between two identically coloured containers due to antialiasing
    return Container(
      color: _backgroundColorForType(),
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColorForType(),
          border: BorderDirectional(
            bottom: BorderSide(color: _backgroundColorForType()),
          ),
        ),
        child: Center(
          child: Container(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Color _backgroundColorForType() {
    return Colors.transparent;
  }
}
