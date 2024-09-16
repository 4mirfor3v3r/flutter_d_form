import 'package:d_form/model/field_model.dart';
import 'package:d_form/model/validation_model.dart';

class TextFieldModel extends FieldModel {
  int? borderType;
  int? keyboardType;

  TextFieldModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    super.hint = json['hint'];
    super.value = json['value'];
    if(json["validation"] != null && json["validation"].length > 0) {
      List.generate(json["validation"].length, (index) {
        super.validations.add(ValidationModel.fromJson(json["validation"][index]));
      });
    }
    borderType = json['borderType'];
    keyboardType = json['keyboardType'];
  }
}

enum BorderType { outlineInputBorder, underLineInputBorder }
