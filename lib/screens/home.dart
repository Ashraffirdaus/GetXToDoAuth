import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_todos/controller/controller.dart';
import 'package:getx_todos/screens/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _taskController = TextEditingController();
  // Sign out the currently authenticated user
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => LoginPage())));
      // User is signed out
    } catch (e) {
      print('Error signing out: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      init: Controller(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("GetX amplify tutorial"),
            actions: [IconButton(onPressed: signOut, icon: const Icon(Icons.exit_to_app))],

          ),
          body: ListView.builder(
            itemCount: _.todosList.length,
            itemBuilder: (((context, index) => Dismissible(
                key: ValueKey<String>(_.todosList[index].id),
                onDismissed: (direction) =>
                    _.deleteFunction(_.todosList[index].id),
                background: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ],
                ),
                child: _.todosList.isNotEmpty
                    ? Card(
                        child: ListTile(
                        title: Text(_.todosList[index].task),
                      ))
                    : const Center(child: Text("No task !"))))),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _taskController,
                          ),
                          ElevatedButton(
                              onPressed: () => {
                                    _.addPost(_taskController.text),
                                    Navigator.pop(context)
                                  },
                              child: const Text("Save Task"))
                        ],
                      ),
                    )),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
