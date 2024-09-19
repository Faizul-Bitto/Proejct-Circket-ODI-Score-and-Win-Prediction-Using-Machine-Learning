// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CrickPred',
//       theme: ThemeData(
//         primarySwatch: Colors.lightBlue,
//       ),
//       home: PredictionPage(),
//     );
//   }
// }

// class PredictionPage extends StatefulWidget {
//   @override
//   _PredictionPageState createState() => _PredictionPageState();
// }

// class _PredictionPageState extends State<PredictionPage> {
//   String? _selectedBattingTeam;
//   String? _selectedBowlingTeam;
//   String? _selectedTossWinner;
//   String? _selectedTossDecision;
//   String? _selectedVenue;
//   String? _selectedCity;

//   List<String> _teams = [];
//   List<String> _cities = [];
//   List<String> _venues = [];
//   List<String> _tossDecisions = [];

//   final TextEditingController _currentScoreController = TextEditingController();
//   final TextEditingController _oversController = TextEditingController();
//   final TextEditingController _wicketsController = TextEditingController();
//   final TextEditingController _lastFiveController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchDropdownOptions();
//   }

//   Future<void> fetchDropdownOptions() async {
//     try {
//       final teamsResponse =
//           await http.get(Uri.parse('http://127.0.0.1:5000/teams'));
//       final citiesResponse =
//           await http.get(Uri.parse('http://127.0.0.1:5000/cities'));
//       final venuesResponse =
//           await http.get(Uri.parse('http://127.0.0.1:5000/venues'));
//       final tossDecisionsResponse =
//           await http.get(Uri.parse('http://127.0.0.1:5000/toss_decisions'));

//       if (teamsResponse.statusCode == 200 &&
//           citiesResponse.statusCode == 200 &&
//           venuesResponse.statusCode == 200 &&
//           tossDecisionsResponse.statusCode == 200) {
//         setState(() {
//           _teams = List<String>.from(jsonDecode(teamsResponse.body));
//           _cities = List<String>.from(jsonDecode(citiesResponse.body));
//           _venues = List<String>.from(jsonDecode(venuesResponse.body));
//           _tossDecisions =
//               List<String>.from(jsonDecode(tossDecisionsResponse.body));
//         });
//       } else {
//         throw Exception('Failed to load dropdown options');
//       }
//     } catch (error) {
//       print('Error fetching dropdown options: $error');
//     }
//   }

//   Future<Map<String, dynamic>> predictScore(Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse('http://127.0.0.1:5000/predict'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(data),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CricPred'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             DropdownButtonFormField<String>(
//               value: _selectedBattingTeam,
//               hint: Text('Select Batting Team'),
//               items: _teams.map((team) {
//                 return DropdownMenuItem(
//                   value: team,
//                   child: Text(team),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedBattingTeam = value;
//                 });
//               },
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedBowlingTeam,
//               hint: Text('Select Bowling Team'),
//               items: _teams.map((team) {
//                 return DropdownMenuItem(
//                   value: team,
//                   child: Text(team),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedBowlingTeam = value;
//                 });
//               },
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedTossWinner,
//               hint: Text('Select Toss Winner'),
//               items: _teams.map((team) {
//                 return DropdownMenuItem(
//                   value: team,
//                   child: Text(team),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedTossWinner = value;
//                 });
//               },
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedTossDecision,
//               hint: Text('Select Toss Decision'),
//               items: _tossDecisions.map((decision) {
//                 return DropdownMenuItem(
//                   value: decision,
//                   child: Text(decision),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedTossDecision = value;
//                 });
//               },
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedVenue,
//               hint: Text('Select Venue'),
//               items: _venues.map((venue) {
//                 return DropdownMenuItem(
//                   value: venue,
//                   child: Text(venue),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedVenue = value;
//                 });
//               },
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedCity,
//               hint: Text('Select City'),
//               items: _cities.map((city) {
//                 return DropdownMenuItem(
//                   value: city,
//                   child: Text(city),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCity = value;
//                 });
//               },
//             ),
//             TextField(
//               controller: _currentScoreController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Current Score'),
//             ),
//             TextField(
//               controller: _oversController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Overs'),
//             ),
//             TextField(
//               controller: _wicketsController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Wickets'),
//             ),
//             TextField(
//               controller: _lastFiveController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Last Five Overs Score'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_selectedBattingTeam != null &&
//                     _selectedBowlingTeam != null &&
//                     _selectedTossWinner != null &&
//                     _selectedTossDecision != null &&
//                     _selectedVenue != null &&
//                     _selectedCity != null &&
//                     _currentScoreController.text.isNotEmpty &&
//                     _oversController.text.isNotEmpty &&
//                     _wicketsController.text.isNotEmpty &&
//                     _lastFiveController.text.isNotEmpty) {
//                   Map<String, dynamic> inputData = {
//                     "batting_team": _selectedBattingTeam,
//                     "bowling_team": _selectedBowlingTeam,
//                     "toss_winner": _selectedTossWinner,
//                     "toss_decision": _selectedTossDecision,
//                     "venue": _selectedVenue,
//                     "city": _selectedCity,
//                     "current_score": _currentScoreController.text,
//                     "overs": _oversController.text,
//                     "wickets": _wicketsController.text,
//                     "last_five": _lastFiveController.text,
//                   };

//                   try {
//                     Map<String, dynamic> result = await predictScore(inputData);
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: Text('Predicted Score'),
//                           content: Text(
//                               'Predicted Score: ${result['predicted_score']}'),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text('OK'),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   } catch (e) {
//                     print('Error predicting score: $e');
//                   }
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text('Error'),
//                         content: Text('Please fill all the fields'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               child: Text('Predict Score'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }








// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CrickPred',
//       theme: ThemeData(
//         primarySwatch: Colors.lightBlue,
//       ),
//       home: WelcomePage(),
//     );
//   }
// }

// class WelcomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Welcome to CrickPred'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/c.jpg'),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => PredictionPage()),
//                 );
//               },
//               child: Text('Predict Score'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PredictionPage extends StatefulWidget {
//   @override
//   _PredictionPageState createState() => _PredictionPageState();
// }

// class _PredictionPageState extends State<PredictionPage> {
//   String? _selectedBattingTeam;
//   String? _selectedBowlingTeam;
//   String? _selectedTossWinner;
//   String? _selectedTossDecision;
//   String? _selectedVenue;
//   String? _selectedCity;

//   List<String> _teams = [];
//   List<String> _cities = [];
//   List<String> _venues = [];
//   List<String> _tossDecisions = [];

//   final TextEditingController _currentScoreController = TextEditingController();
//   final TextEditingController _oversController = TextEditingController();
//   final TextEditingController _wicketsController = TextEditingController();
//   final TextEditingController _lastFiveController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchDropdownOptions();
//   }

//   Future<void> fetchDropdownOptions() async {
//     try {
//       final teamsResponse =
//           await http.get(Uri.parse('http://127.0.0.1:5000/teams'));
//       final citiesResponse =
//           await http.get(Uri.parse('http://127.0.0.1:5000/cities'));
//       final venuesResponse =
//           await http.get(Uri.parse('http://127.0.0.1:5000/venues'));
//       final tossDecisionsResponse =
//           await http.get(Uri.parse('http://127.0.0.1:5000/toss_decisions'));

//       if (teamsResponse.statusCode == 200 &&
//           citiesResponse.statusCode == 200 &&
//           venuesResponse.statusCode == 200 &&
//           tossDecisionsResponse.statusCode == 200) {
//         setState(() {
//           _teams = List<String>.from(jsonDecode(teamsResponse.body));
//           _cities = List<String>.from(jsonDecode(citiesResponse.body));
//           _venues = List<String>.from(jsonDecode(venuesResponse.body));
//           _tossDecisions =
//               List<String>.from(jsonDecode(tossDecisionsResponse.body));
//         });
//       } else {
//         throw Exception('Failed to load dropdown options');
//       }
//     } catch (error) {
//       print('Error fetching dropdown options: $error');
//     }
//   }

//   Future<Map<String, dynamic>> predictScore(Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse('http://127.0.0.1:5000/predict'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(data),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CrickPred'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             DropdownButtonFormField<String>(
//               value: _selectedBattingTeam,
//               hint: Text('Select Batting Team'),
//               items: _teams.map((team) {
//                 return DropdownMenuItem(
//                   value: team,
//                   child: Text(team),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedBattingTeam = value;
//                 });
//               },
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedBowlingTeam,
//               hint: Text('Select Bowling Team'),
//               items: _teams.map((team) {
//                 return DropdownMenuItem(
//                   value: team,
//                   child: Text(team),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedBowlingTeam = value;
//                 });
//               },
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedTossWinner,
//               hint: Text('Select Toss Winner'),
//               items: _teams.map((team) {
//                 return DropdownMenuItem(
//                   value: team,
//                   child: Text(team),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedTossWinner = value;
//                 });
//               },
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedTossDecision,
//               hint: Text('Select Toss Decision'),
//               items: _tossDecisions.map((decision) {
//                 return DropdownMenuItem(
//                   value: decision,
//                   child: Text(decision),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedTossDecision = value;
//                 });
//               },
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedVenue,
//               hint: Text('Select Venue'),
//               items: _venues.map((venue) {
//                 return DropdownMenuItem(
//                   value: venue,
//                   child: Text(venue),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedVenue = value;
//                 });
//               },
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedCity,
//               hint: Text('Select City'),
//               items: _cities.map((city) {
//                 return DropdownMenuItem(
//                   value: city,
//                   child: Text(city),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCity = value;
//                 });
//               },
//             ),
//             TextField(
//               controller: _currentScoreController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Current Score'),
//             ),
//             TextField(
//               controller: _oversController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Overs'),
//             ),
//             TextField(
//               controller: _wicketsController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Wickets'),
//             ),
//             TextField(
//               controller: _lastFiveController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Last Five Overs Score'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_selectedBattingTeam != null &&
//                     _selectedBowlingTeam != null &&
//                     _selectedTossWinner != null &&
//                     _selectedTossDecision != null &&
//                     _selectedVenue != null &&
//                     _selectedCity != null &&
//                     _currentScoreController.text.isNotEmpty &&
//                     _oversController.text.isNotEmpty &&
//                     _wicketsController.text.isNotEmpty &&
//                     _lastFiveController.text.isNotEmpty) {
//                   Map<String, dynamic> inputData = {
//                     "batting_team": _selectedBattingTeam,
//                     "bowling_team": _selectedBowlingTeam,
//                     "toss_winner": _selectedTossWinner,
//                     "toss_decision": _selectedTossDecision,
//                     "venue": _selectedVenue,
//                     "city": _selectedCity,
//                     "current_score": _currentScoreController.text,
//                     "overs": _oversController.text,
//                     "wickets": _wicketsController.text,
//                     "last_five": _lastFiveController.text,
//                   };

//                   try {
//                     Map<String, dynamic> result = await predictScore(inputData);
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: Text('Predicted Score'),
//                           content: Text(
//                               'Predicted Score: ${result['predicted_score']}'),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text('OK'),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   } catch (e) {
//                     print('Error predicting score: $e');
//                   }
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: Text('Error'),
//                         content: Text('Please fill all the fields'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               child: Text('Predict Score'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }








import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrickPred',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Welcome to CrickPred'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/c.jpg'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PredictionPage()),
                );
              },
              child: Text('Predict Score'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WinPredictionPage()),
                );
              },
              child: Text('Predict Win'),
            ),
          ],
        ),
      ),
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  String? _selectedBattingTeam;
  String? _selectedBowlingTeam;
  String? _selectedTossWinner;
  String? _selectedTossDecision;
  String? _selectedVenue;
  String? _selectedCity;

  List<String> _teams = [];
  List<String> _cities = [];
  List<String> _venues = [];
  List<String> _tossDecisions = [];

  final TextEditingController _currentScoreController = TextEditingController();
  final TextEditingController _oversController = TextEditingController();
  final TextEditingController _wicketsController = TextEditingController();
  final TextEditingController _lastFiveController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDropdownOptions();
  }

  Future<void> fetchDropdownOptions() async {
    try {
      final teamsResponse =
          await http.get(Uri.parse('http://127.0.0.1:5000/teams'));
      final citiesResponse =
          await http.get(Uri.parse('http://127.0.0.1:5000/cities'));
      final venuesResponse =
          await http.get(Uri.parse('http://127.0.0.1:5000/venues'));
      final tossDecisionsResponse =
          await http.get(Uri.parse('http://127.0.0.1:5000/toss_decisions'));

      if (teamsResponse.statusCode == 200 &&
          citiesResponse.statusCode == 200 &&
          venuesResponse.statusCode == 200 &&
          tossDecisionsResponse.statusCode == 200) {
        setState(() {
          _teams = List<String>.from(jsonDecode(teamsResponse.body));
          _cities = List<String>.from(jsonDecode(citiesResponse.body));
          _venues = List<String>.from(jsonDecode(venuesResponse.body));
          _tossDecisions =
              List<String>.from(jsonDecode(tossDecisionsResponse.body));
        });
      } else {
        throw Exception('Failed to load dropdown options');
      }
    } catch (error) {
      print('Error fetching dropdown options: $error');
    }
  }

  Future<Map<String, dynamic>> predictScore(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/predict'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to predict score');
    }
  }

  void _submitPrediction() async {
    try {
      final data = {
        'batting_team': _selectedBattingTeam,
        'bowling_team': _selectedBowlingTeam,
        'toss_winner': _selectedTossWinner,
        'toss_decision': _selectedTossDecision,
        'venue': _selectedVenue,
        'city': _selectedCity,
        'current_score': _currentScoreController.text,
        'overs': _oversController.text,
        'wickets': _wicketsController.text,
        'last_five': _lastFiveController.text,
      };

      final result = await predictScore(data);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Predicted Score'),
            content: Text('Predicted Score: ${result['predicted_score']}'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error predicting score: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket Score Predictor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Batting Team'),
                value: _selectedBattingTeam,
                onChanged: (newValue) {
                  setState(() {
                    _selectedBattingTeam = newValue;
                  });
                },
                items: _teams.map((team) {
                  return DropdownMenuItem(
                    value: team,
                    child: Text(team),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Bowling Team'),
                value: _selectedBowlingTeam,
                onChanged: (newValue) {
                  setState(() {
                    _selectedBowlingTeam = newValue;
                  });
                },
                items: _teams.map((team) {
                  return DropdownMenuItem(
                    value: team,
                    child: Text(team),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Toss Winner'),
                value: _selectedTossWinner,
                onChanged: (newValue) {
                  setState(() {
                    _selectedTossWinner = newValue;
                  });
                },
                items: _teams.map((team) {
                  return DropdownMenuItem(
                    value: team,
                    child: Text(team),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Toss Decision'),
                value: _selectedTossDecision,
                onChanged: (newValue) {
                  setState(() {
                    _selectedTossDecision = newValue;
                  });
                },
                items: _tossDecisions.map((decision) {
                  return DropdownMenuItem(
                    value: decision,
                    child: Text(decision),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Venue'),
                value: _selectedVenue,
                onChanged: (newValue) {
                  setState(() {
                    _selectedVenue = newValue;
                  });
                },
                items: _venues.map((venue) {
                  return DropdownMenuItem(
                    value: venue,
                    child: Text(venue),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'City'),
                value: _selectedCity,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCity = newValue;
                  });
                },
                items: _cities.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _currentScoreController,
                decoration: InputDecoration(labelText: 'Current Score'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _oversController,
                decoration: InputDecoration(labelText: 'Overs'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _wicketsController,
                decoration: InputDecoration(labelText: 'Wickets'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _lastFiveController,
                decoration: InputDecoration(labelText: 'Last Five Overs Score'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitPrediction,
                child: Text('Predict Score'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WinPredictionPage extends StatefulWidget {
  @override
  _WinPredictionPageState createState() => _WinPredictionPageState();
}

class _WinPredictionPageState extends State<WinPredictionPage> {
  String? _selectedBattingTeam;
  String? _selectedBowlingTeam;
  String? _selectedTossWinner;
  String? _selectedTossDecision;
  String? _selectedVenue;
  String? _selectedCity;

  List<String> _teams = [];
  List<String> _cities = [];
  List<String> _venues = [];
  List<String> _tossDecisions = [];

  final TextEditingController _firstInningsTotalController =
      TextEditingController();
  final TextEditingController _currentScoreController = TextEditingController();
  final TextEditingController _oversController = TextEditingController();
  final TextEditingController _wicketsController = TextEditingController();
  final TextEditingController _lastFiveController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDropdownOptions();
  }

  Future<void> fetchDropdownOptions() async {
    try {
      final teamsResponse =
          await http.get(Uri.parse('http://127.0.0.1:5000/teams'));
      final citiesResponse =
          await http.get(Uri.parse('http://127.0.0.1:5000/cities'));
      final venuesResponse =
          await http.get(Uri.parse('http://127.0.0.1:5000/venues'));
      final tossDecisionsResponse =
          await http.get(Uri.parse('http://127.0.0.1:5000/toss_decisions'));

      if (teamsResponse.statusCode == 200 &&
          citiesResponse.statusCode == 200 &&
          venuesResponse.statusCode == 200 &&
          tossDecisionsResponse.statusCode == 200) {
        setState(() {
          _teams = List<String>.from(jsonDecode(teamsResponse.body));
          _cities = List<String>.from(jsonDecode(citiesResponse.body));
          _venues = List<String>.from(jsonDecode(venuesResponse.body));
          _tossDecisions =
              List<String>.from(jsonDecode(tossDecisionsResponse.body));
        });
      } else {
        throw Exception('Failed to load dropdown options');
      }
    } catch (error) {
      print('Error fetching dropdown options: $error');
    }
  }

  Future<Map<String, dynamic>> predictWin(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/predict_win'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to predict win');
    }
  }

  void _submitWinPrediction() async {
    try {
      final data = {
        'batting_team': _selectedBattingTeam,
        'bowling_team': _selectedBowlingTeam,
        'toss_winner': _selectedTossWinner,
        'toss_decision': _selectedTossDecision,
        'venue': _selectedVenue,
        'city': _selectedCity,
        'first_innings_total': _firstInningsTotalController.text,
        'current_score': _currentScoreController.text,
        'overs': _oversController.text,
        'wickets': _wicketsController.text,
        'last_five': _lastFiveController.text,
      };

      final result = await predictWin(data);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Win Prediction'),
            content: Text(
                'Predicted Score: ${result['predicted_score']}\nWin Outcome: ${result['win_outcome']}'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error predicting win: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket Win Predictor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Batting Team'),
                value: _selectedBattingTeam,
                onChanged: (newValue) {
                  setState(() {
                    _selectedBattingTeam = newValue;
                  });
                },
                items: _teams.map((team) {
                  return DropdownMenuItem(
                    value: team,
                    child: Text(team),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Bowling Team'),
                value: _selectedBowlingTeam,
                onChanged: (newValue) {
                  setState(() {
                    _selectedBowlingTeam = newValue;
                  });
                },
                items: _teams.map((team) {
                  return DropdownMenuItem(
                    value: team,
                    child: Text(team),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Toss Winner'),
                value: _selectedTossWinner,
                onChanged: (newValue) {
                  setState(() {
                    _selectedTossWinner = newValue;
                  });
                },
                items: _teams.map((team) {
                  return DropdownMenuItem(
                    value: team,
                    child: Text(team),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Toss Decision'),
                value: _selectedTossDecision,
                onChanged: (newValue) {
                  setState(() {
                    _selectedTossDecision = newValue;
                  });
                },
                items: _tossDecisions.map((decision) {
                  return DropdownMenuItem(
                    value: decision,
                    child: Text(decision),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Venue'),
                value: _selectedVenue,
                onChanged: (newValue) {
                  setState(() {
                    _selectedVenue = newValue;
                  });
                },
                items: _venues.map((venue) {
                  return DropdownMenuItem(
                    value: venue,
                    child: Text(venue),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'City'),
                value: _selectedCity,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCity = newValue;
                  });
                },
                items: _cities.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _firstInningsTotalController,
                decoration: InputDecoration(labelText: 'First Innings Total'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _currentScoreController,
                decoration: InputDecoration(labelText: 'Current Score'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _oversController,
                decoration: InputDecoration(labelText: 'Overs'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _wicketsController,
                decoration: InputDecoration(labelText: 'Wickets'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _lastFiveController,
                decoration: InputDecoration(labelText: 'Last Five Overs Score'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitWinPrediction,
                child: Text('Predict Win'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: Center(
        child: Text('Data page content goes here'),
      ),
    );
  }
}

class GraphPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graphs'),
      ),
      body: Center(
        child: Text('Graph page content goes here'),
      ),
    );
  }
}
