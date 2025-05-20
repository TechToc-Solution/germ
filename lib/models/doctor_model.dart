// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class DoctorModel {
  final String id;
  final String name;
  final String email;
  final String section_id;
  final String description;
  final String image;
  final String specialization;
  final String rate;
  final String created_at;
  final String updated_at;
  DoctorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.section_id,
    required this.description,
    required this.image,
    required this.specialization,
    required this.rate,
    required this.created_at,
    required this.updated_at,
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
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'].toString(),
      name: map['name'].toString(),
      email: map['email'].toString(),
      section_id: map['section_id'].toString(),
      description: map['description'].toString(),
      image: map['image'].toString(),
      specialization: map['specialization'].toString(),
      rate: map['rate'].toString(),
      created_at: map['created_at'].toString(),
      updated_at: map['updated_at'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
