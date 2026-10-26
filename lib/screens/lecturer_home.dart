import 'package:flutter/material.dart';
import 'package:may/models/appointment_data.dart';
import 'package:may/screens/login.dart';

class LecturerHomeScreen extends StatefulWidget {
  const LecturerHomeScreen({super.key});

  @override
  State<LecturerHomeScreen> createState() => _LecturerHomeScreenState();
}

class _LecturerHomeScreenState extends State<LecturerHomeScreen> {
  String _selectedLecturerName = 'ผศ.กฤษณ์ ไชยวงศ์';
  String _selectedLecturerEmail = 'krit.cha@pbru.ac.th';
  String _selectedDepartment = 'วิศวกรรมสารสนเทศและการสื่อสาร';

  final List<Map<String, String>> _allLecturers = [
    {'name': 'ผศ.กฤษณ์ ไชยวงศ์', 'dept': 'วิศวกรรมสารสนเทศและการสื่อสาร', 'email': 'krit.cha@pbru.ac.th'},
    {'name': 'ผศ.ดร.ช่วงชัย ชุปวา', 'dept': 'วิศวกรรมเครื่องกล', 'email': 'chuangchai.chu@pbru.ac.th'},
    {'name': 'ผศ.ดร.ปาณิศา แก้วสวัสดิ์', 'dept': 'วิศวกรรมสารสนเทศและการสื่อสาร', 'email': 'panisa.kae@pbru.ac.th'},
    {'name': 'อ.เจิมธง ปรารถนารักษ์', 'dept': 'วิศวกรรมพลังงาน', 'email': 'jermthong.par@pbru.ac.th'},
    {'name': 'อ.ประเสริฐ ปราชญ์ประยูร', 'dept': 'วิศวกรรมอุตสาหการ', 'email': 'prasert.pra@pbru.ac.th'},
    {'name': 'ผศ.วิเชียร เข็มเงิน', 'dept': 'สาขาสถาปัตยกรรมภายใน', 'email': 'wichian.khem@pbru.ac.th'},
    {'name': 'ผศ.อนุรักษ์ เกษวัฒนากุล', 'dept': 'วิศวกรรมไฟฟ้า', 'email': 'anurak.kas@pbru.ac.th'},
  ];

  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = _selectedLecturerEmail;
    AppointmentData.addListener(_onAppointmentsChanged);
  }

  @override
  void dispose() {
    AppointmentData.removeListener(_onAppointmentsChanged);
    _emailController.dispose();
    super.dispose();
  }

  void _onAppointmentsChanged() {
    if (mounted) setState(() {});
  }

  void _showEditEmailDialog() {
    _emailController.text = _selectedLecturerEmail;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('แก้ไขอีเมลอาจารย์ผู้พิจารณา'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('อีเมลปัจจุบันสำหรับ: $_selectedLecturerName', style: const TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'อีเมล (@pbru.ac.th)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedLecturerEmail = _emailController.text.trim();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('อัปเดตอีเมลสำหรับอนุมัติเป็น: $_selectedLecturerEmail เรียบร้อย')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4C52D4)),
            child: const Text('บันทึก', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);
    final pendingRequests = AppointmentData.appointments.where((a) => a.status == 'PENDING').toList();
    final confirmedCount = AppointmentData.appointments.where((a) => a.status == 'CONFIRMED').length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Row(
          children: [
            Icon(Icons.engineering_rounded, color: primaryColor, size: 28),
            SizedBox(width: 10),
            Text(
              'CampusMeet (อาจารย์)',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Color(0xFFE53E3E)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: const Text('ออกจากระบบ'),
                  content: const Text('คุณต้องการออกจากระบบสิทธิอาจารย์หรือไม่?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('ยกเลิก', style: TextStyle(color: Colors.grey)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: const Text('ออกจากระบบ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LECTURER SWITCHER & EMAIL CONFIG CARD
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 3)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.admin_panel_settings_rounded, color: primaryColor, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'สลับผู้มีอำนาจอนุมัติ (อาจารย์ผู้พิจารณา)',
                          style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedLecturerName,
                      isExpanded: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF7FAFC),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                      ),
                      items: _allLecturers.map((lec) {
                        return DropdownMenuItem<String>(
                          value: lec['name'],
                          child: Text('${lec['name']} (${lec['dept']})', style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          final found = _allLecturers.firstWhere((l) => l['name'] == val);
                          setState(() {
                            _selectedLecturerName = found['name']!;
                            _selectedDepartment = found['dept']!;
                            _selectedLecturerEmail = found['email']!;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '📧 อีเมลอนุมัติ: $_selectedLecturerEmail',
                            style: const TextStyle(fontSize: 13, color: Color(0xFF4A5568), fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _showEditEmailDialog,
                          icon: const Icon(Icons.edit_outlined, size: 16),
                          label: const Text('แก้ไขอีเมล'),
                          style: TextButton.styleFrom(foregroundColor: primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // Lecturer Greeting Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4C52D4), Color(0xFF3B40A4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4C52D4).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'สวัสดี, $_selectedLecturerName 👨‍🏫',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'ประธาน/อาจารย์ประจำสาขา$_selectedDepartment',
                      style: const TextStyle(
                        color: Color(0xFFE0E5FF),
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม มรภ.เพชรบุรี',
                      style: TextStyle(
                        color: Color(0xFFC5CEFF),
                        fontSize: 12.5,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            'รอดำเนินการ: ${pendingRequests.length} รายการ',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF38A169).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            'อนุมัติแล้ว: $confirmedCount รายการ',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28.0),

              // Pending Requests Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'คำขอนัดหมายรอดำเนินการ (${pendingRequests.length})',
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
                  ),
                ],
              ),
              const SizedBox(height: 14.0),

              if (pendingRequests.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text('ไม่มีคำขอนัดหมายที่รออนุมัติในขณะนี้', style: TextStyle(color: Color(0xFF718096), fontSize: 15)),
                  ),
                )
              else
                ...pendingRequests.map((req) {
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
                            Text(
                              req.studentName,
                              style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: req.statusBg,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(req.statusText, style: TextStyle(color: req.statusColor, fontSize: 12.0, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'รหัสนักศึกษา: ${req.studentId} • ${req.major}',
                          style: const TextStyle(fontSize: 13.0, color: Color(0xFF718096)),
                        ),
                        const Divider(height: 20, thickness: 0.8),
                        Text('📌 วัตถุประสงค์: ${req.topic}', style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xFF2D3748))),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.access_time_rounded, size: 16, color: primaryColor),
                            const SizedBox(width: 6),
                            Text('${req.date} • ${req.time}', style: const TextStyle(fontSize: 13.0, color: Color(0xFF4A5568))),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.email_outlined, size: 16, color: primaryColor),
                            const SizedBox(width: 6),
                            Text('ผู้พิจารณา: $_selectedLecturerName ($_selectedLecturerEmail)', style: const TextStyle(fontSize: 12.5, color: Color(0xFF718096))),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    AppointmentData.rejectAppointment(req.id);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('ปฏิเสธ/เลื่อนนัดหมายเรียบร้อยแล้ว')),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFFFEB2B2)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('ปฏิเสธ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    AppointmentData.approveAppointment(req.id);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: const Color(0xFF38A169),
                                      content: Text('อนุมัติโดย $_selectedLecturerName ($_selectedLecturerEmail) สำเร็จ!'),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF38A169),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('อนุมัติคำขอ', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
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
