import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get/get.dart';
import 'package:getx_todos/amplifyconfiguration.dart';
import 'package:getx_todos/models/ModelProvider.dart';

class Controller extends GetxController {
  var todosList = <Todos>[].obs;
  @override
  void onInit() {
    _configureAmplify();

    super.onInit();
  }

  // configure amplify . This should be run at first
  Future<void> _configureAmplify() async {
    // Add the following lines to your app initialization to add the DataStore plugin
    final datastorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    await Amplify.addPlugin(datastorePlugin);
    await Amplify.addPlugins([AmplifyAPI()]);

    try {
      await Amplify.configure(amplifyconfig);
      readData();
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
    }
  }

  //Read Data
  Future<void> readData() async {
    try {
      todosList = RxList(
        await Amplify.DataStore.query(
          Todos.classType,
        ),
      );
      update();
    } catch (e) {
      print(e);
    }
  }
 //AddTask
  Future<void> addPost(String task) async {
    try {
      Todos newTodo = Todos(task: task, isDone: false);
      await Amplify.DataStore.save(newTodo);
      readData();
    } on Exception catch (e) {
      print(e);
    }
  }


  //Update task
  Future<void> updatePost(String? id,  bool? isDone) async {
    try {
      Todos oldTodo = (await Amplify.DataStore.query(Todos.classType,
          where: Todos.ID.eq(id)))[0];

      Todos newTodo = oldTodo.copyWith(task: oldTodo.task, isDone: isDone!);
      await Amplify.DataStore.save(newTodo);
      readData();
    } on Exception catch (e) {
      print(e);
    }
  }
  //Delete Task
  Future<void> deleteFunction(String? id) async {
    try {
      final todosList = await Amplify.DataStore.query(Todos.classType,
          where: Todos.ID.eq(id));

      for (final element in todosList) {
        try {
          await Amplify.DataStore.delete(element);
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
    readData();
  }
}
