dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.3
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'football_pitch_visualizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Scores',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> matches = [];
  Map<String, dynamic> selectedMatch = {};

  @override
  void initState() {
    super.initState();
    fetchMatches();
  }

  Future<void> fetchMatches() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/todays_matches'));
    if (response.statusCode == 200) {
      setState(() {
        matches = json.decode(response.body)['matches'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Scores'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                return ListTile(
                  title: Text('${match['homeTeam']['name']} vs ${match['awayTeam']['name']}'),
                  subtitle: Text('${match['score']['fullTime']['homeTeam']} - ${match['score']['fullTime']['awayTeam']}'),
                  onTap: () {
                    setState(() {
                      selectedMatch = match;
                    });
                  },
                );
              },
            ),
          ),
          if (selectedMatch.isNotEmpty)
            FootballPitchVisualizer(matchData: selectedMatch),
        ],
      ),
    );
  }
}