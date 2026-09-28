import 'package:flutter/material.dart';
import 'package:may/screens/create_appointment.dart';
import 'package:may/screens/lecturer_detail.dart';

class SearchLecturerScreen extends StatefulWidget {
  const SearchLecturerScreen({super.key});

  @override
  State<SearchLecturerScreen> createState() => _SearchLecturerScreenState();
}

class _SearchLecturerScreenState extends State<SearchLecturerScreen> {
  String _searchQuery = '';
  String _selectedMajor = 'ทั้งหมด';

  final List<String> _engineeringMajors = [
    'ทั้งหมด',
    'วิศวกรรมไฟฟ้า',
    'วิศวกรรมพลังงาน',
    'วิศวกรรมเครื่องกล',
    'วิศวกรรมอุตสาหการ',
    'สาขาสถาปัตยกรรมภายใน',
    'วิศวกรรมสารสนเทศและการสื่อสาร',
  ];

  final List<Map<String, String>> _lecturers = [
    // สาขาวิชาวิศวกรรมไฟฟ้า
    {
      'name': 'ผศ.อนุรักษ์ เกษวัฒนากุล',
      'major': 'วิศวกรรมไฟฟ้า',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 2 ห้อง 201',
      'available': 'จันทร์, พุธ (10:00 - 12:00 น.)',
    },
    {
      'name': 'อ.บุรีรักษ์ สังข์คงเมือง',
      'major': 'วิศวกรรมไฟฟ้า',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 2 ห้อง 202',
      'available': 'อังคาร, พฤหัสบดี (13:00 - 15:00 น.)',
    },
    {
      'name': 'อ.กมลวรรณ วงศ์วุฒิ',
      'major': 'วิศวกรรมไฟฟ้า',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 2 ห้อง 203',
      'available': 'พุธ, ศุกร์ (09:30 - 11:30 น.)',
    },
    {
      'name': 'ผศ.ดร.ราเชณ คณะนา',
      'major': 'วิศวกรรมไฟฟ้า',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 2 ห้อง 204',
      'available': 'จันทร์, พฤหัสบดี (14:00 - 16:00 น.)',
    },
    {
      'name': 'ผศ.ดร.วิโรจน์ จงชนะชววัฒน์',
      'major': 'วิศวกรรมไฟฟ้า',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 2 ห้อง 205',
      'available': 'อังคาร, ศุกร์ (10:00 - 12:00 น.)',
    },

    // สาขาวิชาวิศวกรรมพลังงาน
    {
      'name': 'อ.เจิมธง ปรารถนารักษ์ (ประธานหลักสูตร)',
      'major': 'วิศวกรรมพลังงาน',
      'room': 'อาคารศูนย์วิจัยพลังงาน ชั้น 1 ห้อง 101',
      'available': 'จันทร์, พุธ (09:00 - 11:30 น.)',
    },
    {
      'name': 'ผศ.ดร.กังสดาล สกุลพงษ์มาลี',
      'major': 'วิศวกรรมพลังงาน',
      'room': 'อาคารศูนย์วิจัยพลังงาน ชั้น 1 ห้อง 102',
      'available': 'อังคาร, พฤหัสบดี (10:00 - 12:00 น.)',
    },
    {
      'name': 'อ.ดร.จุติพร อินทะนิน',
      'major': 'วิศวกรรมพลังงาน',
      'room': 'อาคารศูนย์วิจัยพลังงาน ชั้น 2 ห้อง 201',
      'available': 'พุธ, ศุกร์ (13:30 - 15:30 น.)',
    },
    {
      'name': 'อ.ชลีดล อินยาศรี',
      'major': 'วิศวกรรมพลังงาน',
      'room': 'อาคารศูนย์วิจัยพลังงาน ชั้น 2 ห้อง 202',
      'available': 'จันทร์, พฤหัสบดี (13:00 - 15:00 น.)',
    },
    {
      'name': 'อ.ปองพล รักการงาน',
      'major': 'วิศวกรรมพลังงาน',
      'room': 'อาคารศูนย์วิจัยพลังงาน ชั้น 2 ห้อง 203',
      'available': 'อังคาร, ศุกร์ (14:00 - 16:00 น.)',
    },

    // สาขาวิชาวิศวกรรมเครื่องกล
    {
      'name': 'ผศ.ดร.ช่วงชัย ชุปวา (ประธานสาขาวิชา)',
      'major': 'วิศวกรรมเครื่องกล',
      'room': 'อาคารโรงช่างเครื่องกล ชั้น 1 ห้อง 101',
      'available': 'จันทร์, พุธ (10:00 - 12:00 น.)',
    },
    {
      'name': 'ผศ.ดร.อนุชา สายสร้อย',
      'major': 'วิศวกรรมเครื่องกล',
      'room': 'อาคารโรงช่างเครื่องกล ชั้น 1 ห้อง 102',
      'available': 'อังคาร, พฤหัสบดี (13:30 - 15:30 น.)',
    },
    {
      'name': 'ผศ.ดร.ขวัญชัย หนาแน่น',
      'major': 'วิศวกรรมเครื่องกล',
      'room': 'อาคารโรงช่างเครื่องกล ชั้น 2 ห้อง 201',
      'available': 'พุธ, ศุกร์ (09:00 - 11:30 น.)',
    },
    {
      'name': 'ผศ.ดร.พิเชฐ นิลดวงดี',
      'major': 'วิศวกรรมเครื่องกล',
      'room': 'อาคารโรงช่างเครื่องกล ชั้น 2 ห้อง 202',
      'available': 'จันทร์, พฤหัสบดี (14:00 - 16:00 น.)',
    },
    {
      'name': 'ผศ.ดร.ปรัชญา มุขดา',
      'major': 'วิศวกรรมเครื่องกล',
      'room': 'อาคารโรงช่างเครื่องกล ชั้น 2 ห้อง 203',
      'available': 'อังคาร, ศุกร์ (10:00 - 12:00 น.)',
    },
    {
      'name': 'รศ.ดร.อุทัย ผ่องรัศมี (ประธานสาขาฯ ป.โท)',
      'major': 'วิศวกรรมเครื่องกล',
      'room': 'อาคารโรงช่างเครื่องกล ชั้น 3 ห้อง 301',
      'available': 'จันทร์, พุธ (13:00 - 15:00 น.)',
    },
    {
      'name': 'อ.ชยุต พลอยจิรภาส',
      'major': 'วิศวกรรมเครื่องกล',
      'room': 'อาคารโรงช่างเครื่องกล ชั้น 3 ห้อง 302',
      'available': 'อังคาร, พฤหัสบดี (09:30 - 11:30 น.)',
    },
    {
      'name': 'อ.ดวงฤดี ชูตระกูล',
      'major': 'วิศวกรรมเครื่องกล',
      'room': 'อาคารโรงช่างเครื่องกล ชั้น 3 ห้อง 303',
      'available': 'พุธ, ศุกร์ (14:00 - 16:00 น.)',
    },

    // สาขาวิชาวิศวกรรมอุตสาหการ
    {
      'name': 'อ.ประเสริฐ ปราชญ์ประยูร (ประธานสาขาวิชา)',
      'major': 'วิศวกรรมอุตสาหการ',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 2 ห้อง 208',
      'available': 'จันทร์, พุธ (10:00 - 12:00 น.)',
    },
    {
      'name': 'อ.อลงกรณ์ ฉัตรเมืองปัก',
      'major': 'วิศวกรรมอุตสาหการ',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 2 ห้อง 209',
      'available': 'อังคาร, พฤหัสบดี (13:30 - 15:30 น.)',
    },
    {
      'name': 'อ.ชลาลัย วงเวียน',
      'major': 'วิศวกรรมอุตสาหการ',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 2 ห้อง 210',
      'available': 'พุธ, ศุกร์ (09:30 - 11:30 น.)',
    },

    // สาขาสถาปัตยกรรมภายใน
    {
      'name': 'ผศ.วิเชียร เข็มเงิน (ประธานสาขาวิชา)',
      'major': 'สาขาสถาปัตยกรรมภายใน',
      'room': 'อาคารปฏิบัติการสถาปัตย์ ชั้น 1 ห้อง 101',
      'available': 'จันทร์, พุธ (13:00 - 15:30 น.)',
    },
    {
      'name': 'อ.เฉลิมศักดิ์ แก้วเกาะ',
      'major': 'สาขาสถาปัตยกรรมภายใน',
      'room': 'อาคารปฏิบัติการสถาปัตย์ ชั้น 1 ห้อง 102',
      'available': 'อังคาร, พฤหัสบดี (09:30 - 11:30 น.)',
    },
    {
      'name': 'อ.จิตราพร ชัยเสริมวงศ์',
      'major': 'สาขาสถาปัตยกรรมภายใน',
      'room': 'อาคารปฏิบัติการสถาปัตย์ ชั้น 1 ห้อง 103',
      'available': 'พุธ, ศุกร์ (10:00 - 12:00 น.)',
    },
    {
      'name': 'อ.จิตรา มีทองคำ',
      'major': 'สาขาสถาปัตยกรรมภายใน',
      'room': 'อาคารปฏิบัติการสถาปัตย์ ชั้น 1 ห้อง 104',
      'available': 'จันทร์, พฤหัสบดี (14:00 - 16:00 น.)',
    },
    {
      'name': 'อ.ภัทรวรรณ เอมกมล',
      'major': 'สาขาสถาปัตยกรรมภายใน',
      'room': 'อาคารปฏิบัติการสถาปัตย์ ชั้น 1 ห้อง 105',
      'available': 'อังคาร, ศุกร์ (13:00 - 15:00 น.)',
    },
    {
      'name': 'อ.จตุพล อังศุเวช',
      'major': 'สาขาสถาปัตยกรรมภายใน',
      'room': 'อาคารปฏิบัติการสถาปัตย์ ชั้น 1 ห้อง 106',
      'available': 'พุธ, พฤหัสบดี (10:00 - 12:00 น.)',
    },

    // สาขาวิชาวิศวกรรมสารสนเทศและการสื่อสาร
    {
      'name': 'ผศ.กฤษณ์ ไชยวงศ์ (ประธานสาขาวิชา)',
      'major': 'วิศวกรรมสารสนเทศและการสื่อสาร',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 301',
      'available': 'จันทร์, พุธ (10:00 - 12:00 น.)',
    },
    {
      'name': 'ผศ.ดร.ปาณิศา แก้วสวัสดิ์',
      'major': 'วิศวกรรมสารสนเทศและการสื่อสาร',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 302',
      'available': 'อังคาร, พฤหัสบดี (13:30 - 15:30 น.)',
    },
    {
      'name': 'อ.ดร.กิตติพงศ์ นวลใย',
      'major': 'วิศวกรรมสารสนเทศและการสื่อสาร',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 303',
      'available': 'พุธ, ศุกร์ (09:00 - 11:30 น.)',
    },
    {
      'name': 'อ.ดร.ดวงกมล อังอำนวยศิริ',
      'major': 'วิศวกรรมสารสนเทศและการสื่อสาร',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 304',
      'available': 'จันทร์, พฤหัสบดี (14:00 - 16:00 น.)',
    },
    {
      'name': 'อ.ดร.ประกิจ อินทะชัย',
      'major': 'วิศวกรรมสารสนเทศและการสื่อสาร',
      'room': 'อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 305',
      'available': 'อังคาร, ศุกร์ (10:00 - 12:00 น.)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    final filteredList = _lecturers.where((lec) {
      final matchesQuery = lec['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          lec['major']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesMajor = _selectedMajor == 'ทั้งหมด' || lec['major'] == _selectedMajor;
      return matchesQuery && matchesMajor;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'รายชื่อคณาจารย์ PBRU',
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
            // Search Input & Major Filter Chips
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
                      hintText: 'ค้นหาด้วยชื่ออาจารย์ หรือ สาขาวิชา...',
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
                    'กรองตามสาขาวิชา:',
                    style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Color(0xFF718096)),
                  ),
                  const SizedBox(height: 6.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _engineeringMajors.map((major) {
                        final isSelected = _selectedMajor == major;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(major),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedMajor = major;
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LecturerDetailScreen(lecturer: lec)),
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
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: primaryColor.withOpacity(0.12),
                                  child: const Icon(Icons.engineering_rounded, color: primaryColor, size: 30),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lec['name']!,
                                        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        lec['major']!,
                                        style: const TextStyle(fontSize: 12.5, color: primaryColor, fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 6),
                                      Text('📍 ${lec['room']!}', style: const TextStyle(fontSize: 12.0, color: Color(0xFF718096))),
                                      Text('🕒 ${lec['available']!}', style: const TextStyle(fontSize: 12.0, color: Color(0xFF718096))),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CreateAppointmentScreen(
                                          initialMajor: lec['major'],
                                          initialLecturer: lec['name'],
                                        ),
                                      ),
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
