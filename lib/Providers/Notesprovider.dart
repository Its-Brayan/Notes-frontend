import 'package:flutter/cupertino.dart';
import 'package:notes/Models/NotesModel.dart';
import 'package:notes/Services/NotesServices.dart';
import 'package:provider/provider.dart';

class NotesProvider with ChangeNotifier {


  Set<int> _selectedNotes = {};

  bool get selectionMode => _selectedNotes.isNotEmpty;

  Set<int> get selectedNotes => _selectedNotes;
  List<NotesModel> _notes = [];

  List<NotesModel> get notes => _notes;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  NotesModel? _currentnote;

  NotesModel? get currentnote => _currentnote;

  void togglePin(int noteId) {
    final notesIndex = _notes.indexWhere((note) => note.id == noteId);
    if (notesIndex != -1) {
      _notes[notesIndex].pinned = !_notes[notesIndex].pinned!;
      notifyListeners();
      _notes.sort((a, b) {
        final aPinned = a.pinned ?? false;
        final bPinned = b.pinned ?? false;
        if (aPinned && !bPinned) return -1;
        if (!aPinned && bPinned) return 1;
        return a.createdAt.compareTo(b.createdAt);
      });
      notifyListeners();
    }
  }

  void toggleSelection(int noteId) {
    if (_selectedNotes.contains(noteId)) {
      _selectedNotes.remove(noteId);
    } else {
      _selectedNotes.add(noteId);
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedNotes.clear();
    notifyListeners();
  }

  Future<bool> createnote(NotesModel notes) async {
    notifyListeners();
    final success = await NotesServices().createnote(notes);
    if (!success) {
      _errorMessage = 'Failed to create note!';
      return false;
    } else {
      notifyListeners();
      await getNotes();
      return true;
    }
  }

  void setCurrentNote(NotesModel? note) {
    _currentnote = note;
    notifyListeners();
  }

  Future<void> getnotebyid(int noteid) async {
    notifyListeners();
    try {
      _currentnote = await NotesServices().getNote(noteid);
    } catch (e) {
      _errorMessage = 'Failed to fetch note';
    } finally {
      notifyListeners();
    }
  }

  Future<bool> updatenote(NotesModel note) async {
    if (note.id == null) {
      return false;
    }
    else {
      final success = await NotesServices().updateNote(note);
      if (success) {
        final index = _notes.indexWhere((n) => n.id == note.id);
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

  Future<List<NotesModel>> getNotes() async {
    _notes = await NotesServices().getNotes();

    _notes.sort((a, b) {
      final aPinned = a.pinned ?? false;
      final bPinned = b.pinned ?? false;
      if (aPinned && !bPinned) return -1;
      if (!aPinned && bPinned) return 1;
      return a.createdAt.compareTo(b.createdAt);
    });
    notifyListeners();
    return notes;
  }

  Future<bool> deletenote(int noteid) async {
    final success = await NotesServices().deleteNote(noteid);
    if (success) {
      _notes.removeWhere((n) => n.id == noteid);
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  void lockNote(int NoteId, String pin) {
    final notesIndex = _notes.indexWhere((n) => n.id == NoteId);
    if (notesIndex != -1) {
      _notes[notesIndex].locked = true;
      _notes[notesIndex].pincode = pin;
      notifyListeners();
    }
  }

  Future<bool> unlockNote(int noteid, String pin) async {
    final bool success = await NotesServices().unlockNote(noteid, pin);
    if (success) {
      final notesIndex = _notes.indexWhere((n) => n.id == noteid);
      if (notesIndex != -1) {
        _notes[notesIndex].locked = false;
        _notes[notesIndex].pincode = null;
        notifyListeners();
      }
    }
    return success;
  }

  Future<void> lockNoteById(int noteId, String pin) async {
    bool success = await NotesServices().lockNote(noteId, pin);
    if (success) {
      final notesIndex = _notes.indexWhere((n) => n.id == noteId);
      if (notesIndex != -1) {
        _notes[notesIndex].locked = true;
        notifyListeners();
      }
    }

  }
}
