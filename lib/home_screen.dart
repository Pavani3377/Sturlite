import 'package:flutter/material.dart';
import 'package:sturlite/petty_cash_entry/petty_cash_entry.dart';
// import 'package:sturlite/test.dart';

import 'customer_receipt/customer_receipt_entry.dart';
import 'direct_expenses/dierect_expenses.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  //     value: 1,
                  //     child: Center(child: Text("Add Users"))
                  // ),
                ];
              },
              onSelected:(value) async {
                if(value == 0){
                  //confirmLogout();
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
}

class HoverableCard extends StatefulWidget {
  final String item;
  final VoidCallback onTap;

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
