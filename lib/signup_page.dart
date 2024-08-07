import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'login_page.dart'; // Import LoginPage untuk navigasi

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late Color myColor;
  late Size mediaSize;

  TextEditingController namedController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final dio = Dio();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: myColor,
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInputField(namedController, "Name"),
                const SizedBox(height: 20),
                _buildInputField(emailController, "Username"),
                const SizedBox(height: 20),
                _buildInputField(passwordController, "Password",
                    isPassword: true),
                const SizedBox(height: 40),
                _buildSignUpButton(),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: _buildGreyText("Back to Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String labelText,
      {bool isPassword = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Colors.white),
        obscureText: isPassword,
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        goRegister(context, dio, apiUrl, namedController, emailController,
            passwordController);
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("SIGN UP"),
    );
  }
}

void goRegister(BuildContext context, dio, apiUrl, namedController,
    emailController, passwordController) async {
  try {
    final response = await dio.post(
      '$apiUrl/register',
      data: {
        'name': namedController.text,
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    print(response.data);
  } on DioError catch (e) {
    if (e.response != null) {
      print('${e.response} - ${e.response!.statusCode}');
    } else {
      print('Request failed due to Dio error: $e');
    }
  } catch (e) {
    print('Unexpected error during registration: $e');
  }
}
