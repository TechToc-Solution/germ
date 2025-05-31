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
  final String? rate;
  final String created_at;
  final String image;
  final String updated_at;
  final int price;
  final String currency;
  final String duration;
  final String time;
  final Pivot? pivot;
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
      this.section,
      required this.price,
      required this.currency,
      required this.duration,
      required this.time,
      required this.pivot});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'section_id': section_id,
      'name': name,
      'description': description,
      'date': date,
      'price': price,
      'currency': currency,
      'duration': duration,
      'time': time,
      'rate': rate,
      'image': image,
      'pivot': pivot?.toMap(),
      'doctors': doctors?.map((x) => x.toMap()).toList(),
      'section': section?.toMap(),
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
        price: map['price'],
        currency: map['currency'],
        duration: map['date'],
        time: map['time'],
        pivot: map['pivot'] != null ? Pivot.fromMap(map['pivot']) : null,
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

class Pivot {
  final String course_id;
  final String doctor_id;

  Pivot({required this.course_id, required this.doctor_id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'course_id': course_id,
      'doctor_id': doctor_id,
    };
  }

  factory Pivot.fromMap(Map<String, dynamic> map) {
    return Pivot(
        course_id: map['course_id'].toString(),
        doctor_id: map['doctor_id'].toString());
  }
}
