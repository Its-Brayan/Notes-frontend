import 'package:flutter/material.dart';
class about extends StatelessWidget {
  const about({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("About"),
        automaticallyImplyLeading: true,

      ),
      body: SafeArea(child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text("NotesApp is a sleek and intuitive note-taking application designed to help you capture ideas, organize thoughts, and stay productive wherever you are. "
                      "\n\nIt allows you to quickly create and edit notes, pin important ones to the top, and easily manage multiple notes with selection mode for bulk actions like delete, lock, or pin. With a clean, responsive layout and automatic saving, NotesApp ensures your notes are always accessible and well-organized, making it perfect for reminders, ideas, or daily task management.",
                  style: TextStyle(
                    fontSize: 16,
                    wordSpacing: 3,

                  ),),
                ),
              ),
            ),
          )
        ],
      )
      )
    );
  }
}
