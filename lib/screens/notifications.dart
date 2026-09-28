import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'คำขอนัดหมายได้รับการยืนยันแล้ว',
      'body': 'ผศ.ดร.วิศวกรรม นวัตกรรม ได้ตอบรับคำขอนัดพบของคุณ ในวันที่ 24 พ.ค. เวลา 10:30 น.',
      'time': '10 นาทีที่แล้ว',
      'isRead': false,
      'type': 'SUCCESS',
    },
    {
      'title': 'แจ้งเตือนใกล้นัดหมาย',
      'body': 'คุณมีนัดติวกลุ่มวิชา Mobile App Development ที่อาคารโดมเรียนรู้ วันนี้ เวลา 13:30 น.',
      'time': '1 ชั่วโมงที่แล้ว',
      'isRead': false,
      'type': 'ALERT',
    },
    {
      'title': 'มีการเปลี่ยนแปลงห้องนัดหมาย',
      'body': 'อ.ช่างกล ช่างคิด ได้ขอเปลี่ยนสถานที่นัดพบเป็น อาคารวิศวกรรมศาสตร์ ชั้น 3 ห้อง 305',
      'time': 'เมื่อวานนี้',
      'isRead': true,
      'type': 'INFO',
    },
    {
      'title': 'ยินดีต้อนรับสู่ CampusMeet',
      'body': 'ลงทะเบียนเข้าใช้งาน คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม มรภ.เพชรบุรี เรียบร้อยแล้ว',
      'time': '2 วันที่แล้ว',
      'isRead': true,
      'type': 'INFO',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'การแจ้งเตือน',
          style: TextStyle(color: Color(0xFF1A202C), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2D3748)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var item in _notifications) {
                  item['isRead'] = true;
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('อ่านการแจ้งเตือนทั้งหมดแล้ว')),
              );
            },
            child: const Text('อ่านทั้งหมด', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(20.0),
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notif = _notifications[index];
            final bool isRead = notif['isRead'];

            IconData iconData = Icons.notifications_active_rounded;
            Color iconBg = primaryColor.withOpacity(0.12);
            Color iconColor = primaryColor;

            if (notif['type'] == 'SUCCESS') {
              iconData = Icons.check_circle_rounded;
              iconBg = const Color(0xFFC6F6D5);
              iconColor = const Color(0xFF38A169);
            } else if (notif['type'] == 'ALERT') {
              iconData = Icons.alarm_rounded;
              iconBg = const Color(0xFFFEEBC8);
              iconColor = const Color(0xFFDD6B20);
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  notif['isRead'] = true;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 14.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: isRead ? Colors.white : const Color(0xFFF0F3FE),
                  borderRadius: BorderRadius.circular(16.0),
                  border: isRead ? Border.all(color: const Color(0xFFE2E8F0)) : Border.all(color: primaryColor.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: iconBg,
                      child: Icon(iconData, color: iconColor, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  notif['title'],
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: isRead ? FontWeight.bold : FontWeight.w800,
                                    color: const Color(0xFF1A202C),
                                  ),
                                ),
                              ),
                              if (!isRead)
                                const CircleAvatar(radius: 4, backgroundColor: primaryColor),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notif['body'],
                            style: const TextStyle(fontSize: 13.5, color: Color(0xFF4A5568), height: 1.3),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            notif['time'],
                            style: const TextStyle(fontSize: 12.0, color: Color(0xFFA0AEC0)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
