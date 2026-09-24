import 'package:flutter/material.dart';
import 'package:may/screens/login.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'โปรไฟล์นักศึกษา',
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
            children: [
              // Profile Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 46,
                          backgroundColor: primaryColor.withOpacity(0.12),
                          child: const Icon(Icons.person_rounded, color: primaryColor, size: 56),
                        ),
                        const Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: primaryColor,
                            child: Icon(Icons.edit_rounded, color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'นายสมชาย ใจดี',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'รหัสนักศึกษา: 6512345678',
                      style: TextStyle(fontSize: 14.0, color: Color(0xFF718096), fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'คณะเทคโนโลยีสารสนเทศ • สาขาวิชาวิทยาการคอมพิวเตอร์',
                      style: TextStyle(fontSize: 13.0, color: primaryColor, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              // Account Options List
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildOptionTile(
                      icon: Icons.person_outline_rounded,
                      title: 'แก้ไขข้อมูลส่วนตัว',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 56),
                    _buildOptionTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'ตั้งค่าการแจ้งเตือน',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 56),
                    _buildOptionTile(
                      icon: Icons.security_rounded,
                      title: 'ความปลอดภัย & รหัสผ่าน',
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 56),
                    _buildOptionTile(
                      icon: Icons.help_outline_rounded,
                      title: 'ศูนย์ช่วยเหลือ & ติดต่อผู้ดูแลระบบ',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              // Logout Button
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout_rounded, color: Colors.red),
                  label: const Text('ออกจากระบบ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFEB2B2)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4C52D4)),
      title: Text(title, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Color(0xFF2D3748))),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFFA0AEC0)),
      onTap: onTap,
    );
  }
}
