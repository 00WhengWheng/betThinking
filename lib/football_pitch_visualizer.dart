import 'package:flutter/material.dart';

class FootballPitchVisualizer extends StatelessWidget {
  final Map<String, dynamic> matchData;

  const FootballPitchVisualizer({Key? key, required this.matchData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.green[800],
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: CustomPaint(
        painter: PitchPainter(),
        child: Stack(
          children: [
            // Home Team
            Positioned(
              left: 10,
              top: 10,
              child: Text(
                matchData['homeTeam']['name'],
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // Away Team
            Positioned(
              right: 10,
              top: 10,
              child: Text(
                matchData['awayTeam']['name'],
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // Referee
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                'Referee: ${matchData['referee']}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Stadium
            Positioned(
              bottom: 10,
              right: 10,
              child: Text(
                'Stadium: ${matchData['stadium']}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Add more Positioned widgets for players, coaches, etc.
          ],
        ),
      ),
    );
  }
}

class PitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Center line
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );

    // Center circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height / 5,
      paint,
    );

    // Penalty areas
    final penaltyAreaWidth = size.width / 5;
    final penaltyAreaHeight = size.height / 2.5;
    canvas.drawRect(
      Rect.fromLTWH(0, (size.height - penaltyAreaHeight) / 2, penaltyAreaWidth, penaltyAreaHeight),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width - penaltyAreaWidth, (size.height - penaltyAreaHeight) / 2, penaltyAreaWidth, penaltyAreaHeight),
      paint,
    );

    // Goal areas
    final goalAreaWidth = size.width / 10;
    final goalAreaHeight = size.height / 4;
    canvas.drawRect(
      Rect.fromLTWH(0, (size.height - goalAreaHeight) / 2, goalAreaWidth, goalAreaHeight),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width - goalAreaWidth, (size.height - goalAreaHeight) / 2, goalAreaWidth, goalAreaHeight),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}