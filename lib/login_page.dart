import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Define the color scheme
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(primary: const Color(0xFF17BEBB));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(colorScheme: colorScheme),
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context, colorScheme),
              _forgotPassword(context),
              _signup(context, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  Widget _inputField(BuildContext context, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: colorScheme.primary.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: colorScheme.primary.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            //an primary: colorScheme.primary,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),

          ),
        )
      ],
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(),
      ),
    );
  }

  Widget _signup(BuildContext context, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: colorScheme.primary),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: Text(
            "Home Page",
            style: TextStyle(color: colorScheme.primary),
          ),
        )
      ],
    );
  }
}
