import 'package:flutter/material.dart';
import 'package:getx_todos/controller/controllerAuth.dart';
import 'package:getx_todos/screens/home.dart';
import 'package:getx_todos/screens/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final AuthService authService =
      AuthService(); // Create an instance of AuthService

  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Handle invalid input (e.g., show an error message)
      return;
    }

    try {
      // Use the signIn function from AuthService
      await authService.signIn(email, password);

      // Successfully signed in, navigate to the next page or perform necessary actions
      print('Login successful');

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } catch (e) {
      // Handle sign-in error (e.g., show an error message)
      print('Error signing in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
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
            onPressed: _login,
            child: const Text("Login"),
          ),
           Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a member?"),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpPage()));
                  },
                  child: const Text(
                    "Register now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ]
           )
        ],
      ),
    );
  }
}
