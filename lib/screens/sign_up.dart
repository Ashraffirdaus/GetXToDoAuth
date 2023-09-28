import 'package:flutter/material.dart';
import 'package:getx_todos/controller/controllerAuth.dart';
import 'package:getx_todos/screens/home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // Function to perform the sign-up logic
  Future<void> performSignUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Handle invalid input (e.g., show an error message)
      return;
    }

    try {
      final AuthService authService =
          AuthService(); // Create an instance of AuthService

      // Call the signUp method from AuthService
      await authService.signUp(email, password);
       Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
      // Handle the result of the sign-up process here, e.g., show a success message
      print('Sign up successful');
    } catch (error) {
      // Handle sign-up error (e.g., show an error message)
      print('Error signing up: $error');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign up Page"),
          automaticallyImplyLeading: false,
        ),
        body: Column(children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          ElevatedButton(
            onPressed: performSignUp,
            child: const Text("Sign Up"),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Already a member?"),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Login now",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ])
        ]));
  }
}
