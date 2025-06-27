// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class AppointmentsModel {
  final String id;
  final String appointment_time;
  final String user_id;
  final String doctor_id;
  final int price;

  AppointmentsModel(
      {required this.id,
      required this.appointment_time,
      required this.user_id,
      required this.doctor_id,
      required this.price});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'appointmentDate': appointment_time,
      'user_id': user_id,
      'doctor_id': doctor_id,
      'price': price
    };
  }

  factory AppointmentsModel.fromMap(Map<String, dynamic> map) {
    return AppointmentsModel(
        id: map['id'].toString(),
        appointment_time: map['appointment_time'].toString(),
        user_id: map['user_id'].toString(),
        doctor_id: map['doctor_id'].toString(),
        price: map["price"] ?? 0);
  }

  String toJson() => json.encode(toMap());

  factory AppointmentsModel.fromJson(String source) =>
      AppointmentsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
