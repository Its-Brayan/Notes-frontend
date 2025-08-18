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
      return true;
    }
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
  Future<bool> updatenote(NotesModel notes) async{
    notifyListeners();
    final success = await NotesServices().updateNote(notes);
    if(!success){
      _errorMessage = 'Failed to update note';
      return false;
    }else{
      notifyListeners();
      return true;
    }
  }
  Future<List<NotesModel>> getNotes() async{
    notifyListeners();
    _notes = await NotesServices().getNotes();
    notifyListeners();
    return notes;
  }

  }
