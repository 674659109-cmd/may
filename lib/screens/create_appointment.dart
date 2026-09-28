import 'package:flutter/material.dart';

class CreateAppointmentScreen extends StatefulWidget {
  final String? initialMajor;
  final String? initialLecturer;

  const CreateAppointmentScreen({
    super.key,
    this.initialMajor,
    this.initialLecturer,
  });

  @override
  State<CreateAppointmentScreen> createState() => _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _appointmentType = 'นัดพบอาจารย์ที่ปรึกษา';
  late String _selectedMajor;
  String? _selectedLecturer;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 30);
  final _locationController = TextEditingController(text: 'อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 302');
  final _topicController = TextEditingController();

  final List<String> _types = [
    'นัดพบอาจารย์ที่ปรึกษา',
    'นัดปรึกษาเรื่องโปรเจกต์/ภาคนิพนธ์',
    'นัดติวกลุ่มเพื่อนนักศึกษา',
    'นัดใช้งานห้องปฏิบัติการ/เครื่องมือวิศวกรรม',
  ];

  final List<String> _engineeringMajors = [
    'วิศวกรรมไฟฟ้า',
    'วิศวกรรมพลังงาน',
    'วิศวกรรมเครื่องกล',
    'วิศวกรรมอุตสาหการ',
    'สาขาสถาปัตยกรรมภายใน',
    'วิศวกรรมสารสนเทศและการสื่อสาร',
  ];

  final Map<String, List<String>> _lecturersByMajor = {
    'วิศวกรรมไฟฟ้า': [
      'ผศ.อนุรักษ์ เกษวัฒนากุล',
      'อ.บุรีรักษ์ สังข์คงเมือง',
      'อ.กมลวรรณ วงศ์วุฒิ',
      'ผศ.ดร.ราเชณ คณะนา',
      'ผศ.ดร.วิโรจน์ จงชนะชววัฒน์',
    ],
    'วิศวกรรมพลังงาน': [
      'อ.เจิมธง ปรารถนารักษ์ (ประธานหลักสูตร)',
      'ผศ.ดร.กังสดาล สกุลพงษ์มาลี',
      'อ.ดร.จุติพร อินทะนิน',
      'อ.ชลีดล อินยาศรี',
      'อ.ปองพล รักการงาน',
    ],
    'วิศวกรรมเครื่องกล': [
      'ผศ.ดร.ช่วงชัย ชุปวา (ประธานสาขาวิชา)',
      'ผศ.ดร.อนุชา สายสร้อย',
      'ผศ.ดร.ขวัญชัย หนาแน่น',
      'ผศ.ดร.พิเชฐ นิลดวงดี',
      'ผศ.ดร.ปรัชญา มุขดา',
      'รศ.ดร.อุทัย ผ่องรัศมี (ประธานสาขาฯ ป.โท)',
      'อ.ชยุต พลอยจิรภาส',
      'อ.ดวงฤดี ชูตระกูล',
    ],
    'วิศวกรรมอุตสาหการ': [
      'อ.ประเสริฐ ปราชญ์ประยูร (ประธานสาขาวิชา)',
      'อ.อลงกรณ์ ฉัตรเมืองปัก',
      'อ.ชลาลัย วงเวียน',
    ],
    'สาขาสถาปัตยกรรมภายใน': [
      'ผศ.วิเชียร เข็มเงิน (ประธานสาขาวิชา)',
      'อ.เฉลิมศักดิ์ แก้วเกาะ',
      'อ.จิตราพร ชัยเสริมวงศ์',
      'อ.จิตรา มีทองคำ',
      'อ.ภัทรวรรณ เอมกมล',
      'อ.จตุพล อังศุเวช',
    ],
    'วิศวกรรมสารสนเทศและการสื่อสาร': [
      'ผศ.กฤษณ์ ไชยวงศ์ (ประธานสาขาวิชา)',
      'ผศ.ดร.ปาณิศา แก้วสวัสดิ์',
      'อ.ดร.กิตติพงศ์ นวลใย',
      'อ.ดร.ดวงกมล อังอำนวยศิริ',
      'อ.ดร.ประกิจ อินทะชัย',
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedMajor = (widget.initialMajor != null && _engineeringMajors.contains(widget.initialMajor))
        ? widget.initialMajor!
        : 'วิศวกรรมสารสนเทศและการสื่อสาร';

    final available = _lecturersByMajor[_selectedMajor] ?? [];
    if (widget.initialLecturer != null && available.contains(widget.initialLecturer)) {
      _selectedLecturer = widget.initialLecturer!;
    } else {
      _selectedLecturer = available.isNotEmpty ? available.first : null;
    }
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
          content: Text('ส่งคำขอนัดหมายไปที่: $_selectedLecturer\nสาขา$_selectedMajor\nคณะวิศวกรรมศาสตร์ฯ เรียบร้อยแล้ว'),
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
    final availableLecturers = _lecturersByMajor[_selectedMajor] ?? [];

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
                // Faculty Header Badge
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: primaryColor.withOpacity(0.2)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.engineering_rounded, color: primaryColor),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม มรภ.เพชรบุรี',
                          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),

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

                // Major Selector
                const Text(
                  'เลือกสาขาวิชา',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _selectedMajor,
                  isExpanded: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.school_outlined, color: primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  items: _engineeringMajors.map((major) => DropdownMenuItem(value: major, child: Text(major, style: const TextStyle(fontSize: 13.5), overflow: TextOverflow.ellipsis))).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedMajor = val;
                        _selectedLecturer = _lecturersByMajor[val]?.first;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20.0),

                // Lecturer Selector Filtered by Major
                const Text(
                  'นัดหมายกับ (อาจารย์ประจำสาขาวิชา)',
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
                  items: availableLecturers.map((lec) => DropdownMenuItem(value: lec, child: Text(lec, style: const TextStyle(fontSize: 13.5), overflow: TextOverflow.ellipsis))).toList(),
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
                    hintText: 'เช่น ขอปรึกษาเรื่องหัวข้อโปรเจกต์ หรือขอใช้ห้องปฏิบัติการ',
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
