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
          print(response.body);
          return true;
        }else{
          return false;
        }
  }
Future<NotesModel?> getNote(int noteid) async{
    final response = await http.get(
      Uri.parse('$baseUrl/update_note/$noteid/'),
      headers:{
        'Content-Type':'application/json'
      },
    );
      if(response.statusCode==200){
        final Map<String,dynamic> data = jsonDecode(response.body);
        print(data);
        return NotesModel.fromJson(data);
      }else{
        return null;
    }


}
Future<List<NotesModel>> getNotes() async {
final response = await http.get(
 Uri.parse('$baseUrl/create_note/'),
  headers: {
    'Content-Type':'application/json'
  },
);
if(response.statusCode==200){
  final List<dynamic> data = jsonDecode(response.body);
  print(data);
  return data.map((item) => NotesModel.fromJson(item)).toList();
}else{
  return [];
  }

}
  Future<bool> updateNote(NotesModel notes) async{
    final response = await http.put(
        Uri.parse('$baseUrl/update_note/${notes.id}/'),
        headers:{
          'Content-Type':'application/json'
        },
        body: jsonEncode(notes.toJson())
    );
    if(response.statusCode==200){
      print("Note edited");
      print(response.body);
      return true;

    }else{
      print("Error editing the note");
      return false;
    }

  }
  Future<bool> deleteNote(int noteid) async{
    final response = await http.delete(
      Uri.parse('$baseUrl/update_note/$noteid/'),
      headers:{
        'Content-Type':'application/json'
      },
    );
    if(response.statusCode==204){
      print("Note deleted");
      return true;
    }else{
      print("Error deleting the note");
      return false;
    }

    }
    Future<void> lockNote(int noteid,String pin) async{
      final response = await http.post(
        Uri.parse('$baseUrl/update_note/$noteid/'),
        headers:{
          'Content-Type':'application/json'
        },
      );
      if(response.statusCode==201){
        print("Note locked");
        print(response.body);
      }else{
        print("Error locking the note");
      }

    }
    Future<void> unlockNote(int noteid) async {
      final response = await http.post(
        Uri.parse('$baseUrl/update_note/$noteid/'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 201) {
        print("Note unlocked");
        print(response.body);
      } else {
        print("Error unlocking the note");
      }

    }
}


