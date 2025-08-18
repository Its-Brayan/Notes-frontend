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
}