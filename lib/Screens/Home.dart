import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes/Providers/Notesprovider.dart';
import 'package:notes/Models/NotesModel.dart';
import 'package:notes/Screens/notetaker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<String?> _askForPin(BuildContext context) async{
    String pin = '';
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Password'),
          content: TextField(
            keyboardType: TextInputType.number,
            maxLength: 4,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter Pin',
            ),
            onChanged: (value) {
              pin = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, pin);
              },
              child: Text('OK'),
            ),
          ],

      );
      },

    );
  }
  String username = '';

  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotesProvider>(context, listen: false).getNotes();
    });
    _loadUsername();
  }
  void _loadUsername() async{
    final prefs = await SharedPreferences.getInstance();
      setState(() {
        username = prefs.getString('username') ?? '';
    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
    body: GestureDetector(
      onTap: (){
        final notesProvider = Provider.of<NotesProvider>(context, listen: false);
        notesProvider.clearSelection();
      },
      child: SafeArea(

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
               title: Text('Hello $username',
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
                     IconButton(onPressed: (){
                       Navigator.pushNamed(context, '/settings');
                     }, icon:Icon(Icons.settings),
                     ),

                     ]
                 )
             ),
              SizedBox(height: 10),

              SizedBox(height: 10),

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
                      mainAxisSpacing: 0,
                    ),
                  itemCount: notes.length,
                    itemBuilder: (context,index) {
                      final note = notes[index];
                      return GestureDetector(
                        onLongPress: (){
                          notesProvider.toggleSelection(note.id!);
                        },
                        child:Stack(
                          children: [

                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 150,
                        ),
                        child: Card(
                            color:notesProvider.selectedNotes.contains(note.id!) ? Colors.blueGrey.shade700 : Colors.grey.shade900,
                            margin: EdgeInsets.all(8),
                            child: Stack(
                              children: [
                          ListTile(

                                title:Text(

                                  (note.title == null || note.title!.trim().isEmpty) ? 'Untitled' : note.title!,
                                style: TextStyle(
                                   overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                 fontSize: 20,
                                                        color: Colors.white,
                                                        ),
                                ),
                                subtitle: Text(
                                    (note.content == null || note.content!.trim().isEmpty) ? 'No content' : note.content!,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade500,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis),
                                                         onTap: () async{
                                  if(notesProvider.selectionMode){
                                    notesProvider.toggleSelection(note.id!);

                                  }
                                  else if(note.locked){
                                      final enteredPin = await _askForPin(context);
                                      if(enteredPin == note.pincode){
                                        notesProvider.setCurrentNote(note);
                                        print("tapped ${note.title} ${note.content}");
                                        Navigator.push(
                                          context,
                                            MaterialPageRoute(builder: (_) => notetaker()),
                                        );
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Invalid pin'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    }
                                  else {
                                    notesProvider.setCurrentNote(note);
                                    print("tapped ${note.title} ${note.content}");
                                    Navigator.push(
                                      context,

                                      MaterialPageRoute(builder: (_) => notetaker()
                                      ),
                                    );
                                  }
                                                         },
                               trailing: (note.pinned ?? false) ?Icon(Icons.push_pin_outlined,
                               color: Colors.orange,) : null,

                              ),
                                if(note.locked) Positioned.fill(
                                  child: IgnorePointer(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child:BackdropFilter(
                                        filter:ImageFilter.blur(sigmaX:6,sigmaY:6),
                                        child: Container(
                                        color: Colors.black.withOpacity(0.5),
                                          alignment: Alignment.center,
                                          child: Icon(Icons.lock,
                                          color: Colors.white,
                                          size: 40,
                                          ),
                                        )
                                    
                                      )
                                    ),
                                  )
                                )
                      ]
                            ),

                          ),
                      ),
                      if(notesProvider.selectionMode)
                      Positioned(
                      top: 14,
                      right: 10,
                      child: Icon(
                      notesProvider.selectedNotes.contains(note.id!) ? Icons.check_circle_rounded : Icons.circle_outlined,
                      size: 15,
                      color: notesProvider.selectedNotes.contains(note.id!) ? Colors.orange : Colors.white,
                      ),
                      ),

                        ]
                        )
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
bottomNavigationBar: Consumer<NotesProvider>(
 builder: (context,notesProvider,child){
   if(!notesProvider.selectionMode){
     return SizedBox.shrink();
   }
   return BottomAppBar(
  color: Colors.black54,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
         IconButton(
           tooltip: "delete",
           onPressed: (){
           notesProvider.selectedNotes.forEach((noteId) {
             notesProvider.deletenote(noteId);
           });
            notesProvider.selectedNotes.clear();
         }, icon: Icon(Icons.delete,

       color: Colors.red,
   ),
         ),
         IconButton(
           tooltip: "Lock",
             onPressed: () async{
             final pin = await _askForPin(context);
             if(pin != null && pin.length == 4){
               notesProvider.selectedNotes.forEach((noteId) {
                 notesProvider.lockNote(noteId, pin);
               });
               notesProvider.selectedNotes.clear();
             }else{
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                   content: Text('Enter a valid 4-Digit pin'),
                   duration: Duration(seconds: 2),
                 ),
               );
             }
             }, icon: Icon(Icons.lock_outline,
         size: 20,
   )
         )
         ,
         IconButton(
           tooltip: "Pin a note",
             onPressed: (){
           notesProvider.selectedNotes.forEach((noteId) {
             notesProvider.togglePin(noteId);
           });
         }, icon: Icon(Icons.push_pin_outlined,

         size: 20,
   )
         )
         ]
     )
   );
 }
)
    );
  }
}
