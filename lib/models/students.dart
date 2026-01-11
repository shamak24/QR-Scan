import 'package:hive/hive.dart';
part 'students.g.dart';

@HiveType(typeId: 0)
class Students extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String regNo;

  @HiveField(2)
  final String email;

  Students({
    required this.regNo,
    required this.name,
    required this.email,
  });

  factory Students.fromJson(Map<String, dynamic> json) {
    return Students(
      regNo: json['regNo'],
      name: json['name'],
      email: json['email'],
    );
  }
}