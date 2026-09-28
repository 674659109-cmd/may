import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailAlerts = true;
  bool _soundEnabled = true;
  String _selectedLanguage = 'ภาษาไทย';

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'การตั้งค่าแอปพลิเคชัน',
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
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // Notification Settings Group
            const Text(
              'การแจ้งเตือน',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF718096)),
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 3)),
                ],
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    activeColor: primaryColor,
                    secondary: const Icon(Icons.notifications_active_rounded, color: primaryColor),
                    title: const Text('การแจ้งเตือนเตือนนัดพบ', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text('แจ้งเตือนก่อนเวลานัดหมาย 30 นาที'),
                    value: _pushNotifications,
                    onChanged: (val) => setState(() => _pushNotifications = val),
                  ),
                  const Divider(height: 1, indent: 56),
                  SwitchListTile(
                    activeColor: primaryColor,
                    secondary: const Icon(Icons.mark_email_unread_rounded, color: primaryColor),
                    title: const Text('การแจ้งเตือนทางอีเมล', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text('ส่งอีเมลยืนยันคำขอนัดหมาย'),
                    value: _emailAlerts,
                    onChanged: (val) => setState(() => _emailAlerts = val),
                  ),
                  const Divider(height: 1, indent: 56),
                  SwitchListTile(
                    activeColor: primaryColor,
                    secondary: const Icon(Icons.volume_up_rounded, color: primaryColor),
                    title: const Text('เสียงเตือนการแจ้งเตือน', style: TextStyle(fontWeight: FontWeight.w600)),
                    value: _soundEnabled,
                    onChanged: (val) => setState(() => _soundEnabled = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // General Preferences
            const Text(
              'ทั่วไป & ภาษา',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF718096)),
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 3)),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.language_rounded, color: primaryColor),
                title: const Text('ภาษาของแอปพลิเคชัน', style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: DropdownButton<String>(
                  value: _selectedLanguage,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'ภาษาไทย', child: Text('ภาษาไทย')),
                    DropdownMenuItem(value: 'English', child: Text('English')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedLanguage = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            // About Application Info
            const Text(
              'เกี่ยวกับแอปพลิเคชัน',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF718096)),
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 3)),
                ],
              ),
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.info_outline_rounded, color: primaryColor),
                    title: Text('เวอร์ชันแอปพลิเคชัน', style: TextStyle(fontWeight: FontWeight.w600)),
                    trailing: Text('v1.0.0 (Engineering PBRU)', style: TextStyle(color: Color(0xFF718096), fontWeight: FontWeight.bold)),
                  ),
                  Divider(height: 1, indent: 56),
                  ListTile(
                    leading: Icon(Icons.policy_rounded, color: primaryColor),
                    title: Text('นโยบายความเป็นส่วนตัว', style: TextStyle(fontWeight: FontWeight.w600)),
                    trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFFA0AEC0)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
