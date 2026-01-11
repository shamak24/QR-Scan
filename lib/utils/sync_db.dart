import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qrscan/models/students.dart';

const boxName = "students";
Box<Students> box = Hive.box<Students>(boxName);

Future<int> syncDatabase() async {
  final apiUrl = dotenv.env["API_URL"];
  if (apiUrl == null) {
    throw Exception("API_URL is not defined in environment variables");
  }
  final response = await http.get(Uri.parse(apiUrl));

  if(response.statusCode != 200){
    throw Exception("Failed to fetch data from API");
  }
  final Map<String, dynamic> decoded =
    jsonDecode(response.body);

final List<Map<String, dynamic>> students =
    List<Map<String, dynamic>>.from(decoded['data']);

// if (await Hive.boxExists(boxName)) {
//     await Hive.deleteBoxFromDisk(boxName);
// }


final length = students.length;

  for (final studentJson in students) {
  final student = Students.fromJson(studentJson);
  print('Syncing student: ${student.regNo}');
  await box.put(student.regNo, student);
}
box.flush();
  
return length;
}

Students? getStudentByRegNo(String regNo) {
  final student = box.get(regNo);
  if (student == null) {
    return null;
  }
  return student;
}