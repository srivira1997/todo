import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/task_manager.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/localization/locale_provider.dart';
import 'package:todo/presentation/blocs/todo_bloc.dart';
import 'package:todo/presentation/screens/todo_list_screen.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase and Hive here
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoModelAdapter());
  await Hive.openBox<ToDoModel>('todos');

  // Initialize WorkManager
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  // Register the periodic task
  Taskmanager.registerPeriodicTaskTodo();

  runApp(const MyApp());
}

// Workmanager callbackDispatcher
callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'syncHiveToFirebase') {
      await Taskmanager.syncHiveToFirebase();
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final LocaleController localeController = Get.put(LocaleController());
    return MultiBlocProvider(
        providers: [
          // To do bloc init globally
          BlocProvider<ToDoBloc>(
              create: (context) => ToDoBloc()..add(LoadToDos())),
        ],
        child: Obx(() {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              locale: localeController.locale.value,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const TodoListScreen());
        }));
  }
}
