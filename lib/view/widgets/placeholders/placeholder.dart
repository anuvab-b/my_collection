import 'package:flutter/material.dart';

class BannerPlaceholder extends StatelessWidget {
  final Color backgroundColor;
  final double width;
  final double height;
  final double borderRadius;

  const BannerPlaceholder(
      {Key? key,
      this.backgroundColor = Colors.white,
      this.width = 200,
      this.height = 200,
      this.borderRadius = 12.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
      ),
    );
  }
}
