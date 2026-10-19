import 'package:flutter/material.dart';
import 'package:may/models/appointment_data.dart';
import 'package:may/models/user_data.dart';
import 'package:may/screens/appointment_detail.dart';
import 'package:may/screens/campus_map.dart';
import 'package:may/screens/create_appointment.dart';
import 'package:may/screens/history.dart';
import 'package:may/screens/notifications.dart';
import 'package:may/screens/profile.dart';
import 'package:may/screens/room_booking.dart';
import 'package:may/screens/schedule.dart';
import 'package:may/screens/search_lecturer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.engineering_rounded, color: primaryColor, size: 24),
            ),
            const SizedBox(width: 10),
            const Text(
              'CampusMeet',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          ValueListenableBuilder<List<AppointmentItem>>(
            valueListenable: AppointmentData.appointmentsNotifier,
            builder: (context, appointments, child) {
              final hasUnread = AppointmentData.notifications.any((n) => !n['isRead']);
              return IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.notifications_none_rounded, color: Color(0xFF2D3748), size: 26),
                    if (hasUnread)
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE53E3E),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                  );
                },
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            _buildHomeTab(context),
            const ScheduleScreen(),
            const HistoryScreen(),
            const ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: const Color(0xFFA0AEC0),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today_rounded),
            label: 'ตารางนัด',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            activeIcon: Icon(Icons.history_toggle_off_rounded),
            label: 'ประวัติ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'โปรไฟล์',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    return ValueListenableBuilder<List<AppointmentItem>>(
      valueListenable: AppointmentData.appointmentsNotifier,
      builder: (context, appointments, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student Greeting Header
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
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'สวัสดี, ${UserData.name} 👋',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'รหัสนักศึกษา: ${UserData.studentId} • ${UserData.major}',
                      style: const TextStyle(
                        color: Color(0xFFE0E5FF),
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม มรภ.เพชรบุรี',
                      style: TextStyle(
                        color: Color(0xFFC5CEFF),
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScheduleScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.event_available_rounded, color: Colors.white, size: 18),
                            const SizedBox(width: 8.0),
                            Text(
                              'มีนัดหมายรวม ${appointments.length} รายการ',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 12),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28.0),

              // Menu Grid
              const Text(
                'เมนูด่วน',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A202C),
                ),
              ),
              const SizedBox(height: 14.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMenuItem(
                    icon: Icons.add_circle_outline_rounded,
                    title: 'สร้างนัดหมาย',
                    color: primaryColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CreateAppointmentScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.search_rounded,
                    title: 'ค้นหาอาจารย์',
                    color: const Color(0xFF319795),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SearchLecturerScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.meeting_room_outlined,
                    title: 'จองห้องแล็บ',
                    color: const Color(0xFFD69E2E),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RoomBookingScreen()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.map_outlined,
                    title: 'แผนที่อาคาร',
                    color: const Color(0xFF805AD5),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CampusMapScreen()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 28.0),

              // Upcoming Appointments Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'นัดหมายเร็วๆ นี้',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A202C),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScheduleScreen()),
                      );
                    },
                    child: const Text('ดูทั้งหมด', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              // Dynamic Appointment Cards
              if (appointments.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('ยังไม่มีรายการนัดหมาย', style: TextStyle(color: Color(0xFF718096))),
                  ),
                )
              else
                ...appointments.map((item) {
                  final mapItem = {
                    'id': item.id,
                    'title': item.title,
                    'person': item.person,
                    'major': item.major,
                    'location': item.location,
                    'date': item.date,
                    'time': item.time,
                    'topic': item.topic,
                    'status': item.status,
                    'statusText': item.statusText,
                    'statusColor': item.statusColor,
                    'statusBg': item.statusBg,
                  };

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentDetailScreen(appointment: mapItem),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14.0),
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
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A202C),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: item.statusBg,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  item.statusText,
                                  style: TextStyle(
                                    color: item.statusColor,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.person_outline_rounded, size: 18, color: Color(0xFF718096)),
                              const SizedBox(width: 6),
                              Text(
                                item.person,
                                style: const TextStyle(fontSize: 14.0, color: Color(0xFF4A5568), fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const Divider(height: 20, thickness: 0.8),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 18, color: primaryColor),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  item.location,
                                  style: const TextStyle(fontSize: 13.5, color: Color(0xFF4A5568)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.access_time_rounded, size: 18, color: primaryColor),
                              const SizedBox(width: 6),
                              Text(
                                '${item.date} • ${item.time}',
                                style: const TextStyle(fontSize: 13.5, color: Color(0xFF4A5568)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
