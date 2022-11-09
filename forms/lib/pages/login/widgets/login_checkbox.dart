import 'package:flutter/material.dart';

class LoginCheckbox extends FormField<bool> {
  LoginCheckbox({
    Key? key,
    bool? initialValue,
    AutovalidateMode? autovalidateMode,
    String? Function(bool?)? validator,
    required void Function(bool value) onChanged,
  }) : super(
          key: key,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  value: state.value ?? false,
                  title: const Text('hello world'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    state.didChange(value);
                    if (value != null) {
                      onChanged(value);
                    }
                  },
                ),
                if (state.hasError)
                  Text(
                    state.errorText!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
              ],
            );
          },
        );
}
