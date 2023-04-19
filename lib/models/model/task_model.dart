class TaskModel {
  final int? id;
  final String title;
  final String description;
  final String date;
  final String image;
  final String status;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.image,
    required this.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        date: json['date'],
        image: json['image'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'date': date, 
        'image': image,
        'status': status,
      };
}
