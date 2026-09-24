import 'package:flutter/material.dart';
import 'package:may/screens/login_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedFaculty = 'คณะเทคโนโลยีสารสนเทศ';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final List<String> _pbruFaculties = [
    'คณะเทคโนโลยีสารสนเทศ',
    'คณะวิทยาการจัดการ',
    'คณะครุศาสตร์',
    'คณะมนุษยศาสตร์และสังคมศาสตร์',
    'คณะวิทยาศาสตร์และเทคโนโลยี',
    'คณะเทคโนโลยีการเกษตร',
    'คณะพยาบาลศาสตร์และวิทยาศาสตร์สุขภาพ',
    'คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          title: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Color(0xFF4C52D4), size: 28),
              SizedBox(width: 8),
              Text('ลงทะเบียนสำเร็จ'),
            ],
          ),
          content: Text('สังกัด: $_selectedFaculty\nบัญชีผู้ใช้ของคุณถูกสร้างเรียบร้อยแล้ว กรุณาเข้าสู่ระบบ'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginFormScreen()),
                );
              },
              child: const Text('ตกลง', style: TextStyle(color: Color(0xFF4C52D4), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    bool isConfirmPassword = false,
    String? Function(String?)? validator,
  }) {
    const primaryColor = Color(0xFF4C52D4);
    final isObscured = isConfirmPassword ? _obscureConfirmPassword : _obscurePassword;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? isObscured : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFA0AEC0), fontSize: 14.0),
            prefixIcon: Icon(icon, color: primaryColor),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: const Color(0xFF718096),
                    ),
                    onPressed: () {
                      setState(() {
                        if (isConfirmPassword) {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        } else {
                          _obscurePassword = !_obscurePassword;
                        }
                      });
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: const BorderSide(color: primaryColor, width: 1.8),
            ),
          ),
          validator: validator,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2D3748)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4.0),
                const Text(
                  'สมัครสมาชิก 📝',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'สร้างบัญชีใหม่สำหรับนักศึกษาและบุคลากร มรภ.เพชรบุรี',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Color(0xFF6C727F),
                  ),
                ),
                const SizedBox(height: 28.0),

                _buildTextField(
                  label: 'ชื่อ-นามสกุล',
                  hint: 'นายสมชาย ใจดี',
                  icon: Icons.badge_outlined,
                  controller: _nameController,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'กรุณากรอกชื่อ-นามสกุล' : null,
                ),

                _buildTextField(
                  label: 'รหัสนักศึกษา / รหัสบุคลากร',
                  hint: '65xxxxxxxx',
                  icon: Icons.card_membership_outlined,
                  controller: _studentIdController,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'กรุณากรอกรหัสนักศึกษา' : null,
                ),

                _buildTextField(
                  label: 'อีเมลมหาวิทยาลัย',
                  hint: 'student@pbru.ac.th',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (v) => (v == null || !v.contains('@')) ? 'กรุณากรอกอีเมลให้ถูกต้อง' : null,
                ),

                // Faculty Dropdown Selector
                const Text(
                  'คณะ / หน่วยงานสังกัด',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _selectedFaculty,
                  isExpanded: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.school_outlined, color: primaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide: const BorderSide(color: primaryColor, width: 1.8),
                    ),
                  ),
                  items: _pbruFaculties
                      .map((fac) => DropdownMenuItem(
                            value: fac,
                            child: Text(
                              fac,
                              style: const TextStyle(fontSize: 14.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedFaculty = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16.0),

                _buildTextField(
                  label: 'รหัสผ่าน',
                  hint: 'กำหนดรหัสผ่านอย่างน้อย 6 ตัวอักษร',
                  icon: Icons.lock_outline_rounded,
                  controller: _passwordController,
                  isPassword: true,
                  validator: (v) => (v == null || v.length < 6) ? 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร' : null,
                ),

                _buildTextField(
                  label: 'ยืนยันรหัสผ่าน',
                  hint: 'กรอกรหัสผ่านอีกครั้ง',
                  icon: Icons.lock_clock_outlined,
                  controller: _confirmPasswordController,
                  isPassword: true,
                  isConfirmPassword: true,
                  validator: (v) {
                    if (v != _passwordController.text) {
                      return 'รหัสผ่านไม่ตรงกัน';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12.0),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 52.0,
                  child: ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: const Text(
                      'ยืนยันลงทะเบียน',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28.0),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'มีบัญชีผู้ใช้อยู่แล้ว? ',
                      style: TextStyle(color: Color(0xFF718096), fontSize: 15.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginFormScreen()),
                        );
                      },
                      child: const Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
