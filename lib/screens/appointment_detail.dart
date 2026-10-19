import 'package:flutter/material.dart';
import 'package:may/screens/campus_map.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final Map<String, dynamic> appointment;

  const AppointmentDetailScreen({super.key, required this.appointment});

  int _extractBuildingId(String location) {
    if (location.contains('33')) return 33;
    if (location.contains('32')) return 32;
    if (location.contains('31')) return 31;
    if (location.contains('30')) return 30;
    if (location.contains('29')) return 29;
    if (location.contains('28')) return 28;
    if (location.contains('27')) return 27;
    if (location.contains('26')) return 26;
    if (location.contains('25')) return 25;
    if (location.contains('24')) return 24;
    if (location.contains('23')) return 23;
    if (location.contains('22')) return 22;
    if (location.contains('21')) return 21;
    if (location.contains('20')) return 20;
    if (location.contains('19')) return 19;
    if (location.contains('18')) return 18;
    if (location.contains('17')) return 17;
    if (location.contains('16') || location.contains('วิศวกรรม')) return 16;
    if (location.contains('15')) return 15;
    if (location.contains('14')) return 14;
    if (location.contains('13')) return 13;
    if (location.contains('12')) return 12;
    if (location.contains('11')) return 11;
    if (location.contains('10')) return 10;
    if (location.contains('9')) return 9;
    if (location.contains('8')) return 8;
    if (location.contains('7')) return 7;
    if (location.contains('6')) return 6;
    if (location.contains('5')) return 5;
    if (location.contains('4')) return 4;
    if (location.contains('3')) return 3;
    if (location.contains('2')) return 2;
    if (location.contains('1')) return 1;
    return 16; // Default to building 16
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'รายละเอียดนัดหมาย',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status & Main Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            appointment['title'] ?? 'รายละเอียดการนัดหมาย',
                            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: appointment['statusBg'] ?? const Color(0xFFC6F6D5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            appointment['statusText'] ?? 'ยืนยันแล้ว',
                            style: TextStyle(
                              color: appointment['statusColor'] ?? const Color(0xFF38A169),
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.engineering_rounded, color: primaryColor, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          appointment['person'] ?? 'ผศ.ดร.วิศวกรรม นวัตกรรม',
                          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'สาขาวิชา${appointment['major'] ?? 'วิศวกรรมสารสนเทศและการสื่อสาร'}',
                      style: const TextStyle(fontSize: 13.5, color: primaryColor, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // Status Timeline
              const Text(
                'สถานะการดำเนินงาน',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
              ),
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildTimelineStep(
                      title: 'ยื่นคำขอนัดหมาย',
                      subtitle: '23 พ.ค. 2024 • 14:20 น.',
                      isCompleted: true,
                      isLast: false,
                    ),
                    _buildTimelineStep(
                      title: 'อาจารย์ตอบรับการนัดหมาย',
                      subtitle: '23 พ.ค. 2024 • 15:05 น.',
                      isCompleted: appointment['status'] == 'CONFIRMED',
                      isLast: false,
                    ),
                    _buildTimelineStep(
                      title: 'เข้าพบตามนัดหมาย',
                      subtitle: 'รอถึงเวลานัดหมาย',
                      isCompleted: false,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // Date, Time & Location Details
              const Text(
                'ข้อมูลเวลาและสถานที่',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
              ),
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      icon: Icons.calendar_today_rounded,
                      title: 'วันและเวลานัดพบ',
                      value: '${appointment['date'] ?? '24 พ.ค. 2024'} • ${appointment['time'] ?? '10:30 - 11:30 น.'}',
                    ),
                    const Divider(height: 24, thickness: 0.8),
                    _buildDetailRow(
                      icon: Icons.location_on_rounded,
                      title: 'สถานที่นัดพบ',
                      value: appointment['location'] ?? 'อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 302',
                    ),
                    const Divider(height: 24, thickness: 0.8),
                    _buildDetailRow(
                      icon: Icons.notes_rounded,
                      title: 'วัตถุประสงค์การนัดหมาย',
                      value: appointment['topic'] ?? 'ขอคำปรึกษาเกี่ยวกับหัวข้อโปรเจกต์ภาคเรียนปัจจุบัน',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28.0),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ส่งคำขอยกเลิกนัดหมายเรียบร้อยแล้ว')),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.cancel_outlined, color: Colors.red),
                      label: const Text('ยกเลิกนัด', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFFFEB2B2)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final locationStr = appointment['location'] ?? '';
                        final buildingId = _extractBuildingId(locationStr);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CampusMapScreen(initialBuildingId: buildingId),
                          ),
                        );
                      },
                      icon: const Icon(Icons.navigation_rounded),
                      label: const Text('นำทางไปห้อง', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool isLast,
  }) {
    const primaryColor = Color(0xFF4C52D4);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: isCompleted ? primaryColor : const Color(0xFFE2E8F0),
              child: isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : const CircleAvatar(radius: 4, backgroundColor: Color(0xFFA0AEC0)),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 36,
                color: isCompleted ? primaryColor : const Color(0xFFE2E8F0),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? const Color(0xFF1A202C) : const Color(0xFFA0AEC0),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 13.0, color: Color(0xFF718096)),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow({required IconData icon, required String title, required String value}) {
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
              Text(
                value,
                style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
