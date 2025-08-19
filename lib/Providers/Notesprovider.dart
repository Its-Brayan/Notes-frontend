import 'package:flutter/cupertino.dart';
import 'package:notes/Models/NotesModel.dart';
import 'package:notes/Services/NotesServices.dart';
import 'package:provider/provider.dart';

class NotesProvider with ChangeNotifier{
  List<NotesModel> _notes = [];
  List<NotesModel> get notes => _notes;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  NotesModel? _currentnote;
  NotesModel? get currentnote => _currentnote;

  Future<bool> createnote(NotesModel notes) async{
    notifyListeners();
    final success = await NotesServices().createnote(notes);
    if(!success){
      _errorMessage = 'Failed to create note';
      return false;
    }else{
      notifyListeners();
      await getNotes();
      return true;
    }
  }
  void setCurrentNote(NotesModel? note){
    _currentnote = note;
    notifyListeners();
  }
Future<void> getnotebyid(int noteid) async{
    notifyListeners();
    try {
      _currentnote = await NotesServices().getNote(noteid);
    }catch(e){
      _errorMessage = 'Failed to fetch note';
    }finally{
      notifyListeners();
    }


}
  Future<bool> updatenote(NotesModel note) async{

    if(note.id == null){
      return false;
    }
    else {
      final success = await NotesServices().updateNote(note);
      if (success) {
       final index = _notes.indexWhere((note) => note.id == note.id);
        if (index != -1) {
          _notes[index] = note;
          _currentnote = note;
          notifyListeners();
          return true;
        } else {
          notifyListeners();
          return false;
        }
      } else {
        notifyListeners();
        return true;
      }
    }
  }
  Future<List<NotesModel>> getNotes() async{

    _notes = await NotesServices().getNotes();
    print(_notes.length);
    notifyListeners();
    return notes;
  }

  }
