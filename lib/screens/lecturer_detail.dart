import 'package:flutter/material.dart';
import 'package:may/screens/create_appointment.dart';

class LecturerDetailScreen extends StatelessWidget {
  final Map<String, String> lecturer;

  const LecturerDetailScreen({super.key, required this.lecturer});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'ข้อมูลอาจารย์',
          style: TextStyle(color: Color(0xFF1A202C), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2D3748)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 46,
                      backgroundColor: primaryColor.withOpacity(0.12),
                      child: const Icon(Icons.engineering_rounded, color: primaryColor, size: 52),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      lecturer['name'] ?? 'ผศ.ดร.วิศวกรรม นวัตกรรม',
                      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lecturer['major'] ?? 'สาขาวิชาวิศวกรรมสารสนเทศและการสื่อสาร',
                      style: const TextStyle(fontSize: 14.0, color: primaryColor, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม มรภ.เพชรบุรี',
                      style: TextStyle(fontSize: 13.0, color: Color(0xFF718096)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // Office Info & Hours Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInfoRow(
                      icon: Icons.location_on_outlined,
                      title: 'ห้องทำงานประจำ',
                      value: lecturer['room'] ?? 'อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 302',
                    ),
                    const Divider(height: 24, thickness: 0.8),
                    _buildInfoRow(
                      icon: Icons.access_time_rounded,
                      title: 'ช่วงเวลาที่เปิดให้เข้าพบ (Office Hours)',
                      value: lecturer['available'] ?? 'จันทร์, พุธ (10:00 - 12:00 น.)',
                    ),
                    const Divider(height: 24, thickness: 0.8),
                    _buildInfoRow(
                      icon: Icons.email_outlined,
                      title: 'อีเมลติดต่อ',
                      value: 'engineering@pbru.ac.th',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28.0),

              // Create Appointment Button
              SizedBox(
                width: double.infinity,
                height: 52.0,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAppointmentScreen(
                          initialMajor: lecturer['major'],
                          initialLecturer: lecturer['name'],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.calendar_month_rounded),
                  label: const Text('ส่งคำขอนัดพบอาจารย์ท่านนี้', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String title, required String value}) {
    const primaryColor = Color(0xFF4C52D4);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: primaryColor, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 13.0, color: Color(0xFF718096))),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
            ],
          ),
        ),
      ],
    );
  }
}
