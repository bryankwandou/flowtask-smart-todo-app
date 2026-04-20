import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flowtask/core/theme/colors.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerLoading.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        );

  const ShimmerLoading.circular({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surface,
      highlightColor: AppColors.surfaceLight,
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: AppColors.textMuted,
          shape: shapeBorder,
        ),
      ),
    );
  }
}

class ShimmerTaskList extends StatelessWidget {
  const ShimmerTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShimmerLoading.rectangular(height: 100),
              const SizedBox(height: 8),
              Row(
                children: const [
                  ShimmerLoading.circular(width: 40, height: 20),
                  SizedBox(width: 8),
                  ShimmerLoading.circular(width: 60, height: 20),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
