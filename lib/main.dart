import 'package:flutter/material.dart';
import 'package:projectanalysis/video.dart';
import 'signup_page.dart'; // Import SignUpPage
import 'login_page.dart';
import 'piggy_purse.dart';// Import LoginPage
import 'personalized_savings_page.dart';
import 'pie.dart';
import 'api.dart';
import 'future_pay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(primary: const Color(0xFF17BEBB));
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData.from(colorScheme: colorScheme),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/signup': (context) => SignupPage(),
        '/login': (context) => LoginPage(),
        '/personalize': (context) => PersonalizedSavingsPage(),
        '/charts' : (context) => Charts(),
        '/api' : (context) => Api(),
        '/purse' : (context) => PiggyPurseHomePage(),
        '/anim' : (context) => VideoPlayerScreen(),
        '/future':(context) =>FuturePaymentsApp()
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/personalize');
              },
              child: Text('personalized'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/charts');
              },
              child: Text('charts'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/api');
              },
              child: Text('api'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/purse');
              },
              child: Text('piggy_purse'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/anim');
              },
              child: Text('animation'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/future');
              },
              child: Text('To pay list'),
            ),
          ],
        ),
      ),
    );
  }
}
