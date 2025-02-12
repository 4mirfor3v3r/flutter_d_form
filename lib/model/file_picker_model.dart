import 'package:d_form/model/field_model.dart';
import 'package:d_form/model/validation_model.dart';

class FilePickerModel extends FieldModel {
  List<String> accept = [];
  bool? multiple;

  FilePickerModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    super.hint = json['hint'];
    super.value = json['value'];
    if(json["validation"] != null && json["validation"].length > 0) {
      List.generate(json["validation"].length, (index) {
        super.validations.add(ValidationModel.fromJson(json["validation"][index]));
      });
    }

    multiple = json['multiple'];
    if(json["accept"] != null && json["accept"].length > 0) {
      List.generate(json["accept"].length, (index) {
        accept.add(json["accept"][index]);
      });
    }
  }
}
