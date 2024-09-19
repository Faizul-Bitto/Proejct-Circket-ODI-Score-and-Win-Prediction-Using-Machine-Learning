import 'package:flutter/material.dart';

class WinPredictionPage extends StatelessWidget {
  final Map<String, dynamic> predictionResult;

  WinPredictionPage({required this.predictionResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Win Prediction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Predicted Score: ${predictionResult['predicted_score']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Winning Probability: ${predictionResult['winning_probability']}%', // Assuming the backend returns a winning probability
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
