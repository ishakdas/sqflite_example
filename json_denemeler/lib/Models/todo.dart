class Todo {
  int id;
  int userId;
  bool complated;
  String title;
  Todo(int id, int userId, bool complated, String title) {
    this.id = id;
    this.userId = userId;
    this.title = title;
    this.title = title;
  }
  Todo.fromJson(Map json) {
    id = json["id"];
    userId = json["userId"];
    complated = json["complated"];
    title = json["title"];
  }
  Map toJson() {
    return {"id": id, "userId": userId, "complated": complated, "title": title};
  }
}
