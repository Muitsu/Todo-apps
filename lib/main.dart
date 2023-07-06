import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/pages/edit/bloc/manage_todo_list_bloc.dart';
import 'package:todo_app/pages/home/bloc/todo_list_bloc.dart';
import 'app_themes.dart';
import 'pages/home/home_page.dart';

void main() {
  runApp(
      //Register Bloc
      MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => TodoListBloc(InitTodoList())),
      BlocProvider(
          create: (context) => ManageTodoListBloc(InitManageTodoList())),
    ],
    child: MaterialApp(
      theme: AppThemes.theme1,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  ));
}
