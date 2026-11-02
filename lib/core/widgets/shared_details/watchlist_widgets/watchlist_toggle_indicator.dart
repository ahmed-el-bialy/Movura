import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movura/core/theming/app_colors.dart';

class WatchlistToggleIndicator extends StatefulWidget {
  const WatchlistToggleIndicator({
    super.key,
    required this.isSelected,
    required this.isLoading,
    required this.color,
  });

  final bool isSelected;
  final bool isLoading;
  final Color color;

  @override
  State<WatchlistToggleIndicator> createState() =>
      _WatchlistToggleIndicatorState();
}

class _WatchlistToggleIndicatorState extends State<WatchlistToggleIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    if (widget.isSelected) _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(WatchlistToggleIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isSelected && widget.isSelected) {
      _controller.forward(from: 0.0);
    } else if (oldWidget.isSelected && !widget.isSelected) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28.r,
      height: 28.r,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: widget.isLoading
            ? _buildLoading()
            : widget.isSelected
            ? _buildCheckmark()
            : _buildEmpty(),
      ),
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      key: const ValueKey('loading'),
      width: 22.r,
      height: 22.r,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(widget.color),
      ),
    );
  }

  Widget _buildCheckmark() {
    return ScaleTransition(
      key: const ValueKey('checked'),
      scale: _scaleAnim,
      child: Container(
        width: 26.r,
        height: 26.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
          boxShadow: [
            BoxShadow(
              color: widget.color.withValues(alpha: 0.4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Icon(
          Icons.check_rounded,
          size: 14.sp,
          color: AppColors.trueBlack,
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(
      key: const ValueKey('empty'),
      width: 24.r,
      height: 24.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.slateGray.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Icon(
        Icons.add_rounded,
        size: 14.sp,
        color: AppColors.slateGray.withValues(alpha: 0.4),
      ),
    );
  }
}
