import 'package:flutter/material.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({super.key});

  @override
  State<CreateAppointmentScreen> createState() => _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _appointmentType = 'นัดพบอาจารย์ที่ปรึกษา';
  String _selectedFaculty = 'คณะเทคโนโลยีสารสนเทศ';
  String? _selectedLecturer;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 30);
  final _locationController = TextEditingController(text: 'อาคาร 15 ชั้น 4 ห้อง 402');
  final _topicController = TextEditingController();

  final List<String> _types = [
    'นัดพบอาจารย์ที่ปรึกษา',
    'นัดปรึกษาเรื่องเรียน/ภาคนิพนธ์',
    'นัดติวกลุ่มเพื่อนนักศึกษา',
    'นัดติดต่องานทะเบียน/สำนักส่งเสริม',
  ];

  final List<String> _faculties = [
    'คณะเทคโนโลยีสารสนเทศ',
    'คณะวิทยาการจัดการ',
    'คณะครุศาสตร์',
    'คณะมนุษยศาสตร์และสังคมศาสตร์',
    'คณะวิทยาศาสตร์และเทคโนโลยี',
    'คณะเทคโนโลยีการเกษตร',
    'คณะพยาบาลศาสตร์และวิทยาศาสตร์สุขภาพ',
    'คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม',
  ];

  final Map<String, List<String>> _lecturersByFaculty = {
    'คณะเทคโนโลยีสารสนเทศ': [
      'อ.ดร.สมศักดิ์ วิชาการ',
      'ผศ.ประเสริฐ รู้จริง',
    ],
    'คณะวิทยาการจัดการ': [
      'ผศ.ดร.วิภาดา สอนดี',
      'อ.ณรงค์ บริหารงาน',
    ],
    'คณะครุศาสตร์': [
      'อ.กิตติศักดิ์ มั่นคง',
      'ผศ.ปัญญา สั่งสอน',
    ],
    'คณะมนุษยศาสตร์และสังคมศาสตร์': [
      'ดร.อนันต์ มนุษยศิลป์',
      'อ.วรรณา ภาษาไทย',
    ],
    'คณะวิทยาศาสตร์และเทคโนโลยี': [
      'ผศ.ดร.สมชาย วิทยา',
      'ดร.สิริมา ชีววิทยา',
    ],
    'คณะเทคโนโลยีการเกษตร': [
      'อ.ดร.เกษตร เกษตรกรรม',
      'ผศ.สมพงษ์ พืชพรรณ',
    ],
    'คณะพยาบาลศาสตร์และวิทยาศาสตร์สุขภาพ': [
      'ผศ.พยาบาล นุ่มนวล',
      'อ.ดร.อรพินท์ สุขภาพดี',
    ],
    'คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม': [
      'อ.ช่างกล ช่างคิด',
      'ผศ.ดร.วิศวกรรม นวัตกรรม',
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedLecturer = _lecturersByFaculty[_selectedFaculty]!.first;
  }

  @override
  void dispose() {
    _locationController.dispose();
    _topicController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4C52D4),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4C52D4),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitAppointment() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          title: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Color(0xFF38A169), size: 28),
              SizedBox(width: 8),
              Text('ส่งคำขอนัดหมายแล้ว'),
            ],
          ),
          content: Text('ส่งคำขอนัดหมายไปที่: $_selectedLecturer ($_selectedFaculty) เรียบร้อยแล้ว'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('ตกลง', style: TextStyle(color: Color(0xFF4C52D4), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);
    final availableLecturers = _lecturersByFaculty[_selectedFaculty] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFE),
      appBar: AppBar(
        title: const Text(
          'สร้างนัดหมายใหม่',
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type Selector
                const Text(
                  'ประเภทการนัดหมาย',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _appointmentType,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.category_outlined, color: primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  items: _types.map((type) => DropdownMenuItem(value: type, child: Text(type, style: const TextStyle(fontSize: 14.0)))).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _appointmentType = val);
                  },
                ),
                const SizedBox(height: 20.0),

                // Faculty Selector
                const Text(
                  'เลือกคณะสังกัด',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _selectedFaculty,
                  isExpanded: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.school_outlined, color: primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  items: _faculties.map((fac) => DropdownMenuItem(value: fac, child: Text(fac, style: const TextStyle(fontSize: 14.0), overflow: TextOverflow.ellipsis))).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedFaculty = val;
                        _selectedLecturer = _lecturersByFaculty[val]?.first;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20.0),

                // Lecturer Selector Filtered by Faculty
                const Text(
                  'นัดหมายกับ (อาจารย์ / บุคลากร)',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _selectedLecturer,
                  isExpanded: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_search_outlined, color: primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  items: availableLecturers.map((lec) => DropdownMenuItem(value: lec, child: Text(lec, style: const TextStyle(fontSize: 14.0), overflow: TextOverflow.ellipsis))).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedLecturer = val);
                  },
                ),
                const SizedBox(height: 20.0),

                // Date & Time Picker Row
                Row(
                  children: [
                    // Date Picker
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'วันที่นัดหมาย',
                            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                          ),
                          const SizedBox(height: 8.0),
                          InkWell(
                            onTap: _pickDate,
                            borderRadius: BorderRadius.circular(14.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14.0),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_month_rounded, color: primaryColor, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year + 543}',
                                    style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14.0),

                    // Time Picker
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'เวลานัดหมาย',
                            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                          ),
                          const SizedBox(height: 8.0),
                          InkWell(
                            onTap: _pickTime,
                            borderRadius: BorderRadius.circular(14.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14.0),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.access_time_rounded, color: primaryColor, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    _selectedTime.format(context),
                                    style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

                // Location Field
                const Text(
                  'สถานที่นัดพบ',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: 'ระบุอาคาร/ห้องนัดหมาย',
                    prefixIcon: const Icon(Icons.location_on_outlined, color: primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'กรุณาระบุสถานที่นัดพบ' : null,
                ),
                const SizedBox(height: 20.0),

                // Topic / Reason Field
                const Text(
                  'หัวข้อ / วัตถุประสงค์การนัดหมาย',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _topicController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'เช่น ขอคำปรึกษาเรื่องหัวข้อโปรเจกต์ หรือยื่นเอกสารสัญญาทุนการศึกษา',
                    hintStyle: const TextStyle(color: Color(0xFFA0AEC0), fontSize: 13.5),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'กรุณาระบุวัตถุประสงค์' : null,
                ),
                const SizedBox(height: 32.0),

                // Confirm Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 52.0,
                  child: ElevatedButton(
                    onPressed: _submitAppointment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    ),
                    child: const Text(
                      'ส่งคำขอนัดหมาย',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
