import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpField extends StatefulWidget {
  const OtpField({
    super.key,
    this.length = 6,
    this.boxSize,
    this.boxWidth,
    this.boxHeight,
    this.spacing,
    this.borderRadius,
    this.onCompleted,
    this.onChanged,
  });

  final int length;
  final double? boxSize;
  final double? boxWidth;
  final double? boxHeight;
  final double? spacing;
  final double? borderRadius;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers.map((c) => c.text).join();

  double get _boxWidth => widget.boxSize ?? widget.boxWidth ?? 38.w;
  double get _boxHeight => widget.boxSize ?? widget.boxHeight ?? 46.h;
  double get _spacing => widget.spacing ?? 8.w;
  double get _borderRadius => widget.borderRadius ?? 8.r;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Container(
          width: _boxWidth,
          height: _boxHeight,
          margin: EdgeInsets.symmetric(horizontal: _spacing / 2),
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace &&
                  _controllers[index].text.isEmpty &&
                  index > 0) {
                _controllers[index - 1].clear();
                _focusNodes[index - 1].requestFocus();
              }
            },
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: theme.textTheme.headlineMedium,
              decoration: InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
                filled: true,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value.length == 1 && index < widget.length - 1) {
                  _focusNodes[index + 1].requestFocus();
                } else if (value.isEmpty && index > 0) {
                  _focusNodes[index - 1].requestFocus();
                }
                final code = _code;
                widget.onChanged?.call(code);
                if (code.length == widget.length) {
                  widget.onCompleted?.call(code);
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
