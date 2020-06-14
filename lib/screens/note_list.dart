import 'package:flutter/material.dart';
import 'package:notes_keeper/screens/note_detail.dart';

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
          debugPrint ("Floating Action Button");
          ///Navigator push() operation using navigator widget
          navigateToDetail('Add Note');
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
                debugPrint ("Next Screen");
                navigateToDetail('Edit Note');
              },
            ),
          );
      },
    );
  }
/// function to push from one screen to another
  /// use navigator widget
  void navigateToDetail(String title){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return NoteDetail(title);
    }));
  }
}