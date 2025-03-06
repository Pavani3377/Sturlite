import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import '../utils/static_data.dart';
import 'package:http/http.dart' as http;

Future getGlAccountDEA() async{
  String url = "${StaticData.apiURL}/YY1_INVOICEGLACCOUNT_CDS/YY1_INVOICEGLAccount";
  try{
    final response = await http.get(
        Uri.parse(url),
        headers: {
          'authorization': StaticData.basicAuth
        }
    );
    if(response.statusCode == 200){
      return json.decode(response.body)['d']['results'];
    } else{
      log("Response Status Code in GL Account API: ${response.statusCode}");
      return null;
    }
  }catch(e){
    log("Error in GL Account API: $e");
    return null;
  }
}

Future getVendorCode() async{
  String url = "${StaticData.apiURL}/YY1_INVOICEVENDORDETAILS_CDS/YY1_INVOICEVENDORDETAILS";
  try{
    final response = await http.get(
        Uri.parse(url),
        headers: {
          'authorization': StaticData.basicAuth
        }
    );
    if(response.statusCode == 200){
      return json.decode(response.body)['d']['results'];
    } else{
      log("Response Status Code in GL Account API: ${response.statusCode}");
      return null;
    }
  }catch(e){
    log("Error in GL Account API: $e");
    return null;
  }
}

Future getCostCenter() async{
  String url = "${StaticData.apiURL}/YY1_INVOICECOSTCENTER_CDS/YY1_INVOICECOSTCENTER";
  try{
    final response = await http.get(
        Uri.parse(url),
        headers: {
          'authorization': StaticData.basicAuth
        }
    );
    if(response.statusCode == 200){
      return json.decode(response.body)['d']['results'];
    } else{
      log("Response Status Code in GL Account API: ${response.statusCode}");
      return null;
    }
  }catch(e){
    log("Error in GL Account API: $e");
    return null;
  }
}

Future getWithholdingTax() async{
  String url = "${StaticData.apiURL}/Z_SUPPWITHHOLDTAX_SVCBND/Z_SUPPLIERWITHHOLDTAX";
  try{
    final response = await http.get(
        Uri.parse(url),
        headers: {
          'authorization': StaticData.basicAuth
        }
    );
    if(response.statusCode == 200){
      return json.decode(response.body)['d']['results'];
    } else{
      log("Response Status Code in GL Account API: ${response.statusCode}");
      return null;
    }
  }catch(e){
    log("Error in GL Account API: $e");
    return null;
  }
}

Future getBusinessPlace() async{
  String url = "${StaticData.apiURL}/Z_SUPPWITHHOLDTAX_SVCBND/Z_Businessplace";
  try{
    final response = await http.get(
        Uri.parse(url),
        headers: {
          'authorization': StaticData.basicAuth
        }
    );
    if(response.statusCode == 200){
      return json.decode(response.body)['d']['results'];
    } else{
      log("Response Status Code in GL Account API: ${response.statusCode}");
      return null;
    }
  }catch(e){
    log("Error in GL Account API: $e");
    return null;
  }
}

Future<bool> postDataDirectExpense(xml, BuildContext context, bool mounted)async{
  List store =[];
  String postURl = "https://Sturliteapp-chipper-bear-vb.cfapps.in30.hana.ondemand.com/api/postsoap/journalentrycreaterequestconfi";
  final url = Uri.parse(postURl); // Replace with your API endpoint
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'Accept': 'text/xml',// Header for XML data
        'authorization': StaticData.basicAuth,
      },
      body:  utf8.encode(xml.toString()), // The XML payload
    );

    if (response.statusCode == 200) {
      final document = XmlDocument.parse(response.body);

      // Extract all <Note> elements under <Item>
      final errorNotes = document.findAllElements('Note').map((note) => note.text).toList();

      // Print the error messages
      print("Error Messages:");
      for (var error in errorNotes) {
        print(error);
        store.add(error);
      }
      print(store);

      bool isSuccess = store.any((message) => message.contains("Document posted successfully"));

      if (isSuccess) {
        // Parse the XML

        // Find the `AccountingDocument` element
        final XmlElement accountingDocument = document.findAllElements('AccountingDocument').first;

        // Extract the text value
        final String accountingDocumentValue = accountingDocument.text;

        print('AccountingDocument value: $accountingDocumentValue');

        print("Success: Document posted successfully!");

        if(mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
                title: Row(
                  children: [
                    Icon(
                      isSuccess ? Icons.check_circle : Icons.error,
                      color: isSuccess ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    const Text('Success'),
                  ],
                ),
                content:  Column(
                    mainAxisSize: MainAxisSize.min, // Adjusts the column height to fit its content
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "The document has been posted successfully!",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      SelectableText(
                        "Accounting Document: $accountingDocumentValue",
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ]

                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: isSuccess ? Colors.green : Colors.red,
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              );
            },
          );
        }
        return true;
      } else {
        if(mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error Messages:'),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Adjusts the column height to fit its content
                  children: store.map((item) => Text(item)).toList(),
                ),

                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Close the AlertDialog
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        return false;
      }

    }
    if(response.statusCode == 500){
      if(mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Something went wrong'),


              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Close the AlertDialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    return false;
  }
  catch(e){
    log(e.toString());
    return false;
  }
}
