import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/golf_bloc.dart';
import 'controller/golf_event.dart';
import 'golf_table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GolfBloc()..add(const LoadGolfData()), // Initialize the GolfBloc and trigger the initial event
      child: MaterialApp(
        title: 'Golf Score App - Github(abhishek golf)',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: GolfTablePage(), // Set GolfTablePage as the home widget
      ),
    );
  }
}