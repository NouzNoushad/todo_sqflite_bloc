import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice/shared/constants/colors.dart';
import 'package:flutter_practice/shared/cubits/todo_cubit.dart';

import '../shared/cubits/todo_states.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.getContext(context);
        return Scaffold(
          backgroundColor: kBackgroundColor,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: kPrimaryColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: kSelectedItemColor,
            currentIndex: cubit.selectedNavigationIndex,
            onTap: (index) {
              cubit.changeBottomNavIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle),
                label: '',
              ),
            ],
          ),
          appBar: AppBar(
            title: const Text('Todo App'),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
          ),
          body: cubit.navigationScreens[cubit.selectedNavigationIndex],
        );
      },
    );
  }
}
