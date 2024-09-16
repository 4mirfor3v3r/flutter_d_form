import 'package:d_form/model/validation_model.dart';

class FieldModel{
  late String id;
  late String type;
  String? label;
  String? hint;
  String? value;
  List<ValidationModel> validations = [];
  FieldModel({required this.id, required this.type, this.label, this.hint, this.value, required this.validations});

  FieldModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    label = json['label'];
    hint = json['hint'];
    value = json['value'];
    if(json["validation"] != null && json["validation"].length > 0) {
      List.generate(json["validation"].length, (index) {
        validations.add(ValidationModel.fromJson(json["validation"][index]));
      });
    }
  }
}