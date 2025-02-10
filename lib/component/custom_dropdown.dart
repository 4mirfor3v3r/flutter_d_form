import 'package:d_form/model/dropdown_model.dart';
import 'package:d_form/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final DropdownModel model;
  final TextEditingController? controller;

  CustomDropdown({super.key, required this.model, required this.controller});

  @override
  createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  var selectedItems;
  List<DropdownMenuItem<DropdownItem>> menuItems = [];

  @override
  void initState() {
    super.initState();
    for (var item in widget.model.items) {
      menuItems.add(DropdownMenuItem<DropdownItem>(
        value: item,
        child: Text(item.label ?? "-"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: DropdownButtonFormField<DropdownItem>(
            items: menuItems,
            decoration: InputDecoration(
              labelText: widget.model.label,
              hintText: widget.model.hint,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimen.radius),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1)),
            ),
            onChanged: (DropdownItem? dropdownItem){
              widget.controller?.text = dropdownItem!.value!;
              setState(() {
                selectedItems = dropdownItem;
              });
            },
            value: selectedItems,
            validator: (value){
              if (widget.model.validations.isNotEmpty) {
                for (var validation in widget.model.validations) {
                  switch (validation.type) {
                    case "required":
                      if (value == null) {
                        return validation.error;
                      }
                      break;
                  }
                }
              }
              return null;
            },
            )
    );
  }
}
