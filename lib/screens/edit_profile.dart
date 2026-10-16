import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:may/models/user_data.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _studentIdController;
  late TextEditingController _emailController;
  late String _selectedMajor;

  Uint8List? _selectedImageBytes;
  final ImagePicker _picker = ImagePicker();

  final List<String> _engineeringMajors = [
    'สาขาวิชาวิศวกรรมเครื่องกล',
    'สาขาวิชาวิศวกรรมพลังงาน',
    'สาขาวิชาวิศวกรรมสารสนเทศและการสื่อสาร',
    'สาขาวิชาวิศวกรรมไฟฟ้า',
    'สาขาวิชาวิศวกรรมอุตสาหการ',
    'สาขาวิชาสถาปัตยกรรมภายใน',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: UserData.name);
    _studentIdController = TextEditingController(text: UserData.studentId);
    _emailController = TextEditingController(text: UserData.email);
    _selectedMajor = _engineeringMajors.contains(UserData.major) ? UserData.major : _engineeringMajors.first;
    _selectedImageBytes = UserData.profileImageBytes;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _selectedImageBytes = bytes;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่สามารถโหลดรูปภาพได้: $e')),
        );
      }
    }
  }

  void _showImagePickerModal() {
    const primaryColor = Color(0xFF4C52D4);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'เลือกรูปภาพโปรไฟล์',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xFF1A202C)),
                ),
                const SizedBox(height: 16.0),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE0E7FF),
                    child: Icon(Icons.photo_library_rounded, color: primaryColor),
                  ),
                  title: const Text('เลือกรูปจากคลังภาพ (Gallery)', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('เลือกไฟล์รูปภาพจากอุปกรณ์'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE0E7FF),
                    child: Icon(Icons.camera_alt_rounded, color: primaryColor),
                  ),
                  title: const Text('ถ่ายภาพด้วยกล้อง (Camera)', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('ถ่ายรูปภาพใหม่ด้วยกล้อง'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        UserData.name = _nameController.text.trim();
        UserData.studentId = _studentIdController.text.trim();
        UserData.email = _emailController.text.trim();
        UserData.major = _selectedMajor;
        UserData.profileImageBytes = _selectedImageBytes;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('บันทึกข้อมูลส่วนตัวเรียบร้อยแล้ว')),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text(
          'แก้ไขข้อมูลส่วนตัว',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Avatar Edit with Image Picker
                GestureDetector(
                  onTap: _showImagePickerModal,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 54,
                        backgroundColor: primaryColor.withOpacity(0.12),
                        backgroundImage: _selectedImageBytes != null
                            ? MemoryImage(_selectedImageBytes!)
                            : null,
                        child: _selectedImageBytes == null
                            ? const Icon(Icons.person_rounded, color: primaryColor, size: 64)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: _showImagePickerModal,
                  child: const Text(
                    'เปลี่ยนรูปโปรไฟล์',
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 14.0),
                  ),
                ),
                const SizedBox(height: 28.0),

                // Name Field
                _buildFieldLabel('ชื่อ-นามสกุล'),
                TextFormField(
                  controller: _nameController,
                  decoration: _buildInputDecoration(Icons.badge_outlined, 'กรอกชื่อ-นามสกุล'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'กรุณากรอกชื่อ-นามสกุล' : null,
                ),
                const SizedBox(height: 18.0),

                // Student ID Field
                _buildFieldLabel('รหัสนักศึกษา'),
                TextFormField(
                  controller: _studentIdController,
                  decoration: _buildInputDecoration(Icons.card_membership_outlined, 'กรอกรหัสนักศึกษา'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'กรุณากรอกรหัสนักศึกษา' : null,
                ),
                const SizedBox(height: 18.0),

                // Email Field
                _buildFieldLabel('อีเมลมหาวิทยาลัย'),
                TextFormField(
                  controller: _emailController,
                  decoration: _buildInputDecoration(Icons.email_outlined, 'กรอกอีเมลมหาวิทยาลัย'),
                  validator: (v) => (v == null || !v.contains('@')) ? 'กรุณากรอกอีเมลให้ถูกต้อง' : null,
                ),
                const SizedBox(height: 18.0),

                // Major Dropdown
                _buildFieldLabel('สาขาวิชา'),
                DropdownButtonFormField<String>(
                  initialValue: _selectedMajor,
                  isExpanded: true,
                  decoration: _buildInputDecoration(Icons.school_outlined, ''),
                  items: _engineeringMajors
                      .map((m) => DropdownMenuItem(value: m, child: Text(m, style: const TextStyle(fontSize: 14.0), overflow: TextOverflow.ellipsis)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedMajor = val);
                  },
                ),
                const SizedBox(height: 32.0),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 52.0,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    ),
                    child: const Text('บันทึกการเปลี่ยนแปลง', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          label,
          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(IconData icon, String hint) {
    const primaryColor = Color(0xFF4C52D4);

    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: primaryColor),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14.0), borderSide: const BorderSide(color: primaryColor, width: 1.8)),
    );
  }
}
