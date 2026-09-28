import 'package:flutter/material.dart';
import 'package:may/screens/appointment_detail.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'ประวัตินัดหมาย',
          style: TextStyle(color: Color(0xFF1A202C), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2D3748)),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryColor,
          unselectedLabelColor: const Color(0xFF718096),
          indicatorColor: primaryColor,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          tabs: const [
            Tab(text: 'เสร็จสิ้นแล้ว (2)'),
            Tab(text: 'ยกเลิกแล้ว (1)'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildHistoryList(isCompleted: true),
            _buildHistoryList(isCompleted: false),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList({required bool isCompleted}) {
    final List<Map<String, dynamic>> completedList = [
      {
        'title': 'นัดสอบสัมภาษณ์ภาคนิพนธ์',
        'person': 'ผศ.ดร.วิศวกรรม นวัตกรรม',
        'major': 'วิศวกรรมสารสนเทศและการสื่อสาร',
        'location': 'อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 302',
        'date': '15 พ.ค. 2024',
        'time': '10:00 - 11:30 น.',
        'topic': 'รายงานความก้าวหน้าโครงการภาคนิพนธ์ระยะที่ 1',
        'status': 'COMPLETED',
        'statusText': 'เสร็จสิ้นแล้ว',
        'statusColor': const Color(0xFF38A169),
        'statusBg': const Color(0xFFC6F6D5),
      },
      {
        'title': 'นัดปรึกษาการใช้ห้องแล็บหุ่นยนต์',
        'person': 'ดร.หุ่นยนต์ ออโตเมชัน',
        'major': 'วิศวกรรมหุ่นยนต์และระบบอัตโนมัติ',
        'location': 'อาคารปฏิบัติการหุ่นยนต์ ชั้น 1',
        'date': '10 พ.ค. 2024',
        'time': '13:00 - 14:30 น.',
        'topic': 'ขออนุญาตเข้าใช้ชุดทดลองแขนกลหุ่นยนต์',
        'status': 'COMPLETED',
        'statusText': 'เสร็จสิ้นแล้ว',
        'statusColor': const Color(0xFF38A169),
        'statusBg': const Color(0xFFC6F6D5),
      },
    ];

    final List<Map<String, dynamic>> cancelledList = [
      {
        'title': 'นัดปรึกษารายวิชาคณิตศาสตร์วิศวกรรม',
        'person': 'ผศ.ไฟฟ้า กำลังแรง',
        'major': 'วิศวกรรมไฟฟ้า',
        'location': 'อาคารวิศวกรรมศาสตร์ ชั้น 2 ห้อง 201',
        'date': '02 พ.ค. 2024',
        'time': '11:00 - 12:00 น.',
        'topic': 'ขอสอบถามเนื้อหาการแคลคูลัสสำหรับวิศวกรรม',
        'status': 'CANCELLED',
        'statusText': 'ยกเลิกแล้ว',
        'statusColor': const Color(0xFFE53E3E),
        'statusBg': const Color(0xFFFED7D7),
      },
    ];

    final list = isCompleted ? completedList : cancelledList;

    if (list.isEmpty) {
      return const Center(
        child: Text('ไม่มีประวัตินัดหมายในหมวดนี้', style: TextStyle(color: Color(0xFF718096), fontSize: 16)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20.0),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppointmentDetailScreen(appointment: item)),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.0),
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
                        item['title'],
                        style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: item['statusBg'],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        item['statusText'],
                        style: TextStyle(color: item['statusColor'], fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text('👤 ${item['person']}', style: const TextStyle(fontSize: 14.0, color: Color(0xFF4A5568))),
                const Divider(height: 20, thickness: 0.8),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 18, color: Color(0xFF4C52D4)),
                    const SizedBox(width: 6),
                    Text('${item['date']} • ${item['time']}', style: const TextStyle(fontSize: 13.5, color: Color(0xFF4A5568))),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
