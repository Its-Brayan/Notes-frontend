import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes/Providers/Notesprovider.dart';
import 'package:notes/Models/NotesModel.dart';
import 'package:notes/Screens/notetaker.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotesProvider>(context, listen: false).getNotes();
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black54,
    body: SafeArea(

      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
           ListTile(
             leading: CircleAvatar(
               radius: 20,

               child: Image.network('https://cdn-icons-png.flaticon.com/128/3048/3048122.png',
                 width: 25,
                 height: 30,
                 fit: BoxFit.cover,
               ),
             ),
             title: Text('Hello Brayan',
             style: TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.bold,
             ),
             ),
               trailing:Row(
                mainAxisAlignment:MainAxisAlignment.end,
                 mainAxisSize: MainAxisSize.min,
                 children: [

                   IconButton(onPressed: (){}, icon:Icon(Icons.search),
                   ),
                   IconButton(onPressed: (){}, icon:Icon(Icons.settings),
                   ),

                   ]
               )
           ),
            SizedBox(height: 10),
            Divider(

              color: Colors.grey.shade100,
            ),
            SizedBox(height: 30),

          Expanded(
            child: Consumer<NotesProvider>(
              builder: (context,notesProvider,child){
                final notes = notesProvider.notes;
                if(notes.isEmpty){
                 return Center(
                 child: Text('No notes yet'),
                 );
                }
                return GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                itemCount: notes.length,
                  itemBuilder: (context,index) {
                    final note = notes[index];
                    return Card(
                      color:Colors.grey.shade900,
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title:Text(note.title ?? "Untitled",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                         fontSize: 20,
                    color: Colors.white,
                    ),
                        ),
                        subtitle: Text(note.content ?? "",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade500,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis),
                     onTap: (){
                          notesProvider.setCurrentNote(note);
                          print("tapped ${note.title} ${note.content}");
                          Navigator.push(
                              context,

                              MaterialPageRoute(builder: (_)=>notetaker()
                       ),
                          );
                     },
                      ),
                    );
                  }
                );
              }
            ),
          )

          ],

        ),
      ),
    ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: (){
          final notesProvider = Provider.of<NotesProvider>(context, listen: false);
          notesProvider.setCurrentNote(null);
          Navigator.pushNamed(context, '/takenotes');
        },
        child: Icon(Icons.add,
        size: 30,
        color: Colors.white,),
      ),
    );
  }
}
