import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  final double height;

  const HorizontalDivider({this.height});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height ?? 1.0,
      width: width,
      color: theme.dividerColor,
    );
  }
}
