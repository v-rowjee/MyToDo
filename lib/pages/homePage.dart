import 'package:flutter/material.dart';
import 'package:mytodo/authentication_service.dart';
import 'package:mytodo/widgets/appDrawerHeader.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> todos = [];

  void getList() async {
    final prefs = await SharedPreferences.getInstance();
    todos = prefs.getStringList('todo') ?? [];
    setState(() {});
  }
  void setList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todo', todos);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

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
        child: ListView(
          children: [
            const AppDrawerHeader(),
            const SizedBox(height: 340),
            ListTile(
              title: TextButton(
                  child: const Text('Logout'),
                  onPressed: () => context.read<AuthenticationService>().signOut(),
              ),
            )
          ],
        ),
      ),
      body: Container(
              padding: const EdgeInsets.only(top: 30),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  color: Colors.white
              ),
              child: todos.isNotEmpty
                  ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    itemCount: todos.length,
                    itemBuilder: (_,index){
                      return Dismissible(
                        child: Card(
                            elevation: 2.5,
                            child: ListTile(
                              title: Text(todos[index]),
                              trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () => _removeFromList(index)
                              ),
                            )
                        ),
                        background: Container(
                          padding: const EdgeInsets.all(20.0),
                          alignment: AlignmentDirectional.centerStart,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) => _removeFromList(index),
                        key: UniqueKey(),
                      );
                    })
                  :  const Center(child: Text('Nothing in here. Add something!')),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _displayDialog()
      ),
    );
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final _textFieldController = TextEditingController();
        return AlertDialog(
          title: const Text('Add a new todo item'),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          contentPadding: const EdgeInsets.all(15.0),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addToList(_textFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }

  _addToList(String text){
    setState(() {
      todos.add(text);
      setList();
    });
  }
  _removeFromList(int index){
    setState(() {
      todos.removeAt(index);
      setList();
    });
  }

}