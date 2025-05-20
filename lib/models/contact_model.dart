// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class ContactModel {
  final String id;
  final String location;
  final String email;
  final String call;
  final String created_at;
  final String updated_at;

  ContactModel({
    required this.id,
    required this.location,
    required this.email,
    required this.call,
    required this.created_at,
    required this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'location': location,
      'email': email,
      'call': call,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'].toString(),
      location: map['location'].toString(),
      email: map['email'].toString(),
      call: map['call'].toString(),
      created_at: map['created_at'].toString(),
      updated_at: map['updated_at'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
