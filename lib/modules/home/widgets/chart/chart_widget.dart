import 'package:flutter/material.dart';
import 'package:my_vocation_app/core/core.dart';

class ChartWidget extends StatefulWidget {
  final double percent;
  const ChartWidget({super.key, required this.percent});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween(begin: 0.0, end: widget.percent).animate(_controller);

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) => Stack(
          children: [
            Center(
              child: Container(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: _animation.value,
                  strokeWidth: 10,
                  backgroundColor: AppColors.chartSecondary,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.chartPrimary),
                ),
              ),
            ),
            Center(
              child: Text(
                "${(_animation.value * 100).toInt()}%",
                style: AppTextStyles.heading,
              ),
            )
          ],
        ),
      ),
    );
  }
}
