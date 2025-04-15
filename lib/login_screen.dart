import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sturlite/home_screen.dart';
import 'package:sturlite/utils/m_colors.dart';
import 'package:sturlite/utils/static_data.dart';

import 'package:http/http.dart' as http;

String responseData="";
String formattedUuid="";
String guID="guid";


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController plantName = TextEditingController();
  final TextEditingController newPasswordController=TextEditingController();
  bool userBool=false;
  bool showError = false;
  bool passWordColor = false;
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode plantFocusNode = FocusNode();
  bool showHidePassword=true;
  void passwordHideAndViewFunc(){
    setState(() {
      showHidePassword = !showHidePassword;
    });
  }
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
                    SizedBox(
                      height: 55,
                      child: TextField(
                        controller: userName,
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
                        style: const TextStyle(fontSize: 14),
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(passwordFocusNode);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 55,
                      child: TextField(
                        controller: password,
                        obscureText: showHidePassword,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
                          suffixIcon: IconButton(
                            icon: Icon(
                              showHidePassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                showHidePassword = !showHidePassword;
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
                        style: const TextStyle(fontSize: 14),
                        onEditingComplete: () {
                          postLogin(userName, password,plantName).then((value) {
                            if (value != null) {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(
                                  userName: 'value', plantValue: '',

                                ),
                              ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Login failed. Invalid username, password'),
                                ),
                              );
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                     SizedBox(height: 35, width: double.infinity,
                       child: Container(
                      decoration:  BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF4A90E2), // Light blue
                            Color(0xFF145DA0), // Darker blue
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(onPressed: () {
                        postLogin(userName, password,plantName).then((value) {
                          if(value != null){
                            Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                  const HomeScreen(plantValue: '', userName: '',),
                                )
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login failed. Invalid username, password.'),
                              ),
                            );
                          }
                        });
                      },
                          child: const Text("Log In",style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16,),)),
                    ),
                    ),

                    const SizedBox(height: 15),
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
  Future<SharedPreferences?> postLogin(TextEditingController userName, TextEditingController password, TextEditingController plant) async{
    String url = "${StaticData.apiURL}/Gateentry/YY1_USERCRED_CDS/YY1_USERCRED?filter=UserName eq '${userName.text}' and Password eq '${password.text}'";
    // print("post login url $url");
    try{
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': StaticData.basicAuth,
        },
      );

      if (response.statusCode == 200) {
        Map responseData ={};
        try{
          responseData= jsonDecode(response.body);
          if(responseData.containsKey("d") && responseData["d"]["results"].isNotEmpty){
            String plantValue = responseData["d"]["results"][0]["Plant"];
            String sapuid = responseData["d"]["results"][0]["SAP_UUID"];
            String businessplace= responseData["d"]["results"][0]["BusinessPlace"];
            String businessplacename= responseData["d"]["results"][0]["BusinessPlaceName"];
            String cashgl=responseData["d"]["results"][0]["CashGL"];
            String hapygl=responseData["d"]["results"][0]["HappayCardGL"];

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('userName', userName.text);
            prefs.setString('password', password.text);
            prefs.setString('sapuid', sapuid);

            prefs.setString('plant', plantValue);
            prefs.setString('BusinessPl', businessplace);
            prefs.setString('BusinessPlNM', businessplacename);
            prefs.setString('cashgls', cashgl);
            prefs.setString('happygl', hapygl);

            return prefs;
            // plantValue;
            // return prefs;
          } else {
            print("Login failed: No user found");
            return null;
          }
        }
        catch(e){
          log(response.body);
          return null;
        }
      }
      else {
        print("Error: ${response.statusCode}");
        return null;
      }
    }catch(e){
      print("Exception during login: $e");
      return null;
    }
  }

  decorationInputPassword(String hintString, bool val, bool passWordHind,  passwordHideAndView, ) {
    return InputDecoration(
        label: Text(
          hintString,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passWordHind ? Icons.visibility : Icons.visibility_off,size: 20,
          ),
          onPressed: passwordHideAndView,
        ),suffixIconColor: val?const Color(0xff00004d):Colors.grey,
        // suffixIconColor:val?  const Color(0xff00004d):Colors.grey,
        counterText: "",
        contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
        hintText: hintString,labelStyle: const TextStyle(fontSize: 12,),

        disabledBorder:  const OutlineInputBorder(borderSide:  BorderSide(color:  Colors.white)),
        enabledBorder:const OutlineInputBorder(borderSide:  BorderSide(color: mTextFieldBorder)),
        focusedBorder:  const OutlineInputBorder(borderSide:  BorderSide(color: Color(0xff00004d))),
        border:   const OutlineInputBorder(borderSide:  BorderSide(color: Color(0xff00004d)))

    );
  }
  decorationInput3(String hintString, bool val,) {
    return  InputDecoration(

        label: Text(
          hintString,
        ),
        counterText: '',labelStyle: const TextStyle(fontSize: 12),
        contentPadding:  const EdgeInsets.fromLTRB(12, 00, 0, 0),
        hintText: hintString,
        suffixIconColor: const Color(0xfff26442),
        disabledBorder:  const OutlineInputBorder(borderSide:  BorderSide(color:  Colors.white)),
        enabledBorder:const OutlineInputBorder(borderSide:  BorderSide(color: mTextFieldBorder)),
        focusedBorder:  const OutlineInputBorder(borderSide:  BorderSide(color:Color(0xff00004d))),
        border:   const OutlineInputBorder(borderSide:  BorderSide(color:Color(0xff00004d)))
    );
  }

}



