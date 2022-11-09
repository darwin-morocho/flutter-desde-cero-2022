import 'package:flutter/material.dart';

class LoginTextField extends FormField<String> {
  LoginTextField({
    Key? key,
    TextInputAction? textInputAction,
    required String label,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onSubmitted,
    void Function(String)? onChanged,
    FocusNode? focusNode,
  }) : super(
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: key,
          builder: (state) {
            bool isOk = !state.hasError &&
                state.value != null &&
                state.value!.isNotEmpty;

            return TextField(
              focusNode: focusNode,
              obscureText: obscureText,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              onChanged: (text) {
                state.didChange(text);
                if (onChanged != null) {
                  onChanged(text);
                }
              },
              decoration: InputDecoration(
                label: Text(label),
                suffixIcon: Icon(
                  Icons.check_circle,
                  color: isOk ? Colors.green : Colors.black12,
                ),
              ),
            );
          },
        );
}
