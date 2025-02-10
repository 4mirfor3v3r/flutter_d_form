import 'package:d_form/model/field_model.dart';
import 'package:d_form/model/validation_model.dart';

class DropdownModel extends FieldModel {
  List<DropdownItem> items = [];
  int? borderType;

  DropdownModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    super.hint = json['hint'];
    super.value = json['value'];
    if(json["validation"] != null && json["validation"].length > 0) {
      List.generate(json["validation"].length, (index) {
        super.validations.add(ValidationModel.fromJson(json["validation"][index]));
      });
    }
    borderType = json['border_type'];

    if(json["items"] != null && json["items"].length > 0) {
      List.generate(json["items"].length, (index) {
        items.add(DropdownItem.fromJson(json["items"][index]));
      });
    }
  }
}

class DropdownItem {
  dynamic value;
  String? label;

  DropdownItem.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }
}

enum BorderType { outlineInputBorder, underLineInputBorder }
