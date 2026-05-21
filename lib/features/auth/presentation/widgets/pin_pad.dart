import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lexa_pos/core/constants/app_config.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';

/// Custom numeric keypad for PIN entry with press-scale microinteraction.
class PinPad extends StatelessWidget {
  const PinPad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
    this.shakeTrigger = 0,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;
  final int shakeTrigger;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(shakeTrigger),
      mainAxisSize: MainAxisSize.min,
      children: [
        _PinRow(keys: const ['1', '2', '3'], onDigit: onDigit),
        const SizedBox(height: AppSpacing.s12),
        _PinRow(keys: const ['4', '5', '6'], onDigit: onDigit),
        const SizedBox(height: AppSpacing.s12),
        _PinRow(keys: const ['7', '8', '9'], onDigit: onDigit),
        const SizedBox(height: AppSpacing.s12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 88),
            const SizedBox(width: AppSpacing.s12),
            _PinKey(label: '0', onPressed: () => onDigit('0')),
            const SizedBox(width: AppSpacing.s12),
            _PinKey(
              icon: Icons.backspace_outlined,
              semanticsLabel: 'Delete',
              onPressed: onBackspace,
            ),
          ],
        ),
      ],
    )
        .animate(
          key: ValueKey('shake-$shakeTrigger'),
          autoPlay: shakeTrigger > 0,
        )
        .shake(
          duration: const Duration(milliseconds: 300),
          hz: 4,
        );
  }
}

class _PinRow extends StatelessWidget {
  const _PinRow({required this.keys, required this.onDigit});

  final List<String> keys;
  final ValueChanged<String> onDigit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < keys.length; index++) ...[
          if (index > 0) const SizedBox(width: AppSpacing.s12),
          _PinKey(
            label: keys[index],
            onPressed: () => onDigit(keys[index]),
          ),
        ],
      ],
    );
  }
}

class _PinKey extends StatefulWidget {
  const _PinKey({
    this.label,
    this.icon,
    this.semanticsLabel,
    required this.onPressed,
  }) : assert(label != null || icon != null);

  final String? label;
  final IconData? icon;
  final String? semanticsLabel;
  final VoidCallback onPressed;

  @override
  State<_PinKey> createState() => _PinKeyState();
}

class _PinKeyState extends State<_PinKey> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final label = widget.semanticsLabel ?? widget.label ?? 'Key';

    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onPressed();
        },
        child: AnimatedScale(
          scale: _pressed ? 0.94 : 1,
          duration: const Duration(milliseconds: 80),
          child: Container(
            width: 88,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(AppRadius.button),
              border: Border.all(color: AppColors.border),
            ),
            child: widget.icon != null
                ? Icon(widget.icon, color: AppColors.primary, size: 24)
                : Text(widget.label!, style: AppTextStyles.heading24),
          ),
        ),
      ),
    );
  }
}

/// Visual PIN dot indicators.
class PinDots extends StatelessWidget {
  const PinDots({
    super.key,
    required this.length,
    required this.filled,
  });

  final int length;
  final int filled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final isFilled = index < filled;
        return Container(
          width: 14,
          height: 14,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? AppColors.accent : AppColors.border,
            border: Border.all(
              color: isFilled ? AppColors.accent : AppColors.mutedText,
            ),
          ),
        );
      }),
    );
  }
}

/// PIN length constant re-export for widgets.
int get pinLength => AppConfig.pinLength;
