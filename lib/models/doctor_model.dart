// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:GermAc/models/appointment_model.dart';
import 'package:GermAc/models/course_model.dart';
import 'package:GermAc/models/section_model.dart';

class DoctorModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String section_id;
  final String current_working_place;
  final String professional_title;
  final String description;
  final String image;
  final String specialization;
  final String rate;
  final Pivot? pivot;
  final String created_at;
  final String updated_at;
  final List<SectionModel>? sections;
  final List<CourseModel>? courses;
  final List<AppointmentsModel>? appointments;
  DoctorModel({
    required this.pivot,
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.section_id,
    required this.current_working_place,
    required this.professional_title,
    required this.description,
    required this.image,
    required this.specialization,
    required this.rate,
    required this.created_at,
    required this.updated_at,
    this.sections,
    this.courses,
    this.appointments,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'section_id': section_id,
      'description': description,
      'image': image,
      'specialization': specialization,
      'rate': rate,
      'created_at': created_at,
      'updated_at': updated_at,
      'sections': sections?.map((x) => x.toMap()).toList(),
      'courses': courses?.map((x) => x.toMap()).toList(),
      'appointments': appointments?.map((x) => x.toMap()).toList(),
      'role': role,
      'current_working_place': current_working_place,
      'professional_title': professional_title,
      'pivot': pivot?.toMap(),
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'].toString(),
      name: map['name'].toString(),
      email: map['email'].toString(),
      role: map['role'].toString(),
      section_id: map['section_id'].toString(),
      current_working_place: map['current_working_place'].toString(),
      professional_title: map['professional_title'].toString(),
      description: map['description'].toString(),
      image: map['image'].toString(),
      specialization: map['specialization'].toString(),
      rate: map['rate'].toString(),
      created_at: map['created_at'].toString(),
      updated_at: map['updated_at'].toString(),
      sections: map['sections'] != null
          ? List<SectionModel>.from(
              map['sections'].map((x) => SectionModel.fromMap(x)))
          : null,
      courses: map['courses'] != null
          ? List<CourseModel>.from(
              map['courses'].map((x) => CourseModel.fromMap(x)))
          : null,
      appointments: map['appointments'] != null
          ? List<AppointmentsModel>.from(
              map['appointments'].map((x) => AppointmentsModel.fromMap(x)))
          : null,
      pivot: map['pivot'] != null ? Pivot.fromMap(map['pivot']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
