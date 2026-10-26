import 'package:flutter/material.dart';

class AppointmentItem {
  final String id;
  final String title;
  final String person;
  final String studentName;
  final String studentId;
  final String major;
  final String location;
  final String date;
  final String time;
  final String topic;
  String status; // 'PENDING', 'CONFIRMED', 'CANCELLED'

  AppointmentItem({
    required this.id,
    required this.title,
    required this.person,
    required this.studentName,
    required this.studentId,
    required this.major,
    required this.location,
    required this.date,
    required this.time,
    required this.topic,
    required this.status,
  });

  String get statusText {
    if (status == 'CONFIRMED') return 'ยืนยันแล้ว';
    if (status == 'CANCELLED') return 'ยกเลิกแล้ว';
    return 'รอดำเนินการ';
  }

  Color get statusColor {
    if (status == 'CONFIRMED') return const Color(0xFF38A169);
    if (status == 'CANCELLED') return const Color(0xFFE53E3E);
    return const Color(0xFFDD6B20);
  }

  Color get statusBg {
    if (status == 'CONFIRMED') return const Color(0xFFC6F6D5);
    if (status == 'CANCELLED') return const Color(0xFFFED7D7);
    return const Color(0xFFFEEBC8);
  }
}

class AppointmentData {
  static final List<AppointmentItem> appointments = [
    AppointmentItem(
      id: '1',
      title: 'นัดพบอาจารย์ที่ปรึกษา',
      person: 'ผศ.กฤษณ์ ไชยวงศ์ (ประธานสาขาวิชา)',
      studentName: 'นายสมชาย ใจดี',
      studentId: '674659109',
      major: 'วิศวกรรมสารสนเทศและการสื่อสาร',
      location: 'อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 301',
      date: 'วันนี้ (24 พ.ค. 2567)',
      time: '10:30 - 11:30 น.',
      topic: 'ขอปรึกษาเรื่องหัวข้อโครงงานวิจัยและวิศวกรรมซอฟต์แวร์',
      status: 'PENDING',
    ),
    AppointmentItem(
      id: '2',
      title: 'นัดปรึกษาเรื่องโปรเจกต์',
      person: 'ผศ.ดร.ปาณิศา แก้วสวัสดิ์',
      studentName: 'นายสมชาย ใจดี',
      studentId: '674659109',
      major: 'วิศวกรรมสารสนเทศและการสื่อสาร',
      location: 'อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 302',
      date: '26 พ.ค. 2567',
      time: '13:30 - 15:00 น.',
      topic: 'ปรึกษาการเขียนโปรแกรม Flutter และระบบเซิร์ฟเวอร์',
      status: 'CONFIRMED',
    ),
  ];

  static final List<VoidCallback> _listeners = [];

  static void addListener(VoidCallback listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  static void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  static void _notifyListeners() {
    for (var cb in _listeners) {
      cb();
    }
  }

  static List<Map<String, dynamic>> notifications = [
    {
      'title': 'คำขอนัดหมายได้รับการยืนยันแล้ว',
      'body': 'ผศ.ดร.ปาณิศา แก้วสวัสดิ์ ได้ตอบรับคำขอนัดพบของคุณ เรียบร้อยแล้ว',
      'time': '10 นาทีที่แล้ว',
      'isRead': false,
      'type': 'SUCCESS',
    },
  ];

  static void addAppointment(AppointmentItem item) {
    appointments.insert(0, item);
    _notifyListeners();
  }

  static void approveAppointment(String id) {
    for (var app in appointments) {
      if (app.id == id) {
        app.status = 'CONFIRMED';
        notifications.insert(0, {
          'title': 'คำขอนัดหมายได้รับการยืนยันแล้ว! 🎉',
          'body': '${app.person} ได้อนุมัติตอบรับคำขอนัดหมาย "${app.title}" เรียบร้อยแล้ว',
          'time': 'เมื่อสักครู่',
          'isRead': false,
          'type': 'SUCCESS',
        });
      }
    }
    _notifyListeners();
  }

  static void rejectAppointment(String id) {
    for (var app in appointments) {
      if (app.id == id) {
        app.status = 'CANCELLED';
        notifications.insert(0, {
          'title': 'มีการปฏิเสธ/เลื่อนนัดหมาย',
          'body': '${app.person} ได้ขอปฏิเสธหรือเลื่อนเวลานัดหมาย "${app.title}"',
          'time': 'เมื่อสักครู่',
          'isRead': false,
          'type': 'ALERT',
        });
      }
    }
    _notifyListeners();
  }
}
