library d_form;

import 'package:d_form/component/custom_dropdown.dart';
import 'package:d_form/component/custom_textfield.dart';
import 'package:d_form/model/dropdown_model.dart';
import 'package:d_form/model/field_model.dart';
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
  final List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (var element in widget.formMap) {
      if (element['type'] == "text") {
        var model = TextFieldModel.fromJson(element);
        controllers.add(TextEditingController(text: model.value));
        fields.add(model);
      }else if(element['type'] == "dropdown") {
        var model = DropdownModel.fromJson(element);
        controllers.add(TextEditingController(text: model.value));
        fields.add(model);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var i=0; i<fields.length; i++) {
      if (fields[i] is TextFieldModel) {
        children.add(CustomTextField(model: fields[i] as TextFieldModel, controller: controllers[i]));
      } else if (fields[i] is DropdownModel) {
        children.add(CustomDropdown(model: fields[i] as DropdownModel, controller: controllers[i]));
      }
    }
    return Form(
        key: formKey,
        child: Column(children: children,));
  }

  Map<String, dynamic> getValues() {
    Map<String, dynamic> values = {};
    for (var i=0; i<fields.length; i++) {
      values[fields[i].id] = controllers[i].text;
    }
    return values;
  }
}
