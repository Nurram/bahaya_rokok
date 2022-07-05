import 'package:bahaya_rokok/button_widget.dart';
import 'package:bahaya_rokok/detail_screen.dart';
import 'package:bahaya_rokok/detail_screen_two.dart';
import 'package:bahaya_rokok/iconed_button_widget.dart';
import 'package:bahaya_rokok/quiz_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AERO - Aplikasi Edukasi Bahaya Merokok',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AERO - Aplikasi Edukasi Bahaya Merokok'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Text(
                      'Selamat Datang di AERO (Aplikasi Edukasi Bahaya Merokok)',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconedButtonWidget(
                      icon: Icons.smoking_rooms,
                      title: 'Apa itu rokok?',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailScreenTwo(
                                title: "Apa itu rokok?",
                                code: "pengertianRokok"),
                          ),
                        );
                      }),
                  IconedButtonWidget(
                    imageIcon: const ImageIcon(AssetImage('assets/lungs.png'),
                        color: Colors.white),
                    title: 'Sistem pernapasan',
                    onTap: () =>
                        _moveScreen(context, "Sistem pernapasan", "sistemPernapasan"),
                  ),
                  IconedButtonWidget(
                    icon: Icons.smoke_free,
                    title: 'Bahaya rokok',
                    onTap: () => _moveScreen(context, "Bahaya rokok", "bahayaRokok"),
                  ),
                  IconedButtonWidget(
                    icon: Icons.question_mark,
                    title: 'Quiz',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizWidget(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  _moveScreen(BuildContext context, String title, String code) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(title: title, code: code),
      ),
    );
  }
}
