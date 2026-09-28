import 'package:flutter/material.dart';

class RoomBookingScreen extends StatefulWidget {
  const RoomBookingScreen({super.key});

  @override
  State<RoomBookingScreen> createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedRoom = 'ห้องแล็บวิศวกรรมคอมพิวเตอร์และปัญญาประดิษฐ์ (ENG-302)';
  String _selectedTimeSlot = '10:00 - 12:00 น.';
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  final _objectiveController = TextEditingController();

  final List<String> _rooms = [
    'ห้องแล็บวิศวกรรมคอมพิวเตอร์และปัญญาประดิษฐ์ (ENG-302)',
    'ห้องปฏิบัติการหุ่นยนต์และระบบอัตโนมัติ (ENG-101)',
    'ห้องปฏิบัติการวิศวกรรมไฟฟ้าและวงจร (ENG-201)',
    'ห้องโดมกลุ่มเรียนรู้ (Learning Center Meeting Room)',
    'ห้องประชุมคณะวิศวกรรมศาสตร์ฯ (ENG-Conf)',
  ];

  final List<String> _timeSlots = [
    '09:00 - 11:00 น.',
    '11:00 - 13:00 น.',
    '13:00 - 15:00 น.',
    '15:00 - 17:00 น.',
  ];

  @override
  void dispose() {
    _objectiveController.dispose();
    super.dispose();
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          title: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Color(0xFF38A169), size: 28),
              SizedBox(width: 8),
              Text('จองห้องเรียน/แล็บสำเร็จ'),
            ],
          ),
          content: Text('จอง: $_selectedRoom\nช่วงเวลา: $_selectedTimeSlot\nวันที่: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year + 543} เรียบร้อยแล้ว'),
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

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'จองห้องเรียน / ห้องแล็บ',
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
                // Header Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: primaryColor.withOpacity(0.2)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.meeting_room_rounded, color: primaryColor, size: 28),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'บริการจองห้องปฏิบัติการและห้องประชุม คณะวิศวกรรมศาสตร์ฯ',
                          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 13.5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),

                // Select Room
                const Text('เลือกห้องเรียน / ห้องแล็บ', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _selectedRoom,
                  isExpanded: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.door_sliding_outlined, color: primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  items: _rooms.map((room) => DropdownMenuItem(value: room, child: Text(room, style: const TextStyle(fontSize: 13.5), overflow: TextOverflow.ellipsis))).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedRoom = val);
                  },
                ),
                const SizedBox(height: 20.0),

                // Select Time Slot
                const Text('ช่วงเวลาที่ต้องการใช้ห้อง', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _timeSlots.map((slot) {
                    final isSelected = _selectedTimeSlot == slot;
                    return ChoiceChip(
                      label: Text(slot),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedTimeSlot = slot);
                      },
                      selectedColor: primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF2D3748),
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20.0),

                // Reason / Objective Field
                const Text('วัตถุประสงค์การเข้าใช้ห้อง', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _objectiveController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'เช่น ประชุมกลุ่มทำโปรเจกต์ หรือขอใช้คอมพิวเตอร์ทดสอบโปรแกรม',
                    hintStyle: const TextStyle(color: Color(0xFFA0AEC0), fontSize: 13.5),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'กรุณาระบุวัตถุประสงค์' : null,
                ),
                const SizedBox(height: 32.0),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 52.0,
                  child: ElevatedButton(
                    onPressed: _submitBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    ),
                    child: const Text('ยืนยันส่งคำขอจองห้อง', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
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
