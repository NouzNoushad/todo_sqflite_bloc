import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice/shared/constants/colors.dart';
import 'package:flutter_practice/shared/cubits/todo_cubit.dart';

import '../shared/cubits/todo_states.dart';

class NewTodo extends StatelessWidget {
  const NewTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.getContext(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: SafeArea(
            child: ListView.builder(
              itemCount: cubit.newTodo.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final todo = cubit.newTodo[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            todo['todo'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: 0.8),
                          ),
                          GestureDetector(
                            onTap: () {
                              cubit.deleteFromDatabase(id: todo['id']);
                            },
                            child: const Icon(
                              Icons.clear,
                              color: kDeleteColor,
                            ),
                          ),
                        ]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
