import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sturlite/home_screen.dart';
import 'package:sturlite/petty_cash_entry/petty_cash_entry.dart';
import 'package:sturlite/utils/static_data.dart';

import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE5EEF5),
              Color(0xFFA5CBEF),
              Color(0xFFE5EEF5)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo Section
                    Container(
                      height: 100,
                      width: 350,
                      decoration: const BoxDecoration(
                      //  color:Colors.black,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffB2B5C4),

                           Colors.black,
                            Color(0xffB2B5C4),

                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,

                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Image.asset("assets/sturlite.png"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Welcome Text
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 30, // Slightly larger font size for emphasis
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = const LinearGradient(
                          colors: [
                            // Color(0xFFA54AE2), // Light blue
                            // Color(0xFF145DA0),
                            // Color(0xFFFF8C42), // Vibrant Orange
                             Color(0xd7f69aa5), // Darker blue
                             Color(0xd7000000), // Darker blue
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(const Rect.fromLTWH(0.0, 0.0, 100.0, 70.0)),
                        shadows: const [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 2.0,
                            color: Colors.black26, // Subtle shadow for depth
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    Text(
                      'Please login to continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Email Input Field
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'User Name',
                        prefixIcon: const Icon(Icons.email, color: Colors.blueAccent),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    // Password Input Field
                    TextField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible, // Toggles password visibility
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          print('Forgot Password Clicked');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.blueAccent.shade700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF4A90E2), // Light blue
                              Color(0xFF145DA0),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _handleLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, // Transparent to let the gradient show
                            shadowColor: Colors.transparent, // No shadow behind
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _handleLogin() async {
    final username = emailController.text.trim();
    final pass = passwordController.text.trim();

    if(username.isNotEmpty && pass.isNotEmpty){
      // log("Logging in with username: $username and password: $pass");
      await checkLogin(username,pass);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter Valid User Id and Password")));
      log("Username and Password are required");
    }
    // Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(), settings: const RouteSettings(name: "/")), (route) => false,);
  }

  checkLogin(String username, String password) async {
    Map tempJson ={
      "username": username,
      "password": password
    };


    final response = await http.post(Uri.parse("https://Sturliteapp-chipper-bear-vb.cfapps.in30.hana.ondemand.com/api/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(tempJson)
    );
    if(response.statusCode ==200){
      Map tempData = json.decode(response.body);
      if(tempData.containsKey('status')){
        if(tempData['status']=="error") {
          if(mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter Valid User Id and Password")));
          }
        }
        else {
          window.sessionStorage["login"] = "success";
          window.sessionStorage["userType"] = tempData['role'];
          if(username == "Inflow") {
            window.sessionStorage["userType"] = "all";
          }
          if(mounted) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            //Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(), settings: const RouteSettings(name: "/")), (route) => false,);
          }
        }
      }
      else {
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
        }

      }
    }
    else {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
      }
    }
  }
}



