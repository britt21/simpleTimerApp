class Todo {
  late final String description;
  late bool isCompleted;
  late bool isFavorite;
  late String currentTime;
  late int index;


  Todo({required this.description, required this.isCompleted});

  Todo copyWith({
    String? description,
    bool? isCompleted,

}){
    return Todo(description: description ?? this.description, isCompleted: isCompleted ?? this.isCompleted);
  }
  factory Todo.fromJson(Map<String, dynamic> json){
    return Todo(
        description: json["description"],
        isCompleted: json["isCompleted"]);
  }


  Map<String,dynamic> toJson(){
    return {
      "description" : description,
      "isCompleted" : isCompleted,
    };
  }


}