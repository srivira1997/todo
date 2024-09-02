import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/constants/app_images.dart';
import 'package:todo/core/utils/Converts.dart';
import 'package:todo/presentation/blocs/todo_bloc.dart';
import 'package:todo/presentation/screens/add_todo_screen.dart';
import 'package:todo/presentation/screens/change_language_screen.dart';
import 'package:todo/presentation/widgets/cards/primary_card.dart';
import 'package:todo/presentation/widgets/image/primary_lottie_image.dart';
import 'package:todo/presentation/widgets/text/primary_text.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:todo/presentation/widgets/text/secondary_text.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: appBackgroundColor,
          title: Column(
            children: [
              16.height,
              PrimaryText(
                text: AppLocalizations.of(context)!.apptitle,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.bottomSheet(const ChangeLanguageScreen(),
                      isScrollControlled: false);
                },
                iconSize: 40.0,
                icon: const Icon(
                  Icons.translate_outlined,
                  size: 25,
                  color: appPrimaryColor,
                )).withSize(width: 60, height: 60)
          ],
        ),
      ),
      body: Column(
        children: [
          // Todo Bloc
          BlocBuilder<ToDoBloc, ToDoState>(
            builder: (context, state) {
              if (state is ToDoLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: appPrimaryColor,
                ));
              } else if (state is ToDoLoaded) {
                //Generate List with Animation
                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PrimaryCard(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                                text: state.todos[index].title
                                    .capitalizeFirstLetter()),
                            8.height,
                            SecondaryText(
                                text: Converts.formatDateTime(
                                    state.todos[index].createdAt,
                                    format: "dd MMMM yyyy"))
                          ],
                        ).paddingAll(8));
                  },
                ).expand();
              } else if (state is ToDoError) {
                return Center(child: Text(state.message));
              }
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryLottieImage(
                    path: notasklottie,
                    width: Get.width / 2,
                    height: Get.width / 2,
                  ),
                  PrimaryText(
                    text: AppLocalizations.of(context)!.notask,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: appDangerColor,
                  )
                ],
              ));
            },
          ).expand(),
        ],
      ).paddingAll(16),
      floatingActionButton: FloatingActionButton(
          backgroundColor: appPrimaryColor,
          child: const Icon(
            Icons.add,
            color: appWhiteColor,
            size: 20,
          ),
          onPressed: () {
            Get.bottomSheet(const AddToDoScreen().withHeight(Get.height * .5),
                isScrollControlled: true);
          }),
    );
  }
}
