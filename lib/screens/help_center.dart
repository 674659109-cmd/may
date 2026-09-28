import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final List<Map<String, String>> _faqs = [
    {
      'question': 'วิธียื่นคำขอนัดหมายอาจารย์ทำอย่างไร?',
      'answer': 'กดเมนู "สร้างนัดหมาย" บนหน้าหลัก เลือกสาขาวิชา และเลือกอาจารย์ที่ต้องการ จากนั้นระบุวัน เวลา สถานที่ และส่งคำขอ',
    },
    {
      'question': 'หากต้องการยกเลิกหรือเลื่อนนัดหมายต้องทำอย่างไร?',
      'answer': 'ไปที่เมนู "ตารางนัด" เลือกนัดหมายที่ต้องการ จากนั้นกดปุ่ม "ยกเลิกนัด" หรือสร้างนัดหมายใหม่ในวันเวลาที่สะดวก',
    },
    {
      'question': 'จะทราบได้อย่างไรว่าอาจารย์ตอบรับการนัดหมายแล้ว?',
      'answer': 'ระบบจะส่งการแจ้งเตือนเตือนในแอป และสถานะในตารางนัดจะเปลี่ยนเป็นป้ายสีเขียว "ยืนยันแล้ว"',
    },
    {
      'question': 'หากลืมรหัสผ่านต้องทำอย่างไร?',
      'answer': 'กดปุ่ม "ลืมรหัสผ่าน?" ในหน้าเข้าสู่ระบบ ระบบจะส่งลิงก์สำหรับตั้งรหัสผ่านใหม่ไปยังอีเมลมหาวิทยาลัยของคุณ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'ศูนย์ช่วยเหลือ & FAQ',
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
              // Contact Admin Banner Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [primaryColor, Color(0xFF6B72E1)]),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ต้องการความช่วยเหลือเพิ่มเติม?', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    const Text('ติดต่อเจ้าหน้าที่ไอที คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม', style: TextStyle(color: Color(0xFFE0E5FF), fontSize: 13.5)),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('กำลังเปิดช่องทางติดต่อเจ้าหน้าที่ไอที')),
                        );
                      },
                      icon: const Icon(Icons.support_agent_rounded, color: primaryColor),
                      label: const Text('ติดต่อเจ้าหน้าที่', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28.0),

              // FAQ List Title
              const Text('คำถามที่พบบ่อย (FAQ)', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C))),
              const SizedBox(height: 14.0),

              ..._faqs.map((faq) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: ExpansionTile(
                    shape: Border.all(color: Colors.transparent),
                    leading: const Icon(Icons.help_outline_rounded, color: primaryColor),
                    title: Text(faq['question']!, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        child: Text(faq['answer']!, style: const TextStyle(fontSize: 14.0, color: Color(0xFF4A5568), height: 1.4)),
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
