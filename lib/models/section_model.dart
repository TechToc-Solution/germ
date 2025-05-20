// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'package:GermAc/models/course_model.dart';

class SectionModel {
  final String id;
  final String name;
  final String description;
  final String created_at;
  final String updated_at;
  final List<CourseModel>? coursesModel;

  SectionModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.created_at,
      required this.updated_at,
      this.coursesModel});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory SectionModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> coursesList = map['courses'] ?? [];
    List<CourseModel> courses = coursesList
        .map<CourseModel>((course) => CourseModel.fromMap(course))
        .toList();

    return SectionModel(
        id: map['id'].toString(),
        name: map['name'].toString(),
        description: map['description'].toString(),
        created_at: map['created_at'].toString(),
        updated_at: map['updated_at'].toString(),
        coursesModel: courses);
  }

  String toJson() => json.encode(toMap());

  factory SectionModel.fromJson(String source) =>
      SectionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
