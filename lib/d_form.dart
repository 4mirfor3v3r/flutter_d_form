library d_form;

import 'package:d_form/component/custom_textfield.dart';
import 'package:d_form/model/field_model.dart';
import 'package:d_form/model/text_field_model.dart';
import 'package:flutter/material.dart';

class DForm extends StatefulWidget {
  final List<dynamic> formMap;
  final GlobalKey<FormState>? formKey;

  const DForm({super.key, required this.formMap, required this.formKey});

  @override
  createState() => _DFormState();
}

class _DFormState extends State<DForm> {
  List<FieldModel> fields = [];

  @override
  void initState() {
    super.initState();
    for (var element in widget.formMap) {
      if (element['type'] == "text") {
        var model = TextFieldModel.fromJson(element);
        fields.add(model);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            for (var field in fields)
              if (field is TextFieldModel) CustomTextField(model: field),
          ],
        ));
  }
}
