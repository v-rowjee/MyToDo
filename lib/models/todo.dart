class Todo{
  final String id, title, desc;

  Todo({
    required this.id,
    required this.title,
    required this.desc
  });

  Map<String,dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'desc' : desc
  };

  static Todo fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'],
    title: json['title'],
    desc: json['desc'],
  );

}