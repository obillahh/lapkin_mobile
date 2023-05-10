// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  final String title;
  final String date;
  final String startTime;
  final String finishTime;
  final String description;
  final String image;
  final String file;

  TaskModel({
    required this.title,
    required this.date,
    required this.startTime,
    required this.finishTime,
    required this.description,
    required this.image,
    required this.file,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'date': date,
      'startTime': startTime,
      'finishTime': finishTime,
      'description': description,
      'image': image,
      'file': file,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] as String,
      date: map['date'] as String,
      startTime: map['startTime'] as String,
      finishTime: map['finishTime'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      file: map['file'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
