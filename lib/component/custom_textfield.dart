import 'package:d_form/model/text_field_model.dart';
import 'package:d_form/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextFieldModel model;
  final TextEditingController controller = TextEditingController();

  CustomTextField({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: model.label,
            hintText: model.hint,
            border: BorderType.values[model.borderType ?? 0] == BorderType.outlineInputBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimen.radius),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1))
                : UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1)),
          ),
          keyboardType: TextInputType.values[model.keyboardType ?? 0],
          validator: (value) {
            if (model.validations.isNotEmpty) {
              for (var validation in model.validations) {
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
