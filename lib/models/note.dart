import 'package:isar/isar.dart';

//this Line is needed to generate file
//the run: flutter run build_runner build
part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
