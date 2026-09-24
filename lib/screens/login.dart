import 'package:flutter/material.dart';

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

              // Middle Illustration
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
                    // TODO: Implement login action
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
                    // TODO: Implement register action
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

// Campus Illustration Widget
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

    // 1. Soft Sky Ambient Glow
    final skyGlow = const RadialGradient(
      center: Alignment.topCenter,
      radius: 1.1,
      colors: [
        Color(0xFFEDEFFC),
        Color(0xFFF9FAFE),
      ],
    ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..shader = skyGlow);

    // Decorative Clouds
    final cloudPaint = Paint()..color = Colors.white.withOpacity(0.7);
    canvas.drawCircle(Offset(w * 0.18, h * 0.18), w * 0.08, cloudPaint);
    canvas.drawCircle(Offset(w * 0.25, h * 0.16), w * 0.1, cloudPaint);
    canvas.drawCircle(Offset(w * 0.78, h * 0.15), w * 0.09, cloudPaint);
    canvas.drawCircle(Offset(w * 0.85, h * 0.17), w * 0.07, cloudPaint);

    // 2. Far Mountains / Hills Layer
    final farHillPaint = Paint()..color = const Color(0xFFD3DCF8);
    final farHill = Path()
      ..moveTo(0, h * 0.55)
      ..cubicTo(w * 0.2, h * 0.42, w * 0.4, h * 0.58, w * 0.6, h * 0.48)
      ..cubicTo(w * 0.8, h * 0.38, w * 0.95, h * 0.52, w, h * 0.48)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(farHill, farHillPaint);

    // 3. Green Trees Background Layer
    final treeDark = Paint()..color = const Color(0xFF81C784);
    final treeLight = Paint()..color = const Color(0xFFA5D6A7);

    // Left Trees
    canvas.drawCircle(Offset(w * 0.12, h * 0.46), w * 0.09, treeDark);
    canvas.drawCircle(Offset(w * 0.18, h * 0.48), w * 0.07, treeLight);

    // Right Trees
    canvas.drawCircle(Offset(w * 0.88, h * 0.45), w * 0.1, treeDark);
    canvas.drawCircle(Offset(w * 0.81, h * 0.47), w * 0.08, treeLight);

    // 4. University Clock Tower & Building (Centerpiece)
    _drawUniversityBuilding(canvas, w, h);

    // 5. Lawn & Campus Ground Layer
    final lawnPaint = Paint()..color = const Color(0xFFC8E6C9);
    final lawnPath = Path()
      ..moveTo(0, h * 0.62)
      ..quadraticBezierTo(w * 0.5, h * 0.55, w, h * 0.62)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(lawnPath, lawnPaint);

    // Path / Courtyard
    final pathPaint = Paint()..color = const Color(0xFFE8ECEF);
    final courtPath = Path()
      ..moveTo(w * 0.2, h)
      ..lineTo(w * 0.38, h * 0.6)
      ..lineTo(w * 0.62, h * 0.6)
      ..lineTo(w * 0.8, h)
      ..close();
    canvas.drawPath(courtPath, pathPaint);

    // 6. Foreground Student Characters (Vector Detailed)
    _drawFemaleStudent(canvas, w, h);
    _drawMaleStudent(canvas, w, h);
  }

  void _drawUniversityBuilding(Canvas canvas, double w, double h) {
    final wallPaint = Paint()..color = const Color(0xFFC0CEF2);
    final wallShadow = Paint()..color = const Color(0xFFA5B7E6);
    final roofPaint = Paint()..color = const Color(0xFF5C6BC0);
    final windowPaint = Paint()..color = Colors.white;
    final archPaint = Paint()..color = const Color(0xFF7E57C2);

    // Main Wings (Left & Right)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.22, h * 0.38, w * 0.56, h * 0.24),
        const Radius.circular(4),
      ),
      wallPaint,
    );

    // Wing Roofs
    final leftRoof = Path()
      ..moveTo(w * 0.20, h * 0.38)
      ..lineTo(w * 0.36, h * 0.32)
      ..lineTo(w * 0.38, h * 0.38)
      ..close();
    canvas.drawPath(leftRoof, roofPaint);

    final rightRoof = Path()
      ..moveTo(w * 0.80, h * 0.38)
      ..lineTo(w * 0.64, h * 0.32)
      ..lineTo(w * 0.62, h * 0.38)
      ..close();
    canvas.drawPath(rightRoof, roofPaint);

    // Central Tower Body
    canvas.drawRect(Rect.fromLTWH(w * 0.41, h * 0.22, w * 0.18, h * 0.4), wallShadow);
    canvas.drawRect(Rect.fromLTWH(w * 0.42, h * 0.22, w * 0.16, h * 0.4), wallPaint);

    // Central Spire / Clock Roof
    final spire = Path()
      ..moveTo(w * 0.40, h * 0.22)
      ..lineTo(w * 0.50, h * 0.10)
      ..lineTo(w * 0.60, h * 0.22)
      ..close();
    canvas.drawPath(spire, roofPaint);

    // Tower Clock
    final clockOuter = Paint()..color = const Color(0xFF3F51B5);
    final clockFace = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(w * 0.50, h * 0.28), w * 0.042, clockOuter);
    canvas.drawCircle(Offset(w * 0.50, h * 0.28), w * 0.035, clockFace);

    // Clock Hands
    final handPaint = Paint()
      ..color = const Color(0xFF212121)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.50, h * 0.28), Offset(w * 0.50, h * 0.26), handPaint);
    canvas.drawLine(Offset(w * 0.50, h * 0.28), Offset(w * 0.515, h * 0.28), handPaint);

    // Tower Arch Entrance
    final archRect = Rect.fromLTWH(w * 0.46, h * 0.50, w * 0.08, h * 0.12);
    final archPath = Path()
      ..addRRect(RRect.fromRectAndCorners(
        archRect,
        topLeft: const Radius.circular(16),
        topRight: const Radius.circular(16),
      ));
    canvas.drawPath(archPath, archPaint);

    // Windows Grid on Wings
    for (int i = 0; i < 3; i++) {
      // Left Wing Windows
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * (0.25 + i * 0.05), h * 0.42, w * 0.03, h * 0.06),
          const Radius.circular(3),
        ),
        windowPaint,
      );
      // Right Wing Windows
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * (0.61 + i * 0.05), h * 0.42, w * 0.03, h * 0.06),
          const Radius.circular(3),
        ),
        windowPaint,
      );
    }
  }

  void _drawFemaleStudent(Canvas canvas, double w, double h) {
    final x = w * 0.26;
    final y = h * 0.38;

    final skin = Paint()..color = const Color(0xFFFFD8C2);
    final hair = Paint()..color = const Color(0xFF262836);
    final shirt = Paint()..color = Colors.white;
    final skirt = Paint()..color = const Color(0xFF2C3258);
    final backpack = Paint()..color = const Color(0xFF4C52D4);
    final tablet = Paint()..color = const Color(0xFF3F51B5);

    // Backpack behind shoulder
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x - w * 0.11, y + h * 0.14, w * 0.08, h * 0.24),
        const Radius.circular(14),
      ),
      backpack,
    );

    // Hair Back
    canvas.drawOval(
      Rect.fromLTWH(x - w * 0.08, y + h * 0.02, w * 0.16, h * 0.22),
      hair,
    );

    // Head Face
    canvas.drawCircle(Offset(x, y + h * 0.08), w * 0.062, skin);

    // Front Hair Bangs
    final bangs = Path()
      ..addOval(Rect.fromLTWH(x - w * 0.065, y + h * 0.02, w * 0.13, h * 0.07));
    canvas.drawPath(bangs, hair);

    // Torso / White Shirt
    final shirtPath = Path()
      ..moveTo(x - w * 0.06, y + h * 0.36)
      ..lineTo(x - w * 0.045, y + h * 0.15)
      ..lineTo(x + w * 0.05, y + h * 0.15)
      ..lineTo(x + w * 0.065, y + h * 0.36)
      ..close();
    canvas.drawPath(shirtPath, shirt);

    // Backpack Strap Left
    final strapPaint = Paint()
      ..color = const Color(0xFF4C52D4)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(x - w * 0.035, y + h * 0.15), Offset(x - w * 0.045, y + h * 0.3), strapPaint);

    // Skirt
    final skirtPath = Path()
      ..moveTo(x - w * 0.06, y + h * 0.36)
      ..lineTo(x + w * 0.065, y + h * 0.36)
      ..lineTo(x + w * 0.075, y + h * 0.52)
      ..lineTo(x - w * 0.07, y + h * 0.52)
      ..close();
    canvas.drawPath(skirtPath, skirt);

    // Arms & Tablet Held in Hands
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x - w * 0.01, y + h * 0.20, w * 0.09, h * 0.13),
        const Radius.circular(6),
      ),
      tablet,
    );
    // Tablet Screen
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + w * 0.002, y + h * 0.21, w * 0.068, h * 0.11),
        const Radius.circular(4),
      ),
      Paint()..color = const Color(0xFFE8EAF6),
    );

    // Hands
    canvas.drawCircle(Offset(x, y + h * 0.26), w * 0.02, skin);
    canvas.drawCircle(Offset(x + w * 0.08, y + h * 0.26), w * 0.02, skin);
  }

  void _drawMaleStudent(Canvas canvas, double w, double h) {
    final x = w * 0.72;
    final y = h * 0.38;

    final skin = Paint()..color = const Color(0xFFFFD8C2);
    final hair = Paint()..color = const Color(0xFF262836);
    final jacket = Paint()..color = const Color(0xFF2C3258);
    final innerShirt = Paint()..color = Colors.white;
    final pants = Paint()..color = const Color(0xFF455A64);
    final phone = Paint()..color = const Color(0xFF1E2238);
    final screen = Paint()..color = const Color(0xFF80DEEA);

    // Head Face
    canvas.drawCircle(Offset(x, y + h * 0.08), w * 0.062, skin);

    // Hair Top
    final hairPath = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(x - w * 0.065, y + h * 0.015, w * 0.13, h * 0.08),
        topLeft: const Radius.circular(10),
        topRight: const Radius.circular(10),
      ));
    canvas.drawPath(hairPath, hair);

    // Hoodie / Jacket Body
    final jacketPath = Path()
      ..moveTo(x - w * 0.07, y + h * 0.36)
      ..lineTo(x - w * 0.05, y + h * 0.15)
      ..lineTo(x + w * 0.06, y + h * 0.15)
      ..lineTo(x + w * 0.075, y + h * 0.36)
      ..close();
    canvas.drawPath(jacketPath, jacket);

    // Inner V-Neck
    final vNeck = Path()
      ..moveTo(x - w * 0.025, y + h * 0.15)
      ..lineTo(x, y + h * 0.24)
      ..lineTo(x + w * 0.025, y + h * 0.15)
      ..close();
    canvas.drawPath(vNeck, innerShirt);

    // Hoodie Drawstrings
    final stringPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(x - w * 0.015, y + h * 0.18), Offset(x - w * 0.015, y + h * 0.27), stringPaint);
    canvas.drawLine(Offset(x + w * 0.015, y + h * 0.18), Offset(x + w * 0.015, y + h * 0.27), stringPaint);

    // Pants
    final pantsRect = Rect.fromLTWH(x - w * 0.06, y + h * 0.36, w * 0.125, h * 0.18);
    canvas.drawRect(pantsRect, pants);

    // Holding Smartphone
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x - w * 0.05, y + h * 0.20, w * 0.045, h * 0.10),
        const Radius.circular(5),
      ),
      phone,
    );
    // Glowing Phone Screen
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x - w * 0.046, y + h * 0.208, w * 0.037, h * 0.084),
        const Radius.circular(3),
      ),
      screen,
    );

    // Hands
    canvas.drawCircle(Offset(x - w * 0.03, y + h * 0.25), w * 0.018, skin);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
