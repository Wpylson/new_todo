import 'package:flutter/material.dart';
import 'package:new_todo/models/note.dart';
import 'package:new_todo/models/note_database.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //On app startup, fecth existing notes
    readNotes();
  }

  //create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Nota'),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),

          //Add Button
          MaterialButton(
            onPressed: () {
              //add to db
              context.read<NoteDatabase>().addNote(textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text('Criar Nota'),
          ),
        ],
      ),
    );
  }

  //read nootes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  //update a note
  void updateNote(Note note) {
    //pre-fill the current note
    textController.text = note.text;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Nota'),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),

          //Update buttom
          MaterialButton(
            onPressed: () {
              //update note in db
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);

              textController.clear();
              Navigator.pop(context);
            },
            child: const Text('Editar'),
          ),
        ],
      ),
    );
  }

  //delete a note
  void deleteNote(int id, Note note) {
    //pre-fill the current note
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apagar Nota'),
        content:
            Text('Tem a certeza que deseja apagar a ${textController.text} ?'),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),

          //Update buttom
          MaterialButton(
            onPressed: () {
              //update note in db
              context.read<NoteDatabase>().deleteNote(id);
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text('Apagar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Note datbase
    final noteDatabase = context.watch<NoteDatabase>();
    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          //get individual note
          final note = currentNotes[index];

          //List tile UI
          return ListTile(
            title: Text(note.text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Edit buttom
                IconButton(
                    onPressed: () => updateNote(note),
                    icon: const Icon(Icons.edit)),

                //Delete buttom
                IconButton(
                    onPressed: () => deleteNote(note.id, note),
                    icon: const Icon(Icons.delete)),
              ],
            ),
          );
        },
      ),
    );
  }
}
