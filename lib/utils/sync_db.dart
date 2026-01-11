import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qrscan/models/students.dart';

Future<int> syncDatabase() async {
  const boxName = "students";

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

if (await Hive.boxExists(boxName)) {
    await Hive.deleteBoxFromDisk(boxName);
}

final box = await Hive.openBox<Students>(boxName);
final length = students.length;

  for (final studentJson in students) {
  final student = Students.fromJson(studentJson);
  await box.put(student.regNo, student);
}
await box.close();
return length;
}