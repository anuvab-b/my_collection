import 'package:flutter/material.dart';
import 'package:my_collection/view/widgets/placeholders/placeholder.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLayout extends StatelessWidget {
  final double layoutHeight;
  final double itemHeight;
  final double itemWidth;
  final double borderRadius;
  final bool isList;

  const ShimmerLayout({
    Key? key,
    this.itemHeight = 100.0,
    this.itemWidth = 100.0,
    this.layoutHeight = 100.0,
    this.borderRadius = 8.0,
    this.isList = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: layoutHeight,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: isList?5:1,
          itemBuilder: (ctx, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  baseColor: Colors.grey.shade900,
                  highlightColor: Colors.grey.shade800,
                  period: const Duration(milliseconds: 1500),
                  enabled: true,
                  child: BannerPlaceholder(
                      borderRadius: borderRadius,
                      width: itemWidth,
                      height: itemHeight)),
            );
          }),
    );
  }
}
