import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice/shared/components/custom_form_fields.dart';
import 'package:flutter_practice/shared/constants/colors.dart';

import '../shared/cubits/todo_cubit.dart';
import '../shared/cubits/todo_states.dart';

var _formKey = GlobalKey<FormState>();
var _todoController = TextEditingController();

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.getContext(context);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFormFields(
                      hintText: 'Todo',
                      controller: _todoController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return cubit.validationError();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit
                                  .addToDatabase(todo: _todoController.text)
                                  .then((value) {
                                _todoController.clear();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Lets Go')),
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }
}
