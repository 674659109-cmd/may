import 'package:flutter/material.dart';

class CampusMapScreen extends StatefulWidget {
  const CampusMapScreen({super.key});

  @override
  State<CampusMapScreen> createState() => _CampusMapScreenState();
}

class _CampusMapScreenState extends State<CampusMapScreen> {
  int _selectedFloor = 3;

  final Map<int, List<Map<String, String>>> _floorRooms = {
    1: [
      {'room': 'ห้อง 101', 'name': 'ห้องปฏิบัติการหุ่นยนต์และระบบอัตโนมัติ'},
      {'room': 'ห้อง 102', 'name': 'ห้องปฏิบัติการวิศวกรรมโยธา'},
      {'room': 'ห้อง 105', 'name': 'โรงช่างปฏิบัติการวิศวกรรมเครื่องกล'},
    ],
    2: [
      {'room': 'ห้อง 201', 'name': 'ห้องปฏิบัติการวิศวกรรมไฟฟ้าและวงจร'},
      {'room': 'ห้อง 205', 'name': 'ห้องปฏิบัติการวิศวกรรมพลังงาน'},
      {'room': 'ห้อง 208', 'name': 'ห้องปฏิบัติการวิศวกรรมอุตสาหการ'},
    ],
    3: [
      {'room': 'ห้อง 302', 'name': 'ห้องแล็บวิศวกรรมสารสนเทศและการสื่อสาร (AI Lab)'},
      {'room': 'ห้อง 305', 'name': 'ห้องปฏิบัติการคอมพิวเตอร์กราฟิกส์'},
      {'room': 'ห้อง 308', 'name': 'สำนักงานคณบดีคณะวิศวกรรมศาสตร์ฯ'},
    ],
    4: [
      {'room': 'ห้อง 401', 'name': 'ห้องปฏิบัติการสถาปัตยกรรมภายใน'},
      {'room': 'ห้อง 405', 'name': 'ห้องเรียนบรรยายวิศวกรรม 1'},
      {'room': 'ห้อง 408', 'name': 'ห้องเรียนบรรยายวิศวกรรม 2'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);
    final rooms = _floorRooms[_selectedFloor] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'แผนที่อาคารคณะวิศวกรรมศาสตร์ฯ',
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
              // Floor Selector Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [1, 2, 3, 4].map((floor) {
                  final isSelected = _selectedFloor == floor;
                  return ChoiceChip(
                    label: Text('ชั้น $floor'),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedFloor = floor);
                    },
                    selectedColor: primaryColor,
                    labelStyle: TextStyle(color: isSelected ? Colors.white : const Color(0xFF2D3748), fontWeight: FontWeight.bold),
                    backgroundColor: Colors.white,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20.0),

              // Visual Building Map Floor Card
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('แผนผังอาคาร 15 (ชั้น $_selectedFloor)', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C))),
                        const Icon(Icons.map_rounded, color: primaryColor),
                      ],
                    ),
                    const Divider(height: 24),
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF2F7),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(color: const Color(0xFFCBD5E0)),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.apartment_rounded, color: primaryColor, size: 48),
                            const SizedBox(height: 8),
                            Text('ผังห้องประจำชั้น $_selectedFloor อาคารวิศวกรรมศาสตร์', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4A5568))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              // Room Directory List
              Text('รายชื่อห้องประจำชั้น $_selectedFloor', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C))),
              const SizedBox(height: 12.0),

              ...rooms.map((r) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: primaryColor.withOpacity(0.12),
                        child: const Icon(Icons.meeting_room_outlined, color: primaryColor, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r['room']!, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C))),
                            const SizedBox(height: 2),
                            Text(r['name']!, style: const TextStyle(fontSize: 13.0, color: Color(0xFF718096))),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
