import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://localhost/campusmeet';

  // 1. Fetch appointments from XAMPP MySQL
  static Future<List<dynamic>> fetchAppointments() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_appointments.php'));
      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(response.body);
        if (jsonResult['success'] == true) {
          return jsonResult['data'] ?? [];
        }
      }
      return [];
    } catch (e) {
      print('Error fetching appointments: $e');
      return [];
    }
  }

  // 2. Create appointment in XAMPP MySQL
  static Future<bool> createAppointment(Map<String, dynamic> appointmentData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/create_appointment.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(appointmentData),
      );
      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(response.body);
        return jsonResult['success'] == true;
      }
      return false;
    } catch (e) {
      print('Error creating appointment: $e');
      return false;
    }
  }

  // 3. Update appointment status in XAMPP MySQL (CONFIRMED / CANCELLED)
  static Future<bool> updateAppointmentStatus(String appointmentId, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_status.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'appointment_id': appointmentId,
          'status': status,
        }),
      );
      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(response.body);
        return jsonResult['success'] == true;
      }
      return false;
    } catch (e) {
      print('Error updating status: $e');
      return false;
    }
  }

  // Local Storage helper
  static Future<void> saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
