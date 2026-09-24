import 'package:flutter/material.dart';
import 'package:may/screens/create_appointment.dart';

class SearchLecturerScreen extends StatefulWidget {
  const SearchLecturerScreen({super.key});

  @override
  State<SearchLecturerScreen> createState() => _SearchLecturerScreenState();
}

class _SearchLecturerScreenState extends State<SearchLecturerScreen> {
  String _searchQuery = '';
  String _selectedFaculty = 'ทั้งหมด';

  final List<String> _faculties = [
    'ทั้งหมด',
    'เทคโนโลยีสารสนเทศ',
    'วิทยาการจัดการ',
    'ครุศาสตร์',
    'มนุษยศาสตร์และสังคมศาสตร์',
    'วิทยาศาสตร์และเทคโนโลยี',
    'เทคโนโลยีการเกษตร',
    'พยาบาลศาสตร์และวิทยาศาสตร์สุขภาพ',
    'วิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม',
  ];

  final List<Map<String, String>> _lecturers = [
    {
      'name': 'อ.ดร.สมศักดิ์ วิชาการ',
      'faculty': 'เทคโนโลยีสารสนเทศ',
      'room': 'อาคาร 15 ชั้น 4 ห้อง 402',
      'available': 'จันทร์, พุธ (10:00 - 12:00 น.)',
    },
    {
      'name': 'ผศ.ประเสริฐ รู้จริง',
      'faculty': 'เทคโนโลยีสารสนเทศ',
      'room': 'อาคาร 15 ชั้น 3 ห้อง 308',
      'available': 'จันทร์, พฤหัสบดี (14:00 - 16:00 น.)',
    },
    {
      'name': 'ผศ.ดร.วิภาดา สอนดี',
      'faculty': 'วิทยาการจัดการ',
      'room': 'อาคาร 3 ชั้น 2 ห้อง 205',
      'available': 'อังคาร, พฤหัสบดี (13:00 - 15:30 น.)',
    },
    {
      'name': 'อ.กิตติศักดิ์ มั่นคง',
      'faculty': 'ครุศาสตร์',
      'room': 'อาคาร 1 ชั้น 3 ห้อง 301',
      'available': 'พุธ, ศุกร์ (09:00 - 11:30 น.)',
    },
    {
      'name': 'ดร.อนันต์ มนุษยศิลป์',
      'faculty': 'มนุษยศาสตร์และสังคมศาสตร์',
      'room': 'อาคาร 7 ชั้น 2 ห้อง 201',
      'available': 'จันทร์, อังคาร (10:30 - 12:00 น.)',
    },
    {
      'name': 'ผศ.ดร.สมชาย วิทยา',
      'faculty': 'วิทยาศาสตร์และเทคโนโลยี',
      'room': 'อาคาร 10 ชั้น 4 ห้อง 405',
      'available': 'พุธ, พฤหัสบดี (13:00 - 15:00 น.)',
    },
    {
      'name': 'อ.ดร.เกษตร เกษตรกรรม',
      'faculty': 'เทคโนโลยีการเกษตร',
      'room': 'อาคารเกษตรศาสตร์ ชั้น 1',
      'available': 'จันทร์, ศุกร์ (09:30 - 11:30 น.)',
    },
    {
      'name': 'ผศ.พยาบาล นุ่มนวล',
      'faculty': 'พยาบาลศาสตร์และวิทยาศาสตร์สุขภาพ',
      'room': 'อาคารพยาบาลศาสตร์ ชั้น 3',
      'available': 'อังคาร, พุธ (14:00 - 16:00 น.)',
    },
    {
      'name': 'อ.ช่างกล ช่างคิด',
      'faculty': 'วิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม',
      'room': 'อาคารปฏิบัติการวิศวกรรม ชั้น 2',
      'available': 'พฤหัสบดี, ศุกร์ (10:00 - 12:00 น.)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    final filteredList = _lecturers.where((lec) {
      final matchesQuery = lec['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          lec['faculty']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFaculty = _selectedFaculty == 'ทั้งหมด' || lec['faculty'] == _selectedFaculty;
      return matchesQuery && matchesFaculty;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'ค้นหาอาจารย์ / บุคลากร',
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
        child: Column(
          children: [
            // Search Input & Faculty Filter Chips
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'ค้นหาด้วยชื่ออาจารย์ หรือ คณะ...',
                      prefixIcon: const Icon(Icons.search_rounded, color: primaryColor),
                      filled: true,
                      fillColor: const Color(0xFFF7FAFC),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'กรองตามคณะสังกัด:',
                    style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Color(0xFF718096)),
                  ),
                  const SizedBox(height: 6.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _faculties.map((fac) {
                        final isSelected = _selectedFaculty == fac;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(fac),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedFaculty = fac;
                              });
                            },
                            selectedColor: primaryColor.withOpacity(0.15),
                            checkmarkColor: primaryColor,
                            labelStyle: TextStyle(
                              color: isSelected ? primaryColor : const Color(0xFF4A5568),
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            backgroundColor: const Color(0xFFEDF2F7),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Lecturer Cards List
            Expanded(
              child: filteredList.isEmpty
                  ? const Center(
                      child: Text('ไม่พบข้อมูลอาจารย์ที่ค้นหา', style: TextStyle(color: Color(0xFF718096), fontSize: 16)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20.0),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final lec = filteredList[index];
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
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: primaryColor.withOpacity(0.12),
                                child: const Icon(Icons.person_rounded, color: primaryColor, size: 32),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lec['name']!,
                                      style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'คณะ${lec['faculty']!}',
                                      style: const TextStyle(fontSize: 13.0, color: primaryColor, fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 6),
                                    Text('📍 ${lec['room']!}', style: const TextStyle(fontSize: 12.5, color: Color(0xFF718096))),
                                    Text('🕒 ${lec['available']!}', style: const TextStyle(fontSize: 12.5, color: Color(0xFF718096))),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const CreateAppointmentScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                ),
                                child: const Text('นัดพบ', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
