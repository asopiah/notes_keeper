import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  int count =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// scaffold as root element
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNotesListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          return debugPrint ("Floating Action Button");
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNotesListView() {
    TextStyle titleStyle = Theme
        .of(context)
        .textTheme
        .subtitle1;

    /// return the list view using a builder function
    return ListView.builder(
        itemCount: count,
      itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text('Dumy Title', style: titleStyle,),
              subtitle: Text("Dummy Date", style: titleStyle,),
              trailing: Icon(Icons.delete, color: Colors.grey,),

              onTap: (){
                return debugPrint ("Next Screen");
              },
            ),
          );
      },
    );
  }
}