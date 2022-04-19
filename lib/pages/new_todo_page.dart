import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/models/todo.dart';

class NewToDoPage extends StatelessWidget {
  NewToDoPage({Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('New ToDo'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.white),
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title",border: OutlineInputBorder()),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: descController,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              decoration: const InputDecoration(labelText: "Description",border: OutlineInputBorder()),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: (){
                    createTodo();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Todo Added')),
                    );
                  },
                  child: const Text("Add New ToDo")
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future createTodo() async {
    final docTodo = FirebaseFirestore.instance.collection("todos").doc();

    final todo = Todo(
        id: docTodo.id,
        title: titleController.text.trim(),
        desc: descController.text.trim()
    );
    final json = todo.toJson();
    await docTodo.set(json);

  }
}
