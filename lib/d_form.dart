library d_form;

import 'dart:io';

import 'package:d_form/component/custom_dropdown.dart';
import 'package:d_form/component/custom_file_picker.dart';
import 'package:d_form/component/custom_textfield.dart';
import 'package:d_form/model/dropdown_model.dart';
import 'package:d_form/model/field_model.dart';
import 'package:d_form/model/file_picker_model.dart';
import 'package:d_form/model/text_field_model.dart';
import 'package:flutter/material.dart';

class DForm extends StatefulWidget {
  final List<dynamic> formMap;

  DForm({required Key key, state, required this.formMap}) : super(key: key);

  @override
  createState() => DFormState();
}

class DFormState extends State<DForm> {
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final List<FieldModel> fields = [];
  final Map<String, dynamic> controllers = {};

  @override
  void initState() {
    super.initState();
    for (var element in widget.formMap) {
      if (element['type'] == "text") {
        var model = TextFieldModel.fromJson(element);
        fields.add(model);
        controllers[model.id] = TextEditingController(text: model.value?.firstOrNull ?? "");
      } else if (element['type'] == "dropdown") {
        var model = DropdownModel.fromJson(element);
        fields.add(model);
        controllers[model.id] = TextEditingController(text: model.value?.firstOrNull ?? "");
      } else if (element['type'] == "file") {
        var model = FilePickerModel.fromJson(element);
        fields.add(model);
        controllers[model.id] = [];
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var field in fields) {
      if (field is TextFieldModel) {
        children.add(CustomTextField(model: field, controller: controllers[field.id]));
      } else if (field is DropdownModel) {
        children.add(CustomDropdown(model: field, controller: controllers[field.id]));
      } else if (field is FilePickerModel) {
        children.add(CustomFilePicker(model: field, onSelected: (files) => controllers[field.id] = files));
      }
    }
    return Form(
        key: formKey,
        child: Column(
          children: children,
        ));
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> values = {};
    for (var i = 0; i < fields.length; i++) {
      if (fields[i] is TextFieldModel || fields[i] is DropdownModel) {
        TextEditingController controller = controllers[fields[i].id];
        values[fields[i].id] = controller.text;
      } else if (fields[i] is FilePickerModel) {
        values[fields[i].id] = controllers[fields[i].id];
      }
    }
    return values;
  }
}
