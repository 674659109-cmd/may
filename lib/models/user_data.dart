import 'dart:typed_data';

class UserData {
  static bool hasAccount = true;
  static String name = 'นายสมชาย ใจดี';
  static String studentId = '674659109';
  static String email = '674659109@pbru.ac.th';
  static String password = 'password123';
  static String major = 'สาขาวิชาวิศวกรรมสารสนเทศและการสื่อสาร';
  static String faculty = 'คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม';
  static String? profileImagePath;
  static Uint8List? profileImageBytes;

  static void loadDemoStudent() {
    hasAccount = true;
    name = 'นายสมชาย ใจดี';
    studentId = '674659109';
    email = '674659109@pbru.ac.th';
    password = 'password123';
    major = 'สาขาวิชาวิศวกรรมสารสนเทศและการสื่อสาร';
    faculty = 'คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม';
  }
}
