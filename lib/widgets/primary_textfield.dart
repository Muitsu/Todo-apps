import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final int? maxLines;
  final bool isDatePicker;
  final void Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const PrimaryTextField(
      {super.key,
      this.label,
      this.maxLines = 1,
      this.hintText,
      this.onTap,
      this.isDatePicker = false,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: label != null ? 12 : 0),
        label != null
            ? Text(
                '$label',
                style: const TextStyle(fontSize: 16),
              )
            : const SizedBox.shrink(),
        SizedBox(height: label != null ? 10 : 0),
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          readOnly: isDatePicker,
          validator: validator,
          onTap: onTap,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixIcon: isDatePicker
                  ? const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.grey,
                    )
                  : null,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey)),
        )
      ],
    );
  }
}
