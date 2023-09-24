import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextFormInput extends StatelessWidget {
  const TextFormInput({
    super.key,
    required this.name,
    required this.label,
    this.initialValue,
    this.textInputType,
    this.required,
  });

  final String name;
  final String label;
  final String? initialValue;
  final TextInputType? textInputType;
  final bool? required;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      keyboardType: textInputType,
      initialValue: initialValue,
      validator: (String? value) {
        if (required != null &&
            required == true &&
            value != null &&
            value.isEmpty) {
          return "this field is required";
        }

        return null;
      },
      decoration: InputDecoration(
        label: Text(label),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
