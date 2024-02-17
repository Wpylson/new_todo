import 'dart:js';

import 'package:flutter/material.dart';
import 'package:new_todo/app_main.dart';
import 'package:new_todo/models/note_database.dart';
import 'package:provider/provider.dart';

void main() async {
  //Initializr note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(ChangeNotifierProvider(
    create: (context) => NoteDatabase(),
    child: const MyApp(),
  ));
}
