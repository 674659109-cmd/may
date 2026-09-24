import 'package:flutter/material.dart';
import 'package:may/screens/login_form.dart';
import 'package:may/screens/register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4C52D4);
    const subtitleColor = Color(0xFF6C727F);
    const footerColor = Color(0xFF5B61C8);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12.0),
              
              // Logo Icon
              const _LogoIcon(color: primaryColor),
              const SizedBox(height: 12.0),

              // Title
              const Text(
                'CampusMeet',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8.0),

              // Subtitle
              const Text(
                'นัดง่าย รู้สถานะ ไม่เสียเวลา\nในมหาวิทยาลัย',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: subtitleColor,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                ),
              ),

              // Middle Illustration (Architectural & Nature, No People)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: _CampusIllustration(),
                  ),
                ),
              ),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 52.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginFormScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 52.0,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2D3748),
                    side: const BorderSide(
                      color: Color(0xFFC3C7F4),
                      width: 1.5,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Text(
                    'สมัครสมาชิก',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),

              // Footer Text
              const Text(
                'มหาวิทยาลัยราชภัฏเพชรบุรี',
                style: TextStyle(
                  fontSize: 15.0,
                  color: footerColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Logo Widget representing Graduation Cap + Speech Bubble
class _LogoIcon extends StatelessWidget {
  final Color color;

  const _LogoIcon({required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 72,
      child: CustomPaint(
        painter: _LogoPainter(color: color),
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  final Color color;

  _LogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw Speech Bubble Base
    final bubblePath = Path();
    final rect = Rect.fromLTWH(size.width * 0.15, size.height * 0.25, size.width * 0.7, size.height * 0.65);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(18));
    bubblePath.addRRect(rrect);

    // Tail of speech bubble (bottom left)
    final tailPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.82)
      ..lineTo(size.width * 0.15, size.height * 0.95)
      ..lineTo(size.width * 0.38, size.height * 0.88)
      ..close();

    canvas.drawPath(bubblePath, paint);
    canvas.drawPath(tailPath, paint);

    // Graduation Cap Top (Diamond)
    final capPath = Path()
      ..moveTo(size.width * 0.5, size.height * 0.05)
      ..lineTo(size.width * 0.95, size.height * 0.28)
      ..lineTo(size.width * 0.5, size.height * 0.48)
      ..lineTo(size.width * 0.05, size.height * 0.28)
      ..close();

    canvas.drawPath(capPath, paint);

    // Graduation Cap Skull Cap
    final skullPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.35)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.55, size.width * 0.75, size.height * 0.35)
      ..lineTo(size.width * 0.75, size.height * 0.48)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.68, size.width * 0.25, size.height * 0.48)
      ..close();

    canvas.drawPath(skullPath, paint);

    // Cap Tassel
    final tasselPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final tasselPath = Path()
      ..moveTo(size.width * 0.85, size.height * 0.32)
      ..quadraticBezierTo(size.width * 0.88, size.height * 0.48, size.width * 0.82, size.height * 0.62);

    canvas.drawPath(tasselPath, tasselPaint);

    // Tassel Dot
    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.64), 3.5, paint);

    // Eyes inside the speech bubble
    canvas.drawCircle(Offset(size.width * 0.42, size.height * 0.58), 4.0, whitePaint);
    canvas.drawCircle(Offset(size.width * 0.58, size.height * 0.58), 4.0, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Campus Illustration Widget (Architectural & Nature Landscape, No People)
class _CampusIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        return SizedBox(
          width: width,
          height: height,
          child: CustomPaint(
            painter: _IllustrationPainter(),
          ),
        );
      },
    );
  }
}

class _IllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Sky & Sun Glow Background
    final skyGlow = const RadialGradient(
      center: Alignment(0.0, -0.2),
      radius: 1.0,
      colors: [
        Color(0xFFEEF2FF),
        Color(0xFFF9FAFE),
      ],
    ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..shader = skyGlow);

    // Sun / Soft Backdrop Circle
    final sunGlow = Paint()
      ..color = const Color(0xFFE0E7FF).withOpacity(0.6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.5, h * 0.35), w * 0.38, sunGlow);

    // Decorative Clouds
    final cloudPaint = Paint()..color = Colors.white.withOpacity(0.85);
    _drawCloud(canvas, cloudPaint, Offset(w * 0.15, h * 0.18), w * 0.12);
    _drawCloud(canvas, cloudPaint, Offset(w * 0.80, h * 0.15), w * 0.14);

    // Birds in the sky
    final birdPaint = Paint()
      ..color = const Color(0xFF818CF8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    _drawBird(canvas, birdPaint, Offset(w * 0.28, h * 0.12), 10);
    _drawBird(canvas, birdPaint, Offset(w * 0.34, h * 0.09), 8);

    // 2. Far Background Mountains
    final mountainPaint = Paint()..color = const Color(0xFFD4DCF7);
    final mPath = Path()
      ..moveTo(0, h * 0.6)
      ..cubicTo(w * 0.25, h * 0.45, w * 0.4, h * 0.55, w * 0.6, h * 0.46)
      ..cubicTo(w * 0.75, h * 0.38, w * 0.9, h * 0.5, w, h * 0.45)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(mPath, mountainPaint);

    // 3. Middle Ground Green Hills & Trees
    final hillDark = Paint()..color = const Color(0xFF91D796);
    final hillLight = Paint()..color = const Color(0xFFAFE2B3);

    // Left Hill
    final leftHill = Path()
      ..moveTo(0, h * 0.62)
      ..quadraticBezierTo(w * 0.25, h * 0.52, w * 0.5, h * 0.62)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(leftHill, hillLight);

    // Right Hill
    final rightHill = Path()
      ..moveTo(w * 0.5, h * 0.62)
      ..quadraticBezierTo(w * 0.75, h * 0.52, w, h * 0.60)
      ..lineTo(w, h)
      ..lineTo(w * 0.5, h)
      ..close();
    canvas.drawPath(rightHill, hillDark);

    // Background Pine/Round Trees
    _drawTree(canvas, Offset(w * 0.12, h * 0.5), w * 0.09, const Color(0xFF4CAF50));
    _drawTree(canvas, Offset(w * 0.20, h * 0.52), w * 0.07, const Color(0xFF66BB6A));
    _drawTree(canvas, Offset(w * 0.80, h * 0.51), w * 0.08, const Color(0xFF4CAF50));
    _drawTree(canvas, Offset(w * 0.88, h * 0.49), w * 0.095, const Color(0xFF388E3C));

    // 4. Grand Campus Main Building (Architecture)
    _drawCampusBuilding(canvas, w, h);

    // 5. Foreground Courtyard, Path & Gardens
    final courtPaint = Paint()..color = const Color(0xFFC8E6C9);
    final courtPath = Path()
      ..moveTo(0, h * 0.68)
      ..quadraticBezierTo(w * 0.5, h * 0.63, w, h * 0.68)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(courtPath, courtPaint);

    // Central Winding Walkway / Paved Path
    final pathPaint = Paint()..color = const Color(0xFFE4E8FA);
    final walkway = Path()
      ..moveTo(w * 0.35, h)
      ..quadraticBezierTo(w * 0.42, h * 0.75, w * 0.44, h * 0.66)
      ..lineTo(w * 0.56, h * 0.66)
      ..quadraticBezierTo(w * 0.58, h * 0.75, w * 0.65, h)
      ..close();
    canvas.drawPath(walkway, pathPaint);

    // Courtyard Stairs in front of Building
    final stairPaint = Paint()..color = const Color(0xFFD0D7F7);
    for (int i = 0; i < 3; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * (0.42 - i * 0.015), h * (0.64 + i * 0.008), w * (0.16 + i * 0.03), h * 0.008),
          const Radius.circular(2),
        ),
        stairPaint,
      );
    }

    // Street Lamps along the path
    _drawStreetLamp(canvas, Offset(w * 0.38, h * 0.75), w, h);
    _drawStreetLamp(canvas, Offset(w * 0.62, h * 0.75), w, h);

    // Flower Bushes in Foreground
    _drawFlowerBush(canvas, Offset(w * 0.15, h * 0.82), w * 0.08, const Color(0xFF81C784), const Color(0xFFEC407A));
    _drawFlowerBush(canvas, Offset(w * 0.85, h * 0.82), w * 0.08, const Color(0xFF81C784), const Color(0xFFAB47BC));

    // 6. Subtle Floating Meeting / Status Badges (CampusMeet Theme)
    _drawFloatingBadge(
      canvas,
      Offset(w * 0.22, h * 0.30),
      Icons.calendar_today_rounded,
      const Color(0xFF4C52D4),
    );
    _drawFloatingBadge(
      canvas,
      Offset(w * 0.78, h * 0.28),
      Icons.chat_bubble_rounded,
      const Color(0xFF3B82F6),
    );
  }

  void _drawCloud(Canvas canvas, Paint paint, Offset center, double radius) {
    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(Offset(center.dx - radius * 0.6, center.dy + radius * 0.2), radius * 0.7, paint);
    canvas.drawCircle(Offset(center.dx + radius * 0.6, center.dy + radius * 0.2), radius * 0.7, paint);
  }

  void _drawBird(Canvas canvas, Paint paint, Offset center, double size) {
    final path = Path()
      ..moveTo(center.dx - size, center.dy)
      ..quadraticBezierTo(center.dx - size * 0.5, center.dy - size * 0.6, center.dx, center.dy)
      ..quadraticBezierTo(center.dx + size * 0.5, center.dy - size * 0.6, center.dx + size, center.dy);
    canvas.drawPath(path, paint);
  }

  void _drawTree(Canvas canvas, Offset center, double radius, Color leafColor) {
    // Trunk
    final trunkPaint = Paint()..color = const Color(0xFF795548);
    canvas.drawRect(
      Rect.fromLTWH(center.dx - radius * 0.15, center.dy, radius * 0.3, radius * 1.2),
      trunkPaint,
    );
    // Foliage
    final leafPaint = Paint()..color = leafColor;
    canvas.drawCircle(center, radius, leafPaint);
    canvas.drawCircle(Offset(center.dx - radius * 0.3, center.dy - radius * 0.2), radius * 0.7, leafPaint);
    canvas.drawCircle(Offset(center.dx + radius * 0.3, center.dy - radius * 0.2), radius * 0.7, leafPaint);
  }

  void _drawCampusBuilding(Canvas canvas, double w, double h) {
    final baseWall = Paint()..color = const Color(0xFFC3D0F5);
    final mainWall = Paint()..color = const Color(0xFFD6E0FB);
    final roofColor = Paint()..color = const Color(0xFF4C52D4);
    final darkRoof = Paint()..color = const Color(0xFF3B40A4);
    final columnPaint = Paint()..color = Colors.white;
    final windowPaint = Paint()..color = const Color(0xFFE8EEFF);
    final doorPaint = Paint()..color = const Color(0xFF3B40A4);

    // Left & Right Building Wings
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.18, h * 0.38, w * 0.64, h * 0.26),
        const Radius.circular(6),
      ),
      baseWall,
    );

    // Wing Roofs (Gable Roof)
    final leftGable = Path()
      ..moveTo(w * 0.16, h * 0.38)
      ..lineTo(w * 0.32, h * 0.30)
      ..lineTo(w * 0.35, h * 0.38)
      ..close();
    canvas.drawPath(leftGable, roofColor);

    final rightGable = Path()
      ..moveTo(w * 0.84, h * 0.38)
      ..lineTo(w * 0.68, h * 0.30)
      ..lineTo(w * 0.65, h * 0.38)
      ..close();
    canvas.drawPath(rightGable, roofColor);

    // Windows Grid on Wings
    for (int i = 0; i < 4; i++) {
      // Left Wing Windows
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * (0.21 + i * 0.045), h * 0.42, w * 0.03, h * 0.07),
          const Radius.circular(3),
        ),
        windowPaint,
      );
      // Right Wing Windows
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * (0.61 + i * 0.045), h * 0.42, w * 0.03, h * 0.07),
          const Radius.circular(3),
        ),
        windowPaint,
      );
    }

    // Main Central Hall Body
    canvas.drawRect(Rect.fromLTWH(w * 0.38, h * 0.26, w * 0.24, h * 0.38), mainWall);

    // Clock Tower Spire Top
    final spireRoof = Path()
      ..moveTo(w * 0.36, h * 0.26)
      ..lineTo(w * 0.50, h * 0.11)
      ..lineTo(w * 0.64, h * 0.26)
      ..close();
    canvas.drawPath(spireRoof, darkRoof);

    // Flagpole on Top
    final flagPolePaint = Paint()
      ..color = const Color(0xFF9FA8DA)
      ..strokeWidth = 2.0;
    canvas.drawLine(Offset(w * 0.5, h * 0.11), Offset(w * 0.5, h * 0.05), flagPolePaint);

    final flagPath = Path()
      ..moveTo(w * 0.5, h * 0.05)
      ..lineTo(w * 0.56, h * 0.07)
      ..lineTo(w * 0.5, h * 0.09)
      ..close();
    canvas.drawPath(flagPath, Paint()..color = const Color(0xFFEF5350));

    // Clock Face Center
    canvas.drawCircle(Offset(w * 0.5, h * 0.33), w * 0.05, darkRoof);
    canvas.drawCircle(Offset(w * 0.5, h * 0.33), w * 0.04, columnPaint);

    // Clock Hands
    final clockHand = Paint()
      ..color = const Color(0xFF1A237E)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.5, h * 0.33), Offset(w * 0.5, h * 0.305), clockHand);
    canvas.drawLine(Offset(w * 0.5, h * 0.33), Offset(w * 0.518, h * 0.33), clockHand);

    // Classic Greek Columns at Grand Entrance
    for (int i = 0; i < 4; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * (0.41 + i * 0.05), h * 0.44, w * 0.025, h * 0.18),
          const Radius.circular(2),
        ),
        columnPaint,
      );
    }

    // Grand Entrance Door
    final doorRect = Rect.fromLTWH(w * 0.465, h * 0.52, w * 0.07, h * 0.10);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        doorRect,
        topLeft: const Radius.circular(12),
        topRight: const Radius.circular(12),
      ),
      doorPaint,
    );
  }

  void _drawStreetLamp(Canvas canvas, Offset pos, double w, double h) {
    final polePaint = Paint()
      ..color = const Color(0xFF5C6BC0)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final glowPaint = Paint()
      ..color = const Color(0xFFFFF59D).withOpacity(0.8);

    // Pole
    canvas.drawLine(pos, Offset(pos.dx, pos.dy - h * 0.08), polePaint);
    // Lamp Light Bulb
    canvas.drawCircle(Offset(pos.dx, pos.dy - h * 0.085), w * 0.02, glowPaint);
  }

  void _drawFlowerBush(Canvas canvas, Offset pos, double radius, Color bushColor, Color flowerColor) {
    final bushPaint = Paint()..color = bushColor;
    final flowerPaint = Paint()..color = flowerColor;

    canvas.drawCircle(pos, radius, bushPaint);
    canvas.drawCircle(Offset(pos.dx - radius * 0.4, pos.dy - radius * 0.2), radius * 0.3, flowerPaint);
    canvas.drawCircle(Offset(pos.dx + radius * 0.4, pos.dy - radius * 0.2), radius * 0.3, flowerPaint);
    canvas.drawCircle(Offset(pos.dx, pos.dy - radius * 0.5), radius * 0.25, flowerPaint);
  }

  void _drawFloatingBadge(Canvas canvas, Offset center, IconData icon, Color color) {
    // Outer Soft Shadow / Glow
    final shadowPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(center, 22, shadowPaint);

    // White Badge Background
    final bgPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, 20, bgPaint);

    // Border
    final borderPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, 20, borderPaint);

    // Icon rendering inside badge
    final TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: 20.0,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
        color: color,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
