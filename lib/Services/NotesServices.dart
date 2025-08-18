import 'package:notes/Models/NotesModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class NotesServices{
  final baseUrl = 'http://10.7.5.22:8000';
  Future<bool> createnote(NotesModel notes) async{
        final response = await http.post(
          Uri.parse('$baseUrl/create_note/'),
          headers:{
            'Content-Type':'application/json'
          },
          body: jsonEncode(notes.toJson())
        );
        if(response.statusCode==201){
          return true;
        }else{
          return false;
        }
  }

  Future<bool> updateNote(NotesModel notes) async{
    final response = await http.patch(
      Uri.parse('$baseUrl/update_note/${notes.id}/'),
      headers:{
        'Content-Type':'application/json'
      },
      body: jsonEncode(notes.toJson())
    );
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }

  }
}
