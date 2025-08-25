import 'package:flutter/material.dart';
import 'package:notes/Models/NotesModel.dart';
import 'package:notes/Providers/Notesprovider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;


class notetaker extends StatefulWidget {
  notetaker({super.key});

  @override
  State<notetaker> createState() => _notetakerState();
}

class _notetakerState extends State<notetaker> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notesProvider = Provider.of<NotesProvider>(context, listen: false);
      final note = notesProvider.currentnote;
      if(note != null){
        titleController.text = note.title ?? '';
        _controller.document = quill.Document()..insert(0, note.content ?? '');
      }

    });
  }
 final TextEditingController titleController = TextEditingController();
final quill.QuillController _controller = quill.QuillController.basic();

bool _showtoolbar = false;


  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final notesProvider = Provider.of<NotesProvider>(context);
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: Column(
        children: [


          ListTile(
         leading: IconButton(onPressed: () async {
           final title = titleController.text;
           final content = _controller.document.toPlainText();
           if(notesProvider.currentnote == null){
              if(title.trim().isEmpty && content.trim().isEmpty){
                Navigator.pop(context);
                return;
              }
           }


           if(notesProvider.currentnote == null){
             final newnote = NotesModel(

               title: titleController.text,
               content: _controller.document.toPlainText(),
             );

             await notesProvider.createnote(newnote);

           }else{
             if(titleController.text.trim().isEmpty && _controller.document.toPlainText().trim().isEmpty){
               await notesProvider.deletenote(notesProvider.currentnote!.id!);
               Navigator.pop(context);
               return;
             }
             else{
             final updatednote = NotesModel(
               id: notesProvider.currentnote!.id,
               title: titleController.text,
               content: _controller.document.toPlainText(),
               pinned: notesProvider.currentnote!.pinned,
               createdAt: notesProvider.currentnote!.createdAt,
             );

             await notesProvider.updatenote(updatednote);
             }
           }
           Navigator.pop(context);
         }, icon:Icon(Icons.arrow_back,
         color: Colors.white,
         )
      ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: notesProvider.currentnote == null ? null : (){
                  notesProvider.togglePin(notesProvider.currentnote!.id!);


                }, icon:Icon(Icons.push_pin_outlined,
                color:notesProvider.currentnote?.pinned == true ? Colors.orange : Colors.white)
                ),

                IconButton(onPressed: () async{
                  if(titleController.text.trim().isEmpty && _controller.document.toPlainText().trim().isEmpty){
                    await notesProvider.deletenote(notesProvider.currentnote!.id!);
                    Navigator.pop(context);
                    return;
                  }
                  if(notesProvider.currentnote == null) {
                    final newnote = NotesModel(
                      title: titleController.text,
                      content: _controller.document.toPlainText(),
                    );
                  await  notesProvider.createnote(newnote);
                  Navigator.pop(context);
                  }else{
                    final updatednote = NotesModel(
                      id: notesProvider.currentnote!.id,
                      title: titleController.text.trim().isEmpty ? '' : titleController.text,
                      content: _controller.document.toPlainText().trim().isEmpty ? '' : _controller.document.toPlainText(),
                    );
                   await notesProvider.updatenote(updatednote);
                   Navigator.pop(context);
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

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: quill.QuillEditor.basic(
                controller: _controller,
                config: quill.QuillEditorConfig(
                  expands: true,

                  padding: EdgeInsets.all(8),
                ),

                ),

              ),
          ),
          




          ]
      ),

    ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(_showtoolbar ? Icons.close : Icons.format_size),
        onPressed: () {
          setState(() {
            _showtoolbar = !_showtoolbar;
          });
        },
      ),
      bottomSheet: _showtoolbar
      ?(isKeyboardOpen
      ? Container(
    color: Colors.grey.shade900,
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          quill.QuillSimpleToolbar(
            controller: _controller,
            config: quill.QuillSimpleToolbarConfig(

              showBoldButton: true,
              showItalicButton: true,
              showUnderLineButton: true,
              showHeaderStyle: true,
              showListBullets: true,
              showListNumbers: true,
              showQuote: true,
              showCodeBlock: true,
              showClipboardPaste: true,
              showColorButton: true,
              showFontSize: true,


            ),
          ),
        ],
      ),
    )
          : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                    color: Colors.grey.shade900,
                    height: 300, // like a keyboard dock
                    child: quill.QuillSimpleToolbar(
            controller: _controller,
            config: const quill.QuillSimpleToolbarConfig(
              showBoldButton: true,
              showItalicButton: true,
              showUnderLineButton: true,
              showHeaderStyle: true,
              showListBullets: true,
              showListNumbers: true,
              showQuote: true,
              showCodeBlock: true,
            ),
                    ),
                  ),
          ))
          : null,

    );

  }
}

