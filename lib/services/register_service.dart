import 'dart:convert';

import 'package:http/http.dart' as http;

class RegisterService {
  Future<http.Response> register(String name, String email, String mobile, int course, int subCourse) async{

    final data = jsonEncode({'name': name, 'email': email, 'mobile': mobile, 'course':course, 'sub_course' :subCourse});
    final response = await http.post(
        Uri.parse('https://demo.webdesigncompanyinbhiwadi.xyz/flutter-task/signup.php'),
        body: data,
    );
    print(response.body);

    return response;
  }
  Future<http.Response> fetchSubCourses(int course) async {

    final data = jsonEncode({'course': course});
    final response = await http.post(Uri.parse(
        "https://demo.webdesigncompanyinbhiwadi.xyz/flutter-task/sub-courses.php"),
        body: data,
    );

    print(response.body);
    return response;

  }

  Future<http.Response> fetchCourses() async {

      final response = await http.get(Uri.parse(
          "https://demo.webdesigncompanyinbhiwadi.xyz/flutter-task/courses.php")
      );

      print(response.body);
      return response;

  }
}