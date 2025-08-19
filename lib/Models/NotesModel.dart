import 'package:flutter/foundation.dart';

class NotesModel{
  int? id;
  String? title;
  String? content;
  bool? pinned ;
  DateTime createdAt;

  NotesModel({this.id,this.title,this.content,this.pinned = false,DateTime? createdAt,}) : createdAt = createdAt ?? DateTime.now();
  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'title':title,
      'content':content,
      'pinned':pinned,
      'createdAt':createdAt.toIso8601String(),
    };
  }
 NotesModel.fromJson(Map<String,dynamic> json)
    :id = json['id'],
    title = json['title'],
    content = json['content'],
    pinned = json['pinned'] ?? false,
    createdAt = DateTime.tryParse(json['createdAt']?? '') ?? DateTime.now();




  }
