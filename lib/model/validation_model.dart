
class ValidationModel{
  String type;
  dynamic value;
  String? error;
  ValidationModel({required this.type, this.value, this.error});

  ValidationModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        value = json['value'],
        error = json['error'];
}