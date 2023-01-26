import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice/shared/constants/colors.dart';

import 'layout/todo_app.dart';
import 'shared/cubits/todo_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..createDatabase(),
      child: MaterialApp(
        title: 'Flutter Bloc',
        theme: ThemeData(
          primarySwatch: kPrimarySwatch,
        ),
        debugShowCheckedModeBanner: false,
        home: const TodoApp(),
      ),
    );
  }
}
