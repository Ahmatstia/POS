import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lexa_pos/core/design/app_colors.dart';
import 'package:lexa_pos/core/design/app_radius.dart';
import 'package:lexa_pos/core/design/app_spacing.dart';
import 'package:lexa_pos/core/design/app_text_styles.dart';

/// Labeled text field matching Lexa POS input spec.
/// Height: 48px, border-radius 8px, 2px indigo-400 focus ring.
/// Label always shown above field — never placeholder-as-label.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofocus = false,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.inputFormatters,
    this.focusNode,
  });

  final String name;
  final String label;
  final String? initialValue;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool enabled;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSubmitted;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  @override
  State<AppTextField> createState() => AppTextFieldState();
}

/// State holder exposing validation for form submit flows.
class AppTextFieldState extends State<AppTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String? _errorText;
  bool _ownsFocusNode = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _ownsFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  /// Validates the field and updates inline error display.
  bool validate() {
    final error = widget.validator?.call(_controller.text);
    setState(() => _errorText = error);
    return error == null;
  }

  String? get value => _controller.text;

  @override
  Widget build(BuildContext context) {
    final hasError = _errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.label14),
        const SizedBox(height: AppSpacing.s8),
        _FieldContainer(
          hasError: hasError,
          focusNode: _focusNode,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            style: AppTextStyles.body14,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.body14.copyWith(color: AppColors.subtleText),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s16,
              ),
              prefixIcon: widget.prefixIcon,
              isDense: true,
            ),
            onChanged: (value) {
              if (_errorText != null) {
                setState(() => _errorText = null);
              }
              widget.onChanged?.call(value);
            },
            onSubmitted: widget.onSubmitted,
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: AppSpacing.s4),
          Text(
            _errorText!,
            style: AppTextStyles.body12.copyWith(color: AppColors.danger),
          ),
        ],
      ],
    );
  }
}

class _FieldContainer extends StatelessWidget {
  const _FieldContainer({
    required this.child,
    required this.hasError,
    required this.focusNode,
  });

  final Widget child;
  final bool hasError;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: focusNode,
      builder: (context, _) {
        final isFocused = focusNode.hasFocus;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: AppSpacing.s48,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.input),
            border: Border.all(
              color: hasError
                  ? AppColors.danger
                  : isFocused
                      ? AppColors.accentFocusRing
                      : AppColors.border,
              width: isFocused && !hasError ? 2 : 1,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: child,
        );
      },
    );
  }
}
