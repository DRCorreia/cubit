import 'package:cubit/app/pages/home/cubits/todo_cubit.dart';
import 'package:cubit/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TodoCubit(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          home: const MyHomePage(title: 'Aula Cubit'),
          debugShowCheckedModeBanner: false,
        ));
  }
}
