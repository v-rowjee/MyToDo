import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/models/todo.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          title: Text(todo.title),
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
            padding: const EdgeInsets.all(30),
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white),
            child: TextField(
              controller: descController..text = todo.desc,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
        ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: (){
          saveTodo(todo);
          Navigator.pop(context);
        },
      ),
    );
  }

  Future saveTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todos').doc(todo.id);
    docTodo.update({
      'desc' : descController.text.trim()
    });
  }
}
