import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lexa_pos/core/design/app_colors.dart';

/// Shows the payment success checkmark animation, then invokes [onComplete].
class PaymentSuccessOverlay extends StatefulWidget {
  const PaymentSuccessOverlay({
    super.key,
    required this.onComplete,
  });

  final VoidCallback onComplete;

  static void show(BuildContext context, {required VoidCallback onComplete}) {
    showDialog(
      context: context,
      barrierColor: AppColors.success.withValues(alpha: 0.1), // emerald-50 tint
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) => PaymentSuccessOverlay(onComplete: onComplete),
    );
  }

  @override
  State<PaymentSuccessOverlay> createState() => _PaymentSuccessOverlayState();
}

class _PaymentSuccessOverlayState extends State<PaymentSuccessOverlay> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        Navigator.pop(context);
        widget.onComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_rounded,
          size: 80,
          color: AppColors.success,
        )
            .animate()
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1, 1),
              duration: 400.ms,
              curve: Curves.elasticOut,
            )
            .fadeIn(duration: 200.ms),
      )
          .animate()
          .scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1, 1),
            duration: 300.ms,
            curve: Curves.easeOutBack,
          )
          .fadeIn(duration: 200.ms),
    );
  }
}
