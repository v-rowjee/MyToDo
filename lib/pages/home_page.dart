import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mytodo/models/todo.dart';
import 'package:mytodo/pages/detail_page.dart';
import 'package:mytodo/pages/new_todo_page.dart';
import 'package:mytodo/widgets/appDrawerHeader.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('MyToDo'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppDrawerHeader(),
            const Expanded(child: SizedBox()),
            ListTile(
              title: TextButton(
                child: const Text('Logout'),
                onPressed: () => FirebaseAuth.instance.signOut(),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.white),
        child: StreamBuilder<List<Todo>>(
          stream: readTodos(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              final todos = snapshots.data!;
              return ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: todos.map(buildTodo).toList(),
              );
            } else if (!snapshots.hasData) {
              return const Center(child: Text("Nothing Here"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewToDoPage())),
      ),
    );
  }

  Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
      .collection('todos')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((e) => Todo.fromJson(e.data())).toList());

  Widget buildTodo(Todo todo) => Slidable(
        key: UniqueKey(),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ListTile(
            title: Text(todo.title),
            trailing: const Icon(Icons.arrow_forward_ios,color: Colors.black12)
            // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage())),
          ),
        ),
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          dismissible: null,
          children: [
            SlidableAction(
              onPressed: (context) => deleteTodo(todo),
              foregroundColor: Colors.redAccent,
              icon: Icons.delete,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          dismissible: null,
          children: [
            SlidableAction(
              onPressed: (context) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailPage(todo: todo))),
              foregroundColor: Colors.blue,
              icon: Icons.arrow_forward,
            ),
          ],
        ),
      );

  deleteTodo(Todo todoCard) {
    FirebaseFirestore.instance.collection('todos').doc(todoCard.id).delete();
  }
}
