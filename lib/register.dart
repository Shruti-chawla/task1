import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task1/services/register_service.dart';
import 'package:task1/verification.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  String? _selectedCourse;
  String? _selectedSubCourse;

  //List<String> _subCourses = ['Sub Course 1', 'Sub Course 2', 'Sub Course 3'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchCourse();

  }

  late List<dynamic> courseData = [];
  List<String> _courses = [];
  fetchCourse() async{


    var response = await RegisterService().fetchCourses();
    if(response.statusCode == 200){
      final data = jsonDecode(response.body) as Map<String, dynamic>; // Cast to Map<String, dynamic>
      setState(() {
        courseData = data['data']; // Extract the 'data' list
        _courses = courseData.map((course) => course['name'] as String).toList(); // Extract course names
        _selectedCourse = _courses.isNotEmpty ? _courses.first : null; // Set initial selected course
      });
    }
  }

  late List<dynamic> subCourseData = [];
  List<String> _subCourses = [];
  fetchSubCourseList(int course) async{
    var response = await RegisterService().fetchSubCourses(course);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body) as Map<String, dynamic>; // Cast to Map<String, dynamic>
      setState(() {
        subCourseData = data['data'];
        _subCourses = subCourseData.map((subCourse) => subCourse['name'] as String).toList(); // Extract subcourse names
        _selectedSubCourse = _subCourses.isNotEmpty ? _subCourses.first : null; // Set initial selected subcourse
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 0, 56),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                'Mobile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _mobileController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                'Course',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
            DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              value: _selectedCourse,
              items: _courses.map((course) {
                return DropdownMenuItem(
                  value: course,
                  child: Text(
                    course,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCourse = newValue;
                  print(_selectedCourse);
                  fetchSubCourseList(1);
                });
              },
            ),
              SizedBox(height: 20),
              Text(
                'Sub Course',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                value: _selectedSubCourse,
                items: _subCourses.map((subCourse) {
                  return DropdownMenuItem(
                    value: subCourse,
                    child: Text(
                      subCourse,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedSubCourse = newValue;
                  });
                },
              ),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  // Handle registration submission
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Verification()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Register(),
  ));
}
