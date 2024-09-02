// lib/presentation/screens/add_todo_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/presentation/blocs/todo_bloc.dart';
import 'package:todo/presentation/widgets/buttons/primary_elevated_button.dart';
import 'package:todo/presentation/widgets/form/date_time_picker.dart';
import 'package:todo/presentation/widgets/form/primary_text_form_feild.dart';
import 'package:todo/presentation/widgets/text/primary_text.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({super.key});

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _createdAtController = TextEditingController();
  final bool _isCompleted = false;

  final uuid = const Uuid();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: appWhiteColor, //change your color here
        ),
        centerTitle: false,
        backgroundColor: appPrimaryColor,
        title: PrimaryText(
          text: AppLocalizations.of(context)!.addtodo,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              iconSize: 40.0,
              icon: const Icon(
                Icons.language_outlined,
                size: 20,
                color: appPrimaryColor,
              )).withSize(width: 60, height: 60)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              16.height,
              PrimaryTextFormFeild(
                controller: _titleController,
                hintText: AppLocalizations.of(context)!.title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.plsentertitle;
                  }
                  return null;
                },
              ),
              16.height,
              PrimaryTextFormFeild(
                controller: _descriptionController,
                hintText: AppLocalizations.of(context)!.description,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.plsenterdesc;
                  }
                  return null;
                },
              ),
              16.height,
              DatePicker(
                hintText: AppLocalizations.of(context)!.selecttaskdate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.plsentertask;
                  }
                  return null;
                },
                controller: _createdAtController,
              ),
              16.height,
              PrimaryElevatedButton(
                  child: PrimaryText(
                    text: AppLocalizations.of(context)!.save,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Create a new ToDo
                      final newToDo = ToDoModel(
                        id: uuid.v4(),
                        title: _titleController.text,
                        description: _descriptionController.text,
                        isCompleted: _isCompleted,
                        createdAt: DateTime.parse(_createdAtController.text),
                      );

                      // Add the ToDo using the BLoC or Provider
                      BlocProvider.of<ToDoBloc>(context).add(AddToDo(newToDo));
                      Get.back();
                      /* // Navigate back to the previous screen
                    Navigator.of(context).pop(); */
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
