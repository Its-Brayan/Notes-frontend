import 'package:flutter/material.dart';
import 'package:notes/Models/NotesModel.dart';
import 'package:notes/Providers/Notesprovider.dart';
import 'package:provider/provider.dart';
class notetaker extends StatelessWidget {
  notetaker({super.key});
 final TextEditingController titleController = TextEditingController();
 final TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    return  Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(child: Column(
        children: [
          ListTile(
         leading: IconButton(onPressed: () async {
           if(notesProvider.currentnote == null){
             final newnote = NotesModel(

               title: titleController.text,
               content: contentController.text,
             );
             await notesProvider.createnote(newnote);

           }else{
             final updatednote = NotesModel(
               id: notesProvider.currentnote!.id,
               title: titleController.text,
               content: contentController.text,
             );
             await notesProvider.updatenote(updatednote);
           }
           Navigator.pop(context);
         }, icon:Icon(Icons.arrow_back,
         color: Colors.white,
         )
      ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: (){}, icon:Icon(Icons.push_pin_outlined,
                color:Colors.white)
                ),
                IconButton(onPressed: (){}, icon:Icon(Icons.lock_outline,
                  color: Colors.white,
                ),
                ),
                IconButton(onPressed: () async{
                  if(notesProvider.currentnote == null) {
                    final newnote = NotesModel(
                      title: titleController.text,
                      content: contentController.text,
                    );
                  await  notesProvider.createnote(newnote);
                  }else{
                    final updatednote = NotesModel(
                      id: notesProvider.currentnote!.id,
                      title: titleController.text,
                      content: contentController.text,
                    );
                   await notesProvider.updatenote(updatednote);
                  }
                }, icon:Icon(Icons.check_circle_outline,
                color: Colors.white,
                )
                ),
              ],
            ),
    ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey.shade100,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              // onEditingComplete: (){
              // final notestitle = NotesModel(
              //  title: titleController.text,
              // );
              // notesProvider.updatenote(notestitle);
              //
              // },

              toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: true,
                selectAll: true,
              ),
              decoration: InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              maxLines: null,
               cursorColor: Colors.orange,
               keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              textAlign: TextAlign.start,
              enableSuggestions: true,
              autofocus: true,
              controller: titleController,

              style: TextStyle(

                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),

              showCursor: true,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(

              cursorColor: Colors.orange,
              textDirection: TextDirection.ltr,
              toolbarOptions: ToolbarOptions(
                copy: true,
                cut: true,
                paste: true,
                selectAll: true,
              ),
              decoration: InputDecoration(
                hintText: 'Take a note...',
                border: InputBorder.none,
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              textAlign: TextAlign.start,
              enableSuggestions: true,
              autofocus: true,
              controller: contentController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              ),

            ),



          
          ]
      )),
    );
  }
}
