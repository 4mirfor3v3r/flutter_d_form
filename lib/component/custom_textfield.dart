import 'package:d_form/model/text_field_model.dart';
import 'package:d_form/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextFieldModel model;
  final TextEditingController? controller;

  CustomTextField({super.key, required this.model, required this.controller});

  @override
  createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            errorMaxLines: 3,
            labelText: widget.model.label,
            hintText: widget.model.hint,
            suffixIcon: widget.model.keyboardType == TextInputType.visiblePassword.index
                ? IconButton(
                    icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : null,
            border: BorderType.values[widget.model.borderType ?? 0] == BorderType.outlineInputBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimen.radius),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1))
                : UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1)),
          ),
          keyboardType: TextInputType.values[widget.model.keyboardType ?? 0],
          obscureText: obscureText,
          validator: (value) {
            if (widget.model.validations.isNotEmpty) {
              for (var validation in widget.model.validations) {
                switch (validation.type) {
                  case "required":
                    if (value == null || value.isEmpty) {
                      return validation.error;
                    }
                    break;
                  case "minLength":
                    if (value != null && value.length < (validation.value is String? int.tryParse(validation.value) ?? 0 : validation.value ?? 0)) {
                      return validation.error;
                    }
                    break;
                  case "maxLength":
                    if (value != null && value.length > (validation.value is String? int.tryParse(validation.value) ?? 0 : validation.value ?? 0)) {
                      return validation.error;
                    }
                    break;
                  case "pattern":
                    if (value != null && !RegExp(validation.value).hasMatch(value)) {
                      return validation.error;
                    }
                    break;
                }
              }
            }
            return null;
          },
        ));
  }
}
