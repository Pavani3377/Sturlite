import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sturlite/petty_cash_entry/petty_cash_entry.dart';
import 'package:sturlite/utils/static_data.dart';


import 'package:http/http.dart' as http;

import 'direct_expenses/dierect_expenses.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({super.key, required final String userName});

  final String plantValue;
  const HomeScreen({
    required this.plantValue,
    super.key, required String userName
  });


  // final String plantValue;
  // const HomeScreen({super.key, required this.plantValue});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController newPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(elevation: 3,
        centerTitle: true,
        title: const Text("Home",
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),),
        actions: [

          PopupMenuButton(
            // add icon, by default "3 dot" icon
              icon: const Icon(Icons.account_circle),
              itemBuilder: (context){
                return [
                  const PopupMenuItem<int>(
                      value: 0,
                      child: Center(child: Text("Logout"))
                  ),
                  // const PopupMenuItem<int>(
                  //   value: 1,
                  //   child: Center(child: Text("Forgot Password")),
                  // ),
                  // const PopupMenuItem<int>(
                  //     value: 1,
                  //     child: Center(child: Text("Add Users"))
                  // ),
                ];
              },
              onSelected:(value) async {
                if(value == 0){
                  confirmLogout();
                }
                if(value == 1){
                  Navigator.pushNamed(context, '/userManagement');
                }
              }
          ),
          const SizedBox(width: 10,),


        ],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // setState(() {
                    //
                    //   _showNewPasswordField = true;  // Show new password field
                    // });
                    changPassword();
                  },
                  child: Text(
                    'Create New Password',
                    style: TextStyle(color: Colors.blueAccent.shade700),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 20.0,
                runSpacing: 20.0,
                //"Customer Receipt" Is Required We Need To ADD Below.
                children: ["Petty Cash Entry", "Direct Expenses"].map((item) {
                  return HoverableCard(
                    item: item,
                    onTap: () {
                      if (item == "Petty Cash Entry") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PettyCashEntry(),
                          ),
                        );
                      }
                      if (item == "Direct Expenses") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DirectExpenses(),
                          ),
                        );
                      }

                      ///Customer Module.
                      // if(item == "Customer Receipt"){
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const CustomerReceiptEntry(),
                      //     ),
                      //   );
                      // }
                    },
                  );

                }).toList(),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
  Color logYesTextColor = Colors.black;
  Color logNoTextColor = Colors.black;

void confirmLogout() {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: 200,
              width: 300,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    margin:const EdgeInsets.only(top: 13.0,right: 8.0),
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 25),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Icon(
                            Icons.warning_rounded,
                            color: Colors.orange,
                            size: 50,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(
                            child: Text(
                              "Are You Sure Logout ?",
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blue,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: MouseRegion(
                                  onHover: (event) {
                                    setState((){
                                      logYesTextColor = Colors.white;
                                    });
                                  },
                                  onExit: (event) {
                                    setState((){
                                      logYesTextColor = Colors.black;
                                    });
                                  },
                                  child: MaterialButton(
                                      hoverColor: Colors.lightBlueAccent,
                                      onPressed: () async{
                                        window.sessionStorage["login"] = "";
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                                              (Route<dynamic> route) => false, // This removes all the previous routes.
                                        );

                                      }, child:  Text("Yes",style: TextStyle(color: logYesTextColor),)),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.red,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: MouseRegion(
                                  onHover: (event) {
                                    setState((){
                                      logNoTextColor = Colors.white;
                                    });
                                  },
                                  onExit: (event) {
                                    setState((){
                                      logNoTextColor = Colors.black;
                                    });
                                  },
                                  child: MaterialButton(
                                      hoverColor: Colors.redAccent,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }, child:  Text("No",style: TextStyle(color: logNoTextColor),)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    child: InkWell(
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color.fromRGBO(204, 204, 204, 1),
                              ),
                              color: Colors.blue
                          ),
                          child: const Icon(
                            Icons.close_sharp,
                            color: Colors.white,
                          )
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },),
      );
    },);
}
  void changPassword() {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isPasswordVisible = false;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Change Password'),
              content: SizedBox(
                width: 300,
                height: 100,
                child: TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Create New Password',
                    prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
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
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () {
                    _resetPassword(passwordController.text);
                    // Handle password update here if needed
                    // Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password updated!')),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
  void _resetPassword(String newPassword) async {

    if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter new password.")),
      );
      return;
    }

    bool success = await patchdata(newPassword);

    if (success) {

      if (mounted) {
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully!")),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
        );
// Return to HomeScreen
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update password.")),
        );
      }
    }
  }

  Future<bool> patchdata(String newPassword) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String sapuid = pref.getString("sapuid") ?? "";
    String patchurl =
        "${StaticData.patchapiURL}/YY1_USERCRED_CDS/YY1_USERCRED/$sapuid";
    // print("patchurl--------- $patchurl");

    Map<String, dynamic> requestBody = {
      "Password": newPassword,
    };

    // print(requestBody);
    try {
      final response = await http.patch(
        Uri.parse(patchurl),
        headers: {
          "Content-Type": "application/json",
          'authorization': StaticData.basicAuth,
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("new password updated successfully.");
        return true;
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception in patching data: $e");
    }
    return false;
  }
}

class HoverableCard extends StatefulWidget {
  final String item;
  // final VoidCallback onTap;
  final  onTap;

  const HoverableCard({Key? key, required this.item, required this.onTap}) : super(key: key);

  @override
  _HoverableCardState createState() => _HoverableCardState();
}

class _HoverableCardState extends State<HoverableCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: _isHovered
                    ? [const Color(0xff3C78D8), const Color(0xff6D9EEB)]
                    : [const Color(0xff6D9EEB), const Color(0xff3C78D8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(_isHovered ? 0.5 : 0.3),
                  blurRadius: _isHovered ? 15 : 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Container(
              height: 150,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.widgets_rounded,
                    size: 50,
                    color: _isHovered ? Colors.grey[300] : Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.item,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
