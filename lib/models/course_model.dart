// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:GermAc/models/doctor_model.dart';
import 'package:GermAc/models/section_model.dart';

class CourseModel {
  final String id;
  final String section_id;
  final String name;
  final String description;
  final String date;
  final String rate;
  final String created_at;
  final String image;
  final String updated_at;
  final List<DoctorModel>? doctors;
  final SectionModel? section;

  CourseModel(
      {required this.id,
      required this.section_id,
      required this.name,
      required this.description,
      required this.date,
      required this.rate,
      required this.created_at,
      required this.image,
      required this.updated_at,
      this.doctors,
      this.section});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'section_id': section_id,
      'name': name,
      'description': description,
      'date': date,
      'rate': rate,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> doctorsList = map['doctors'] ?? [];
    List<DoctorModel> doctors = doctorsList
        .map<DoctorModel>((doctor) => DoctorModel.fromMap(doctor))
        .toList();

    return CourseModel(
        id: map['id'].toString(),
        section_id: map['section_id'].toString(),
        name: map['name'].toString(),
        description: map['description'].toString(),
        date: map['date'].toString(),
        rate: map['rate'].toString(),
        created_at: map['created_at'].toString(),
        image: map['image'].toString(),
        updated_at: map['updated_at'].toString(),
        doctors: doctors,
        section: SectionModel.fromMap(map['section'] ?? {}));
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseModel(id: $id, section_id: $section_id, name: $name, description: $description, date: $date, rate: $rate, created_at: $created_at, updated_at: $updated_at)';
  }
}
