import 'package:flutter/foundation.dart';

class NotesModel{
  int? id;
  String? title;
  String? content;
  bool? pinned ;
  bool locked;
  String? pincode;
  DateTime createdAt;
  bool unlocked = false;

  NotesModel({this.id,this.title,this.content,this.pinned = false,this.locked = false,this.pincode,DateTime? createdAt,}) : createdAt = createdAt ?? DateTime.now();
  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'title':title,
      'content':content,
      'pinned':pinned,
      'locked':locked,
      'pincode':pincode,
      'unlocked':unlocked,
      'createdAt':createdAt.toIso8601String(),
    };
  }
 NotesModel.fromJson(Map<String,dynamic> json)
    :id = json['id'],
    title = json['title'],
    content = json['content'],
    pinned = json['pinned'] ?? false,
    locked = json['locked'] ?? false,
    pincode = json['pincode'],
    unlocked = json['unlocked'] ?? false,
    createdAt = DateTime.tryParse(json['createdAt']?? '') ?? DateTime.now();




  }
