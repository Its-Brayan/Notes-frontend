import 'package:flutter/cupertino.dart';
import 'package:notes/Models/NotesModel.dart';
import 'package:notes/Services/NotesServices.dart';
import 'package:provider/provider.dart';

class NotesProvider with ChangeNotifier{
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

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

  }
