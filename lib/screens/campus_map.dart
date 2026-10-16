import 'package:flutter/material.dart';

class CampusMapScreen extends StatefulWidget {
  const CampusMapScreen({super.key});

  @override
  State<CampusMapScreen> createState() => _CampusMapScreenState();
}

class _CampusMapScreenState extends State<CampusMapScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  int? _highlightedBuilding;
  Map<String, dynamic>? _selectedBuildingForNavigation;

  final List<Map<String, dynamic>> _buildings = [
    {
      'id': 1,
      'name': 'อาคารคณะมนุษยศาสตร์และสังคมศาสตร์ (หลังเก่า)',
      'isEng': false,
      'distance': '350 เมตร',
      'time': '4 นาที',
      'steps': [
        '1. จากประตูทางเข้าฝั่งถนนหาดเจ้าสำราญ มุ่งหน้าตรงเข้าสู่วงเวียนกลาง',
        '2. ตรงไปอีก 150 เมตร ผ่านอาคารนิวัตสโมสร (อาคาร 25)',
        '3. ถึงจุดหมายปลายทาง อาคาร 1 คณะมนุษยศาสตร์ฯ (หลังเก่า) ด้านหน้าสนาม',
      ],
    },
    {
      'id': 2,
      'name': 'อาคารปฏิบัติการโรงแรม (อยู่ระหว่างดำเนินการก่อสร้าง)',
      'isEng': false,
      'distance': '300 เมตร',
      'time': '3.5 นาที',
      'steps': [
        '1. จากประตูทางเข้า มุ่งหน้าตรงเข้ามายังถนนสายหลักในมหาวิทยาลัย',
        '2. เลี้ยวซ้ายก่อนถึงอาคาร 1 มุ่งหน้าเขตก่อสร้างอาคารปฏิบัติการโรงแรม',
        '3. ถึงจุดหมายปลายทาง อาคาร 2',
      ],
    },
    {
      'id': 3,
      'name': 'อาคารคณะเทคโนโลยีสารสนเทศ',
      'isEng': false,
      'distance': '280 เมตร',
      'time': '3 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางสี่แยกอาคารศูนย์คอมพิวเตอร์',
        '2. เลี้ยวขวาเข้าสู่โซนคณะเทคโนโลยีสารสนเทศ',
        '3. ถึงจุดหมายปลายทาง อาคาร 3 คณะเทคโนโลยีสารสนเทศ',
      ],
    },
    {
      'id': 4,
      'name': 'อาคารคณะวิทยาศาสตร์และเทคโนโลยี',
      'isEng': false,
      'distance': '200 เมตร',
      'time': '2.5 นาที',
      'steps': [
        '1. จากประตูทางเข้า เดินตรงเข้าสู่อาคารสำนักงานคณะวิทยาศาสตร์ฯ',
        '2. ถึงจุดหมายปลายทาง อาคาร 4 ทางด้านซ้ายมือ',
      ],
    },
    {
      'name': 'อาคารคณะเทคโนโลยีสารสนเทศ + คณะวิทยาศาสตร์และเทคโนโลยี',
      'id': 5,
      'isEng': false,
      'distance': '220 เมตร',
      'time': '2.5 นาที',
      'steps': [
        '1. จากประตูทางเข้า เดินตรงเข้าสู่อาคารทางเชื่อมคณะเทคโนโลยีสารสนเทศ',
        '2. ถึงจุดหมายปลายทาง อาคาร 5',
      ],
    },
    {
      'id': 7,
      'name': 'อาคารคณะวิทยาศาสตร์และเทคโนโลยี',
      'isEng': false,
      'distance': '250 เมตร',
      'time': '3 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปผ่านอาคาร 4 และอาคาร 5',
        '2. ถึงจุดหมายปลายทาง อาคาร 7',
      ],
    },
    {
      'id': 8,
      'name': 'อาคารคณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม (สาขาวิศวกรรมอุตสาหการและวิศวกรรมหุ่นยนต์ฯ)',
      'isEng': true,
      'distance': '380 เมตร',
      'time': '4.5 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางถนนสายหลักในมหาวิทยาลัย',
        '2. เลี้ยวขวาสี่แยกกลาง มุ่งหน้าโซนโรงช่างปฏิบัติการวิศวกรรม',
        '3. ถึงจุดหมายปลายทาง อาคาร 8 (โรงช่างปฏิบัติการวิศวกรรมหุ่นยนต์และอุตสาหการ)',
      ],
    },
    {
      'id': 9,
      'name': 'อาคารคณะครุศาสตร์',
      'isEng': false,
      'distance': '400 เมตร',
      'time': '5 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางลานกิจกรรมคณะครุศาสตร์',
        '2. ถึงจุดหมายปลายทาง อาคาร 9 คณะครุศาสตร์',
      ],
    },
    {
      'id': 10,
      'name': 'อาคารโรงแรมเพชรน้ำหนึ่ง',
      'isEng': false,
      'distance': '180 เมตร',
      'time': '2 นาที',
      'steps': [
        '1. จากประตูทางเข้า เลี้ยวซ้ายทันที เข้าสู่เขตร้านค้าและโรงแรมเพชรน้ำหนึ่ง',
        '2. ถึงจุดหมายปลายทาง อาคาร 10',
      ],
    },
    {
      'id': 11,
      'name': 'อาคารโรงเรียนสาธิตมหาวิทยาลัยราชภัฏเพชรบุรี',
      'isEng': false,
      'distance': '450 เมตร',
      'time': '5.5 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางฝั่งโซนโรงเรียนสาธิตฯ ด้านหลังมหาวิทยาลัย',
        '2. ถึงจุดหมายปลายทาง อาคาร 11',
      ],
    },
    {
      'id': 12,
      'name': 'อาคารสำนักวิทยบริการและเทคโนโลยีสารสนเทศ',
      'isEng': false,
      'distance': '260 เมตร',
      'time': '3 นาที',
      'steps': [
        '1. จากประตูทางเข้า เดินตรงเข้าสู่อาคารหอพรรณไม้และสำนักวิทยบริการ',
        '2. ถึงจุดหมายปลายทาง อาคาร 12 (หอสมุดกลาง)',
      ],
    },
    {
      'id': 13,
      'name': 'อาคารศูนย์วิทยาศาสตร์และวิทยาศาสตร์ประยุกต์',
      'isEng': false,
      'distance': '380 เมตร',
      'time': '4.5 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางศูนย์วิทยาศาสตร์และห้องปฏิบัติการรวม',
        '2. ถึงจุดหมายปลายทาง อาคาร 13',
      ],
    },
    {
      'id': 14,
      'name': 'อาคารวิทยภิรมย์',
      'isEng': false,
      'distance': '300 เมตร',
      'time': '3.5 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางสวนพฤกษศาสตร์อาคารวิทยภิรมย์',
        '2. ถึงจุดหมายปลายทาง อาคาร 14',
      ],
    },
    {
      'id': 16,
      'name': 'อาคารคณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม (อาคารหลัก)',
      'isEng': true,
      'distance': '290 เมตร',
      'time': '3.5 นาที',
      'steps': [
        '1. จากประตูทางเข้าฝั่งถนนสายหาดเจ้าสำราญ มุ่งหน้าตรงเข้าสู่อาคารสำนักวิทยบริการ',
        '2. เลี้ยวขวาที่หน้าอาคาร 5 สังเกตป้ายคณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม',
        '3. ถึงจุดหมายปลายทาง อาคาร 16 คณะวิศวกรรมศาสตร์ฯ (อาคารหลัก)',
      ],
    },
    {
      'id': 17,
      'name': 'อาคารศูนย์ภาษาและคอมพิวเตอร์',
      'isEng': false,
      'distance': '320 เมตร',
      'time': '4 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางศูนย์ภาษาและคอมพิวเตอร์',
        '2. ถึงจุดหมายปลายทาง อาคาร 17',
      ],
    },
    {
      'id': 18,
      'name': 'อาคารคณะวิทยาการจัดการ',
      'isEng': false,
      'distance': '350 เมตร',
      'time': '4 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางอาคารคณะวิทยาการจัดการ',
        '2. ถึงจุดหมายปลายทาง อาคาร 18',
      ],
    },
    {
      'id': 19,
      'name': 'อาคารคณะเทคโนโลยีการเกษตร',
      'isEng': false,
      'distance': '480 เมตร',
      'time': '6 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางทิศใต้ เขตคณะเทคโนโลยีการเกษตรและแปลงสาธิต',
        '2. ถึงจุดหมายปลายทาง อาคาร 19',
      ],
    },
    {
      'id': 22,
      'name': 'อาคารสุเมธตันติเวชกุล',
      'isEng': false,
      'distance': '420 เมตร',
      'time': '5 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางหอประชุมใหญ่สุเมธตันติเวชกุล',
        '2. ถึงจุดหมายปลายทาง อาคาร 22',
      ],
    },
    {
      'id': 23,
      'name': 'อาคารคณะมนุษยศาสตร์และสังคมศาสตร์',
      'isEng': false,
      'distance': '360 เมตร',
      'time': '4.5 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางอาคารคณะมนุษยศาสตร์ฯ',
        '2. ถึงจุดหมายปลายทาง อาคาร 23',
      ],
    },
    {
      'id': 25,
      'name': 'อาคารนิวัตสโมสร (Student Union)',
      'isEng': false,
      'distance': '310 เมตร',
      'time': '3.5 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางอาคารกิจกรรมนักศึกษา นิวัตสโมสร',
        '2. ถึงจุดหมายปลายทาง อาคาร 25',
      ],
    },
    {
      'id': 26,
      'name': 'อาคารราชพฤกษ์ (คณะเทคโนโลยีสารสนเทศ)',
      'isEng': false,
      'distance': '340 เมตร',
      'time': '4 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางอาคารราชพฤกษ์ คณะเทคโนโลยีสารสนเทศ',
        '2. ถึงจุดหมายปลายทาง อาคาร 26',
      ],
    },
    {
      'id': 28,
      'name': 'อาคารคณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม (อาคารใหม่)',
      'isEng': true,
      'distance': '320 เมตร',
      'time': '4 นาที',
      'steps': [
        '1. จากประตูทางเข้าฝั่งถนนสายหาดเจ้าสำราญ มุ่งหน้าตรงเข้าสู่อาคารสำนักวิทยบริการ',
        '2. เลี้ยวขวาที่หน้าอาคาร 5 สังเกตป้ายอาคารใหม่คณะวิศวกรรมศาสตร์ฯ',
        '3. ถึงจุดหมายปลายทาง อาคาร 28 คณะวิศวกรรมศาสตร์ฯ (อาคารใหม่)',
      ],
    },
    {
      'id': 29,
      'name': 'อาคารคณะพยาบาลศาสตร์และวิทยาศาสตร์สุขภาพ',
      'isEng': false,
      'distance': '330 เมตร',
      'time': '4 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางอาคารคณะพยาบาลศาสตร์ฯ',
        '2. ถึงจุดหมายปลายทาง อาคาร 29',
      ],
    },
    {
      'id': 33,
      'name': 'อาคารสถาบันช่างเมืองเพชรและศิลปะร่วมสมัย',
      'isEng': false,
      'distance': '340 เมตร',
      'time': '4 นาที',
      'steps': [
        '1. จากประตูทางเข้า ตรงไปทางอาคารสถาบันช่างเมืองเพชรฯ',
        '2. ถึงจุดหมายปลายทาง อาคาร 33',
      ],
    },
  ];

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

  void _showNavigationModal(Map<String, dynamic> item) {
    const primaryColor = Color(0xFF4C52D4);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) {
        final List<String> steps = item['steps'] ?? [];

        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBD5E0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Header Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: item['isEng'] ? primaryColor : const Color(0xFFEDF2F7),
                        child: Text(
                          '${item['id']}',
                          style: TextStyle(
                            color: item['isEng'] ? Colors.white : const Color(0xFF2D3748),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: item['isEng'] ? primaryColor : const Color(0xFF1A202C),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'ระยะทาง: ${item['distance']} • เดินประมาณ ${item['time']}',
                              style: const TextStyle(fontSize: 13.0, color: Color(0xFF718096), fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 28, thickness: 0.8),

                  // Step-by-Step Directions
                  const Row(
                    children: [
                      Icon(Icons.directions_walk_rounded, color: primaryColor, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'เส้นทางแนะนำจากประตูทางเข้า PBRU:',
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14.0),

                  ...steps.map((step) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7FAFC),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          step,
                          style: const TextStyle(fontSize: 13.5, color: Color(0xFF2D3748), height: 1.4),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 20.0),

                  // Action Navigation Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              _highlightedBuilding = item['id'];
                              _selectedBuildingForNavigation = item;
                              _tabController.animateTo(0); // Switch to Map tab!
                            });
                          },
                          icon: const Icon(Icons.navigation_rounded),
                          label: const Text('นำทางบนแผนที่ PBRU', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    final filteredList = _buildings.where((b) {
      final nameMatches = b['name'].toString().contains(_searchQuery);
      final idMatches = b['id'].toString().contains(_searchQuery);
      return nameMatches || idMatches;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'แผนที่แผนผังอาคาร PBRU',
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
            Tab(text: 'ผังแผนที่ PBRU Map'),
            Tab(text: 'รายชื่ออาคารมหาวิทยาลัย'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: PBRU Map Visual
            SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Engineering Highlight Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [primaryColor, Color(0xFF6B72E1)]),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.engineering_rounded, color: Colors.white, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedBuildingForNavigation != null
                                    ? 'นำทางไป: ${_selectedBuildingForNavigation!['name']}'
                                    : 'คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _selectedBuildingForNavigation != null
                                    ? 'ระยะทาง: ${_selectedBuildingForNavigation!['distance']} • เดิน ${_selectedBuildingForNavigation!['time']}'
                                    : 'อาคารหมายเลข: 16 (อาคารหลัก), 8 (โรงช่างหุ่นยนต์), 28 (อาคารใหม่)',
                                style: const TextStyle(color: Color(0xFFE0E5FF), fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Map Render Container
                  Container(
                    width: double.infinity,
                    height: 380,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Stack(
                        children: [
                          CustomPaint(
                            size: const Size(double.infinity, 380),
                            painter: _PBRUMapPainter(highlightedBuilding: _highlightedBuilding),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.directions_rounded, size: 16, color: primaryColor),
                                  SizedBox(width: 4),
                                  Text('กดที่รายการอาคารเพื่อรับเส้นทาง', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Engineering Quick Focus Chips
                  const Text('ตำแหน่งอาคารคณะวิศวกรรมศาสตร์ฯ:', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      _buildBuildingBadge(16, 'อาคาร 16 (หลัก)', primaryColor),
                      const SizedBox(width: 8),
                      _buildBuildingBadge(8, 'อาคาร 8 (หุ่นยนต์/อุตสาหการ)', const Color(0xFFDD6B20)),
                      const SizedBox(width: 8),
                      _buildBuildingBadge(28, 'อาคาร 28 (ใหม่)', const Color(0xFF38A169)),
                    ],
                  ),
                ],
              ),
            ),

            // Tab 2: Searchable Building Directory Table
            Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val.trim();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'ค้นหาด้วยชื่ออาคาร หรือ หมายเลขอาคาร...',
                      prefixIcon: const Icon(Icons.search_rounded, color: primaryColor),
                      filled: true,
                      fillColor: const Color(0xFFF7FAFC),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20.0),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      final bool isEng = item['isEng'];

                      return GestureDetector(
                        onTap: () {
                          _showNavigationModal(item);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: isEng ? const Color(0xFFF0F3FE) : Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: isEng ? Border.all(color: primaryColor, width: 1.5) : Border.all(color: const Color(0xFFE2E8F0)),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 3)),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: isEng ? primaryColor : const Color(0xFFEDF2F7),
                                child: Text(
                                  '${item['id']}',
                                  style: TextStyle(
                                    color: isEng ? Colors.white : const Color(0xFF2D3748),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: isEng ? FontWeight.bold : FontWeight.w600,
                                        color: isEng ? primaryColor : const Color(0xFF2D3748),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.directions_walk_rounded, size: 14, color: primaryColor),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${item['distance']} • เดิน ${item['time']}',
                                          style: const TextStyle(fontSize: 12.0, color: Color(0xFF718096)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: primaryColor),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuildingBadge(int id, String title, Color color) {
    final bool isSelected = _highlightedBuilding == id;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _highlightedBuilding = isSelected ? null : id;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? color : color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 1.5),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Painter representing PBRU Campus Map Layout & Active Navigation Route
class _PBRUMapPainter extends CustomPainter {
  final int? highlightedBuilding;

  _PBRUMapPainter({this.highlightedBuilding});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Background Grass / Campus Grounds
    final bgPaint = Paint()..color = const Color(0xFFE8F5E9);
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    // Main Roads (Grey paths)
    final roadPaint = Paint()
      ..color = const Color(0xFF718096)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;

    final roadPath = Path()
      ..moveTo(w * 0.15, h)
      ..lineTo(w * 0.15, 0); // Hat Chao Samran Road
    canvas.drawPath(roadPath, roadPaint);

    // Inner Campus Roads
    final innerRoadPaint = Paint()
      ..color = const Color(0xFFA0AEC0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final innerRoads = Path()
      ..moveTo(w * 0.15, h * 0.6)
      ..lineTo(w * 0.85, h * 0.6)
      ..moveTo(w * 0.38, h * 0.1)
      ..lineTo(w * 0.38, h * 0.9)
      ..moveTo(w * 0.65, h * 0.1)
      ..lineTo(w * 0.65, h * 0.9);
    canvas.drawPath(innerRoads, innerRoadPaint);

    // Football Field & Track (Top Right)
    final trackPaint = Paint()
      ..color = const Color(0xFFE53E3E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    final fieldPaint = Paint()..color = const Color(0xFF48BB78);

    final fieldRect = Rect.fromLTWH(w * 0.68, h * 0.08, w * 0.24, h * 0.22);
    canvas.drawRRect(RRect.fromRectAndRadius(fieldRect, const Radius.circular(30)), fieldPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(fieldRect, const Radius.circular(30)), trackPaint);

    // Gate & 7-Eleven
    _drawMarker(canvas, Offset(w * 0.08, h * 0.62), 'ประตู', Colors.red);
    _drawMarker(canvas, Offset(w * 0.08, h * 0.25), '7-11', Colors.orange);

    // DRAW ACTIVE NAVIGATION ROUTE LINE IF A BUILDING IS SELECTED!
    if (highlightedBuilding != null) {
      final Offset startGate = Offset(w * 0.15, h * 0.60);
      Offset destPos = Offset(w * 0.55, h * 0.52); // Default to Bldg 16

      if (highlightedBuilding == 8) destPos = Offset(w * 0.55, h * 0.88);
      if (highlightedBuilding == 28) destPos = Offset(w * 0.58, h * 0.54);
      if (highlightedBuilding == 1) destPos = Offset(w * 0.50, h * 0.82);
      if (highlightedBuilding == 3) destPos = Offset(w * 0.58, h * 0.50);

      // Route Line
      final routePath = Path()
        ..moveTo(startGate.dx, startGate.dy)
        ..lineTo(w * 0.38, h * 0.60)
        ..lineTo(destPos.dx, destPos.dy);

      final routePaint = Paint()
        ..color = const Color(0xFFFF6B00)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(routePath, routePaint);

      // Start Pulse Circle
      canvas.drawCircle(startGate, 8, Paint()..color = const Color(0xFFFF6B00));
    }

    // PBRU Buildings
    _drawBuildingNode(canvas, Offset(w * 0.50, h * 0.82), 1, '1');
    _drawBuildingNode(canvas, Offset(w * 0.42, h * 0.78), 2, '2');
    _drawBuildingNode(canvas, Offset(w * 0.58, h * 0.50), 3, '3');
    _drawBuildingNode(canvas, Offset(w * 0.42, h * 0.48), 4, '4');
    _drawBuildingNode(canvas, Offset(w * 0.48, h * 0.52), 5, '5');
    _drawBuildingNode(canvas, Offset(w * 0.55, h * 0.62), 7, '7');

    // ★ FACULTY OF ENGINEERING BUILDINGS (8, 16, 28)
    _drawEngineeringBuilding(canvas, Offset(w * 0.55, h * 0.88), 8, '8');
    _drawEngineeringBuilding(canvas, Offset(w * 0.55, h * 0.52), 16, '16');
    _drawEngineeringBuilding(canvas, Offset(w * 0.58, h * 0.54), 28, '28');

    _drawBuildingNode(canvas, Offset(w * 0.70, h * 0.45), 9, '9');
    _drawBuildingNode(canvas, Offset(w * 0.28, h * 0.32), 10, '10');
    _drawBuildingNode(canvas, Offset(w * 0.85, h * 0.58), 11, '11');
    _drawBuildingNode(canvas, Offset(w * 0.50, h * 0.32), 12, '12');
    _drawBuildingNode(canvas, Offset(w * 0.58, h * 0.88), 13, '13');
    _drawBuildingNode(canvas, Offset(w * 0.42, h * 0.38), 14, '14');
    _drawBuildingNode(canvas, Offset(w * 0.42, h * 0.22), 17, '17');
    _drawBuildingNode(canvas, Offset(w * 0.50, h * 0.22), 18, '18');
    _drawBuildingNode(canvas, Offset(w * 0.78, h * 0.82), 19, '19');
    _drawBuildingNode(canvas, Offset(w * 0.82, h * 0.42), 22, '22');
    _drawBuildingNode(canvas, Offset(w * 0.58, h * 0.22), 23, '23');
    _drawBuildingNode(canvas, Offset(w * 0.60, h * 0.38), 25, '25');
    _drawBuildingNode(canvas, Offset(w * 0.58, h * 0.10), 26, '26');
    _drawBuildingNode(canvas, Offset(w * 0.50, h * 0.10), 29, '29');
    _drawBuildingNode(canvas, Offset(w * 0.58, h * 0.32), 33, '33');
  }

  void _drawMarker(Canvas canvas, Offset pos, String text, Color color) {
    canvas.drawCircle(pos, 12, Paint()..color = color);
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(pos.dx - textPainter.width / 2, pos.dy - textPainter.height / 2));
  }

  void _drawBuildingNode(Canvas canvas, Offset pos, int id, String label) {
    final bool isSelected = highlightedBuilding == id;

    final bgPaint = Paint()..color = isSelected ? const Color(0xFF38A169) : const Color(0xFFE53E3E);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: pos, width: 22, height: 18), const Radius.circular(4)), bgPaint);

    final textPainter = TextPainter(
      text: TextSpan(text: label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(pos.dx - textPainter.width / 2, pos.dy - textPainter.height / 2));
  }

  void _drawEngineeringBuilding(Canvas canvas, Offset pos, int id, String label) {
    final bool isSelected = highlightedBuilding == id;

    // Glowing Star/Badge for Engineering
    final bgPaint = Paint()..color = isSelected ? const Color(0xFF38A169) : const Color(0xFF4C52D4);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: pos, width: 26, height: 22), const Radius.circular(6)), bgPaint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: pos, width: 26, height: 22), const Radius.circular(6)), borderPaint);

    final textPainter = TextPainter(
      text: TextSpan(text: label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(pos.dx - textPainter.width / 2, pos.dy - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
