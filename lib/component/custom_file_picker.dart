import 'dart:io';

import 'package:d_form/model/file_picker_model.dart';
import 'package:d_form/utils/dimensions.dart';
import 'package:d_form/utils/extensions.dart';
import 'package:d_form/utils/widgets/container_dash.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomFilePicker extends StatefulWidget {
  final FilePickerModel model;
  Function(List<File>) onSelected;

  CustomFilePicker({super.key, required this.model, required this.onSelected});

  @override
  createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  List<File> selectedFiles = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: FilePickerFormField(
          items: selectedFiles,
          decoration: InputDecoration(
            labelText: widget.model.label,
            hintText: widget.model.hint,
          ),
          multipleFiles: widget.model.multiple ?? false,
          accept: widget.model.accept,
          onSelected: (files) {
            setState(() {
              selectedFiles = files.selectedFiles;
            });
            widget.onSelected(files.selectedFiles);
          },
          validator: (value) {
            if (widget.model.validations.isNotEmpty) {
              for (var validation in widget.model.validations) {
                switch (validation.type) {
                  case "required":
                    if (value?.selectedFiles.isEmpty == true) {
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

class FileItem {
  final List<File> selectedFiles;

  FileItem({required this.selectedFiles});
}

class FilePickerFormField extends FormField<FileItem> {
  final List<File> items;
  final ValueChanged<FileItem> onSelected;
  final InputDecoration? decoration;
  bool multipleFiles = false;
  List<String>? accept;

  FilePickerFormField(
      {required this.items,
      required this.onSelected,
      this.decoration,
      this.multipleFiles = false,
      this.accept,
      FormFieldSetter<FileItem>? onSaved,
      FormFieldValidator<FileItem>? validator})
      : super(
            onSaved: onSaved,
            validator: validator,
            builder: (FormFieldState<FileItem> state) {
              return ContainerDashRect(
                borderRadius: BorderRadius.circular(Dimen.radius),
                color: Theme.of(state.context).primaryColor,
                dashWidth: 10,
                child: Container(
                  padding: const EdgeInsets.all(Dimen.marginDefault),
                  child: Column(
                    children: [
                      Text(decoration?.labelText ?? "",
                          style: TextStyle(color: Theme.of(state.context).primaryColor, fontSize: Dimen.fontDefault)),
                      const SizedBox(height: 8),
                      Wrap(
                        children: List.generate(items.length, (index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 8, bottom: 8),
                            width: 80,
                            child: Column(
                              children: [
                                items[index].path.endsWith(".jpg") ||
                                        items[index].path.endsWith(".jpeg") ||
                                        items[index].path.endsWith(".png")
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(Dimen.radiusSmall),
                                        child: Image.file(items[index], width: 64, height: 64, fit: BoxFit.cover))
                                    : const Icon(Icons.insert_drive_file, size: 64),
                                const SizedBox(height: 8),
                                Text(items[index].path.split("/").last,
                                    style: const TextStyle(fontSize: Dimen.fontSmall),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          var result = await FilePicker.platform.pickFiles(
                            dialogTitle: "Pilih ${decoration?.labelText}",
                            allowMultiple: multipleFiles,
                            type: accept != null ? FileType.custom : FileType.any,
                            allowedExtensions: accept
                          );
                          if (result != null) {
                            onSelected(FileItem(selectedFiles: result.files.map((e) => File(e.path!)).toList()));
                          }
                        },
                        child: Ink(
                          width: double.infinity,
                          padding: const EdgeInsets.all(Dimen.marginDefault),
                          decoration: BoxDecoration(
                              color: Theme.of(state.context).primaryColor,
                              borderRadius: BorderRadius.circular(Dimen.radius),
                              border: Border.all(color: Theme.of(state.context).primaryColor, width: 1)),
                          child: Text(
                            "Pilih ${decoration?.labelText}".toCapitalized,
                            style: const TextStyle(fontSize: Dimen.fontDefault, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      state.errorText != null ? Text(state.errorText!, style: const TextStyle(color: Colors.red)) : Container()
                    ],
                  ),
                ),
              );
            });
}
