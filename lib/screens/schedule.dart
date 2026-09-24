import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          'ตารางนัดหมายทั้งหมด',
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
            Tab(text: 'ทั้งหมด (3)'),
            Tab(text: 'ยืนยันแล้ว (2)'),
            Tab(text: 'รอดำเนินการ (1)'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildAppointmentListView(filterStatus: 'ALL'),
            _buildAppointmentListView(filterStatus: 'CONFIRMED'),
            _buildAppointmentListView(filterStatus: 'PENDING'),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentListView({required String filterStatus}) {
    final List<Map<String, dynamic>> appointments = [
      {
        'title': 'นัดพบอาจารย์ที่ปรึกษา',
        'person': 'อ.ดร.สมศักดิ์ วิชาการ',
        'location': 'อาคาร 15 ชั้น 4 ห้อง 402',
        'date': '24 พ.ค. 2567',
        'time': '10:30 - 11:30 น.',
        'status': 'CONFIRMED',
        'statusText': 'ยืนยันแล้ว',
        'statusColor': const Color(0xFF38A169),
        'statusBg': const Color(0xFFC6F6D5),
      },
      {
        'title': 'นัดสอบสัมภาษณ์ทุนการศึกษา',
        'person': 'สำนักงานกิจการนักศึกษา',
        'location': 'อาคารกิจกรรมนักศึกษา ชั้น 2',
        'date': '26 พ.ค. 2567',
        'time': '09:00 - 10:00 น.',
        'status': 'CONFIRMED',
        'statusText': 'ยืนยันแล้ว',
        'statusColor': const Color(0xFF38A169),
        'statusBg': const Color(0xFFC6F6D5),
      },
      {
        'title': 'นัดติวกลุ่มวิชา Mobile App Development',
        'person': 'กลุ่มเพื่อนเซกชัน 1',
        'location': 'อาคารโดมเรียนรู้ (Learning Center)',
        'date': '28 พ.ค. 2567',
        'time': '13:30 - 15:00 น.',
        'status': 'PENDING',
        'statusText': 'รอดำเนินการ',
        'statusColor': const Color(0xFFDD6B20),
        'statusBg': const Color(0xFFFEEBC8),
      },
    ];

    final filtered = filterStatus == 'ALL'
        ? appointments
        : appointments.where((item) => item['status'] == filterStatus).toList();

    if (filtered.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined, size: 60, color: Color(0xFFCBD5E0)),
            SizedBox(height: 12),
            Text('ไม่มีรายการนัดหมายในหมวดนี้', style: TextStyle(color: Color(0xFF718096), fontSize: 16)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20.0),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        return Container(
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
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A202C),
                      ),
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
                      style: TextStyle(
                        color: item['statusColor'],
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.person_outline_rounded, size: 18, color: Color(0xFF718096)),
                  const SizedBox(width: 6),
                  Text(
                    item['person'],
                    style: const TextStyle(fontSize: 14.0, color: Color(0xFF4A5568), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Divider(height: 20, thickness: 0.8),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 18, color: Color(0xFF4C52D4)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      item['location'],
                      style: const TextStyle(fontSize: 13.5, color: Color(0xFF4A5568)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.access_time_rounded, size: 18, color: Color(0xFF4C52D4)),
                  const SizedBox(width: 6),
                  Text(
                    '${item['date']} • ${item['time']}',
                    style: const TextStyle(fontSize: 13.5, color: Color(0xFF4A5568)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
