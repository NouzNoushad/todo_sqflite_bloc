import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice/layout/todo_app.dart';
import 'package:flutter_practice/modules/add_todo.dart';
import 'package:flutter_practice/modules/edit_todo.dart';
import 'package:flutter_practice/modules/new_todo.dart';
import 'package:flutter_practice/shared/cubits/todo_states.dart';
import 'package:sqflite/sqflite.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitialState());

  static TodoCubit getContext(context) => BlocProvider.of(context);

  List<String> todoList = [
    'Write stories',
    'Drink Water',
    'Code flutter',
  ];

  List<Map> newTodo = [];
  Database? database;

  int selectedNavigationIndex = 0;
  List<Widget> navigationScreens = [
    const NewTodo(),
    const AddTodo(),
  ];

  String validationError() => 'This field should not be empty';

  void changeBottomNavIndex(index) {
    selectedNavigationIndex = index;
    emit(TodoChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase('todos.db', version: 1, onCreate: (database, version) {
      database
          .execute('CREATE TABLE todos (id INTEGER PRIMARY KEY, todo TEXT)')
          .then((value) => print('Table Created'))
          .catchError((error) {
        print('Error: ${error.toString()}');
      });
    }, onOpen: (database) {
      getTodoDatabase(database);
      print('Database Opened');
    }).then((value) {
      database = value;
      emit(TodoCreateDatabaseState());
    });
  }

  void getTodoDatabase(database) {
    newTodo = [];
    database!.rawQuery('SELECT * FROM todos').then((todos) {
      print(todos);
      todos.forEach((todo) {
        newTodo.add(todo);
      });
      emit(TodoGetDatabaseState());
    }).catchError((error) {
      print('Error while fetching ${error.toString()}');
    });
  }

  addToDatabase({required String todo}) async {
    await database!.transaction((txn) async {
      txn.rawInsert('INSERT INTO todos (todo) VALUES (?)', [todo]).then(
          (value) {
        getTodoDatabase(database);
        print('$value inserted successfully');
        emit(TodoInsertDatabaseState());
      }).catchError((error) {
        print('Failed to Add todos into database, error ${error.toString()}');
      });
    });
  }

  deleteFromDatabase({required int id}) async {
    await database!.rawDelete('DELETE FROM todos WHERE id = ?', [id]).then((value) {
      getTodoDatabase(database);
      print('$value deleted successfully');
      emit(TodoDeleteDatabaseState());
    }).catchError((error) {
      print('Failed to delete database, error ${error.toString()}');
    });
  }
}
