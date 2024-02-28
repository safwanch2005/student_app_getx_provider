import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app_provider/model/model.dart';
import 'package:image_picker/image_picker.dart';

const String dbName = 'student_database';

class ScreenProvider extends ChangeNotifier {
  List<StudentModel> allStudentList = <StudentModel>[];

  Future<void> addStudent(StudentModel data) async {
    final db = await Hive.openBox<StudentModel>(dbName);
    data.id = await db.add(data);
    db.put(data.id, data);
    await getStudents();
    notifyListeners();
  }

  Future<void> editStudent(StudentModel data) async {
    final db = await Hive.openBox<StudentModel>(dbName);
    db.put(data.id, data);
    await getStudents();
    notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    final db = await Hive.openBox<StudentModel>(dbName);
    await db.delete(id);
    await getStudents();
  }

  Future<List<StudentModel>> getAllData() async {
    final db = await Hive.openBox<StudentModel>(dbName);
    return db.values.toList();
  }

  Future<void> getStudents() async {
    allStudentList.clear();
    final allStudents = await getAllData();
    Future.forEach(allStudents, (element) {
      allStudentList.add(element);
    });
    notifyListeners();
  }

  Future<void> searchStudent(String? name) async {
    allStudentList.clear();
    final allStudentsList = await getAllData();
    Future.forEach(allStudentsList, (element) {
      if (name != null) {
        if (element.name.toLowerCase().contains(name.toLowerCase())) {
          allStudentList.add(element);
        }
      }
    });
    notifyListeners();
  }

  String image = '';

  void clearImage() {
    image = '';
    notifyListeners();
  }

  Future<void> pickImage() async {
    final imgFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = imgFile!.path;
    notifyListeners();
  }

  void updateImage(String imageFile) {
    image = imageFile;
    notifyListeners();
  }
}
