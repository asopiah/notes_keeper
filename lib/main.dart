import 'package:flutter/material.dart';
import 'package:notes_keeper/screens/note_list.dart';

void main(){ /// main function
  runApp(MyApp()); /// runApp function and pass a stateless widget

  }

  class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     title: 'NoteKeeper',
     debugShowCheckedModeBanner: false, /// turn debug mode off
     theme: ThemeData(
       primarySwatch: Colors.deepPurple
     ),

     home: NoteList(),

   );
  }

  }

