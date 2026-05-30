import 'package:flutter/material.dart';
import '../../../core/values/colors.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const InputField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.headingDark,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hasError ? AppColors.errorColor : AppColors.borderColor,
            ),
          ),
          child: TextField(
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.placeholderColor,
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: InputBorder.none,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.placeholderColor,
                      ),
                      onPressed: onToggleVisibility,
                    )
                  : null,
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: const TextStyle(
              color: AppColors.errorColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
