import 'package:flutter/foundation.dart';

class NotesModel{
  int? id;
  String? title;
  String? content;

  NotesModel({this.id,this.title,this.content});
  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'title':title,
      'content':content,
    };
  }
NotesModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    title = json['title'];
    content = json['content'];

    }
  }
