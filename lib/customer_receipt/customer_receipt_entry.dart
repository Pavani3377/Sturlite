import 'dart:developer';
import 'dart:html';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart' as xml;
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import '../login_screen.dart';
import '../petty_cash_entry/petty_cash_api.dart';
import '../utils/m_colors.dart';
import '../utils/static_data.dart';
import '../utils/utils.dart';
import '../widgets/customButtons.dart';
import '../widgets/custom_message/toastification_msg.dart';
import '../widgets/custom_popup_dropdown/custom_popup_dropdown.dart';
import '../widgets/custom_search_textfield/custom_search_field.dart';

class CustomerReceiptEntry extends StatefulWidget {
  const CustomerReceiptEntry({super.key});

  @override
  State<CustomerReceiptEntry> createState() => _CustomerReceiptEntryState();
}

class _CustomerReceiptEntryState extends State<CustomerReceiptEntry> {
  bool isLoading = false;
  bool isShowBalance = false;
  bool isShowTable1 = false;
  bool isShowTable2 = false;
  late double screenWidth;
  late double screenHeight;
  String companyDropdownValue = "--Select--";
  String cashDropdownValue = "";
  String typeDropdownValue = "--Select--";
  FocusNode postingDateNode = FocusNode();
  FocusNode invoicingDateNode = FocusNode();
  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();
  final _horizontalScrollController2 = ScrollController();
  final TextEditingController postingDateController = TextEditingController();
  final TextEditingController invoicingDateController = TextEditingController();
  List houseBankList = [];
  List<String> accountIdBankList = [];
  List glAccList = [];
  List<String> costCenterList = [];
  List<String> profitCenterList = [];
  List<String> store = [];
  var typeOfTransactionList = [
    "--Select--",
    "Cash Receipt",
    "Cash Payment",
    "Customer Receipt"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchApiResponse();
    // TODO: implement initState
  }
  Color logYesTextColor = Colors.black;
  Color logNoTextColor = Colors.black;
  Future<void> _fetchApiResponse() async{
    setState(() {
      isLoading = true;
    });
    try{
      ///New API.
      var glAcc = await getCustomerGLAccount();
      var houseBank = await getHouseBank();
      var costCenter = await getCostCenter();
      var profitCenter = await getProfitCenter();

      if(houseBank != null){
        setState(() {
          // houseBankList = houseBank.map<String>((item) {
          //   print(item);
          //   return item["HouseBank"].toString();
          // })
          //     .toSet().toList();
          houseBankList = houseBank;
        });
      } else{
        log('No data found for House Bank.');
      }

      if(houseBank != null){
        setState(() {
          accountIdBankList = houseBank.map<String>((item) => item["HouseBank"].toString())
              .toSet().toList();
        });
      } else{
        log('No data found for House Bank.');
      }

      if(glAcc != null){
        setState(() {
          //OLD
          //glAccList = glAcc.map<String>((item) => item["Customer"].toString()).toSet().toList();
          //Adding new.
          glAccList = glAcc.map((item)=>{
            "Customer":item['Customer'].toString(),
            "CustomerName":item['CustomerName'].toString()
          }).toSet().toList();

        });
      } else{
        log('No data found for GL Account.');
      }

      if(costCenter != null){
        setState(() {
          costCenterList = costCenter.map<String>((item) => item["CostCenter"].toString())
              .toSet().toList();
        });
      } else{
        log('No data found for Cost Center.');
      }

      if(profitCenter != null){
        setState(() {
          profitCenterList = profitCenter.map<String>((item) => item["ProfitCenter"].toString())
              .toSet().toList();
        });
      } else{
        log('No data found for Profit Center.');
      }
    }catch(e){
      log("Error in fetching dropdown values: $e");
    } finally{
      log('Fetching data completed.');
      setState(() {
        isLoading = false;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar: AppBar(elevation: 3,
        centerTitle: true,
        title: const Text("Customer Receipt",
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
                  confirmLogout();
                }

              }
          ),
          const SizedBox(width: 10,),
        ],
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator(),) : Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:  Padding(
            padding: const EdgeInsets.only(right: 38.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 100,),
                SizedBox(
                  height: 35,
                  width: 100,
                  child: OutlinedMButton(
                    text: "Save",
                    buttonColor: mSaveButton,
                    textColor: Colors.white,
                    borderColor: mSaveButton,
                    onTap: () async {
                      bool error = false;
                      if (postingDateController.text.isEmpty) {
                        showToast(
                          context: context,
                          title: 'Posting Date',
                          description: 'Please select posting date',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      // else if (invoicingDateController.text.isEmpty) {
                      //   showToast(
                      //     context: context,
                      //     title: 'Invoicing Date',
                      //     description: 'Invoicing date is required',
                      //     type: ToastificationType.error,
                      //     icon: Icons.clear,
                      //   );
                      // }
                      else if(companyDropdownValue =="--Select--"){
                        showToast(
                          context: context,
                          title: 'Company Code',
                          description: 'Company Code Is Required',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      else{
                        double tempTotal = 0;
                        Map inputData = {
                          "companyCode": companyDropdownValue,
                          "cashJournal": cashDropdownValue,
                          "typeOfTrans": typeDropdownValue,
                          "postingDate": postingDateController.text,
                          "invoiceDate": invoicingDateController.text,
                          'headerTotal':"0",
                          "table": customerTable,
                        };

                        print(customerTable);
                        for(int i=0;i<inputData['table'].length;i++){
                          try{
                            tempTotal = (tempTotal + double.parse(inputData['table'][i]['totalAmount'].toString()));
                          }
                          catch(e){
                            error= true;
                          }
                        }
                        if(error){
                          if(mounted) {
                            toastification.show(
                              context: context, // optional if you use ToastificationWrapper
                              type: ToastificationType.error,
                              style: ToastificationStyle.flat,
                              autoCloseDuration: const Duration(seconds: 4),
                              // you can also use RichText widget for title and description parameters
                              description: const Row(
                                children: [
                                  Text('Please fill (',style: TextStyle(color: Colors.white,fontSize: 16)),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.0,),
                                    child: Text("*",style: TextStyle(color: Colors.red),),
                                  ),
                                  Text(') Mandatory details',style: TextStyle(color: Colors.white,fontSize: 16)),
                                ],
                              ),
                              alignment: Alignment.topCenter,
                              // direction: TextDirection.LTR,
                              //    animationDuration: const Duration(milliseconds: 300),
                              icon: const Icon(Icons.clear,color: Colors.red),
                              // show or hide the icon
                              primaryColor: Colors.black,
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x07000000),
                                  blurRadius: 16,
                                  offset: Offset(0, 16),
                                  spreadRadius: 0,
                                )
                              ],
                              showProgressBar: true,
                              closeButtonShowType: CloseButtonShowType.onHover,
                              closeOnClick: false,
                              pauseOnHover: true,
                              dragToClose: true,
                              applyBlurEffect: true,
                            );
                          }
                        }
                        else{
                          inputData['headerTotal'] = tempTotal.toStringAsFixed(2);

                          final builder = xml.XmlBuilder();

                          builder.element('soapenv:Envelope', namespaces: {
                            'http://schemas.xmlsoap.org/soap/envelope/':'soapenv',
                            'http://sap.com/xi/SAPSCORE/SFIN':'sfin',
                          }, nest: () {
                            builder.element('soapenv:Header');
                            builder.element('soapenv:Body', nest: () {
                              builder.element('sfin:JournalEntryBulkCreateRequest', nest: () {
                                // Main Message Header
                                builder.element('MessageHeader', nest: () {
                                  builder.element('ID', nest: 'MSG_JournalEntryCreateConfi');
                                  builder.element('CreationDateTime', nest: "${inputData['invoiceDate']}T00:00:00.107Z");
                                });

                                // Journal Entry Create Request
                                builder.element('JournalEntryCreateRequest', nest: () {
                                  builder.element('MessageHeader', nest: () {
                                    builder.element('ID', nest: 'SUB_MSG_JournalEntryCreateConfi');
                                    builder.element('CreationDateTime', nest: "${inputData['invoiceDate']}T00:00:00.107Z");
                                  });

                                  builder.element('JournalEntry', nest: () {
                                    builder.element('OriginalReferenceDocumentType', nest: 'BKPFF');
                                    builder.element('BusinessTransactionType', nest: 'RFBU');
                                    builder.element('AccountingDocumentType', nest: 'DZ');
                                    builder.element('DocumentHeaderText', nest: 'AS');
                                    builder.element('CompanyCode', nest: inputData['companyCode']??"");
                                    builder.element('DocumentDate', nest: "${inputData['invoiceDate']}");
                                    builder.element('PostingDate', nest: "${inputData['postingDate']}");
                                    builder.element('CreatedByUser', nest: 'santoshs');

                                    // Item
                                    builder.element('Item', nest: () {
                                      builder.element('ReferenceDocumentItem', nest: '1');
                                      builder.element('GLAccount', nest: inputData['cashJournal']??"");
                                      builder.element('AmountInTransactionCurrency',
                                          attributes: {'currencyCode': 'INR',}, nest: inputData['headerTotal']??"");
                                      builder.element('DebitCreditCode', nest: 'S');
                                    });

                                    for(int i=0;i<inputData['table'].length;i++){
                                      final customer = inputData['table'][i];
                                      // Debtor Item
                                      builder.element('DebtorItem', nest: () {
                                        builder.element('ReferenceDocumentItem', nest: '2');
                                        builder.element('Debtor', nest: customer['GLAccount']);
                                        builder.element('AmountInTransactionCurrency', attributes: {
                                          'currencyCode': 'INR',
                                        }, nest: '-${customer['amount']}');
                                        builder.element('DebitCreditCode', nest: 'H');
                                        builder.element('DocumentItemText');
                                      });
                                    }
                                  });
                                });
                              });
                            });
                          });

                          // Convert XML builder to a string
                          final xmlString = builder.buildDocument().toXmlString(pretty: true);
                          // print(xmlString);
                          bool returnValue = await postDataCustomerReceipt(xmlString,context,mounted);
                          if(returnValue){
                            customerTable =[];
                            companyDropdownValue ="";
                            cashDropdownValue ="";
                            isShowBalance = false;
                            typeDropdownValue ="";
                            postingDateController.clear();
                            invoicingDateController.clear();
                            openingTotal =0;
                            closingTotal =0;
                            openingBalance = "";
                            openingTotal =0;
                            closingTotal =0;
                            openingCurrency = "";
                            closingBalance = "";
                            closingCurrency = "";
                            customerTable = [
                              {
                                "item": "",
                                "amount": "",
                                "GLAccount": "",
                                "houseBank": "",
                                "accountId": "",
                                "text": "",
                                "reference": "",
                                "taxCode": "",
                                "CostCenter": "",
                                "ProfitCenter": "",
                                "assignment": "",
                              },
                            ];
                            setState(() {

                            });

                          }

                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
            children: [
              Expanded(
                  child: Scaffold(
                      body: AdaptiveScrollbar(
                        underColor: Colors.blueGrey.withOpacity(0.3),
                        sliderDefaultColor: Colors.grey.withOpacity(0.7),
                        sliderActiveColor: Colors.grey,
                        controller: _verticalScrollController,
                        child:AdaptiveScrollbar(
                          position: ScrollbarPosition.bottom,
                          underColor: Colors.blueGrey.withOpacity(0.3),
                          sliderDefaultColor: Colors.grey.withOpacity(0.7),
                          sliderActiveColor: Colors.grey,
                          controller: _horizontalScrollController2,
                          child: SingleChildScrollView(
                            controller: _verticalScrollController,
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///Header
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Scrollbar(
                                    controller: _horizontalScrollController,
                                    thumbVisibility: screenWidth < 900 ? true : false,
                                    thickness: 10,
                                    radius: Radius.zero,
                                    child: SingleChildScrollView(
                                      controller: _horizontalScrollController,
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 28, bottom: 15, left: 15),
                                            child: SizedBox(width: 600,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, right: 0, bottom: 15, left: 0),
                                                child: Card(
                                                  color: Colors.white,
                                                  surfaceTintColor: Colors.white,
                                                  elevation: 8,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(4),
                                                      side: BorderSide(
                                                        color: const Color(0x6E0075BB).withOpacity(
                                                            0.8), width: 0.5,)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(0.0),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(height: 10,),
                                                        const Center(child: Text("As of Today",
                                                            style: TextStyle(fontSize: 16,
                                                                fontWeight: FontWeight.bold,
                                                                color: Color(
                                                                    0xFF2191D8)))),
                                                        const SizedBox(height: 10,),
                                                        Container(color: const Color(0x6E0075BB),
                                                            height: 1,
                                                            width: 770),
                                                        Row(
                                                          children: [

                                                            Expanded(
                                                              flex: 1,
                                                              child: Column(
                                                                children: [
                                                                  const Text("Opening Balance",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.black,
                                                                        fontSize: 17),),
                                                                  const SizedBox(height: 5,),
                                                                  Text(openingBalance,
                                                                    style: const TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.blue,
                                                                        fontSize: 17),),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(color: const Color(0x6E0075BB),
                                                                width: 1,
                                                                height: 156),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Column(
                                                                children: [
                                                                  const Text("Closing Balance",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.black,
                                                                        fontSize: 17),),
                                                                  const SizedBox(height: 5,),
                                                                  Text(closingBalance,
                                                                    style: const TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.blue,
                                                                        fontSize: 17),),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 28, bottom: 15, left: 15),
                                            child: Card(
                                              color: Colors.white,
                                              surfaceTintColor: Colors.white,
                                              elevation: 8,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                  side: BorderSide(
                                                    color: mTextFieldBorder.withOpacity(0.8),
                                                    width: 1,)),
                                              child: SizedBox(
                                                width: 950,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(0.0),
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(height: 40,
                                                              width: 100,
                                                              child: Center(child: Text("Details",
                                                                style: TextStyle(fontSize: 16,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Color(
                                                                        0xFF2191D8)),))),
                                                          Container(color: const Color(0x6E0075BB),
                                                              height: 1,
                                                              width: 500),
                                                          const SizedBox(height: 10,),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 200,
                                                                    child: Row(
                                                                      children: [
                                                                        Text("Company Code"),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(top: 4.0,left: 4),
                                                                          child: Text("*",style: TextStyle(color: Colors.red),),
                                                                        )
                                                                      ],
                                                                    )
                                                                ),
                                                                Container(
                                                                  height: 30,
                                                                  width: 200,
                                                                  decoration: BoxDecoration(
                                                                    border: Border.all(color: mTextFieldBorder, width: 1,),
                                                                    borderRadius: BorderRadius
                                                                        .circular(5),
                                                                  ),
                                                                  child: DropdownButton<String>(
                                                                    padding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
                                                                    isExpanded: true,
                                                                    underline: Container(),
                                                                    style: const TextStyle(fontSize: 14),
                                                                    value: companyDropdownValue.isEmpty ? null : companyDropdownValue,
                                                                    hint: const Text("Select Client"),
                                                                    items: companyCodeList.map((String items) {
                                                                      return DropdownMenuItem(
                                                                        value: items,
                                                                        child: Text(items),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged: (value) async {
                                                                      setState(() {
                                                                        companyDropdownValue =
                                                                        value!;
                                                                        if (value == "--Select--") {
                                                                          isShowBalance = false;
                                                                        }
                                                                      });
                                                                      await triggerBalanceApis();
                                                                    },
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 200,
                                                                    child: Row(
                                                                      children: [
                                                                        Text("Cash Journal"),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(top: 4.0,left: 4),
                                                                          child: Text("*",style: TextStyle(color: Colors.red),),
                                                                        )

                                                                      ],
                                                                    )
                                                                ),

                                                                SizedBox(
                                                                    width: 200,
                                                                    child: CustomTextFieldSearch(
                                                                      showAdd: false,
                                                                      decoration: Utils.searchGl(hintText: '--Search GL--', controller: TextEditingController(text: cashDropdownValue)),
                                                                      controller: TextEditingController(text: cashDropdownValue),
                                                                      future: (){
                                                                        return getHeaderGLCodes();
                                                                      },
                                                                      getSelectedValue: (SearchGL v) async {
                                                                        cashDropdownValue = v.label;
                                                                        if(companyDropdownValue != "--Select--"){
                                                                          await triggerBalanceApis();
                                                                        }

                                                                        setState(() {

                                                                        });
                                                                        // tableOne[index]["GLAccount"]= v.label;

                                                                      },

                                                                    )
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 200,
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                            "Type of Transaction"),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(top: 4.0,left: 4),
                                                                          child: Text("*",style: TextStyle(color: Colors.red),),
                                                                        )
                                                                      ],
                                                                    )
                                                                ),
                                                                Container(
                                                                  height: 30,
                                                                  width: 200,
                                                                  decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                      color: mTextFieldBorder,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius: BorderRadius
                                                                        .circular(5),
                                                                  ),
                                                                  child: DropdownButton<String>(
                                                                    padding: const EdgeInsets
                                                                        .fromLTRB(12, 00, 0, 0),
                                                                    isExpanded: true,
                                                                    underline: Container(),
                                                                    style: const TextStyle(
                                                                        fontSize: 14),
                                                                    value: typeDropdownValue.isEmpty
                                                                        ? null
                                                                        : typeDropdownValue,
                                                                    hint: const Text(
                                                                        "Select Client"),
                                                                    items: typeOfTransactionList
                                                                        .map((String items) {
                                                                      return DropdownMenuItem(
                                                                        value: items,
                                                                        child: Text(items),
                                                                      );
                                                                    }).toList(),
                                                                    onChanged: (value) {
                                                                      setState(() {
                                                                        typeDropdownValue = value!;
                                                                        if (value != "--Select--" &&
                                                                            value ==
                                                                                "Cash Receipt") {
                                                                          isShowTable1 = true;
                                                                          isShowTable2 = false;
                                                                        } else
                                                                        if (value != "--Select--" &&
                                                                            value ==
                                                                                "Cash Payment") {
                                                                          isShowTable2 = true;
                                                                          isShowTable1 = false;
                                                                        } else {
                                                                          isShowTable1 = false;
                                                                          isShowTable2 = false;
                                                                        }
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(color: const Color(0x6E0075BB),
                                                        height: 200,
                                                        width: 1),
                                                    Padding(
                                                      padding: const EdgeInsets.all(0.0),
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(height: 40,
                                                              width: 100,
                                                              child: Center(child: Text("Date",
                                                                style: TextStyle(fontSize: 16,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Color(
                                                                        0xFF2191D8)),))),
                                                          Container(color: const Color(0x6E0075BB),
                                                              height: 1,
                                                              width: 449),
                                                          const SizedBox(height: 10,),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 150,
                                                                    child: Row(
                                                                      children: [
                                                                        Text("Posting Date"),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(top: 4.0,left: 4),
                                                                          child: Text("*",style: TextStyle(color: Colors.red),),
                                                                        )
                                                                      ],
                                                                    )
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                  width: 200,
                                                                  child: TextFormField(
                                                                    style: const TextStyle(
                                                                        fontSize: 12),
                                                                    controller: postingDateController,
                                                                    showCursor: false,
                                                                    focusNode: postingDateNode,
                                                                    decoration: Utils.dateDecoration(hintText: "Posting Date"),
                                                                    onTap: () async {
                                                                      DateTime? startDate = await showDatePicker(
                                                                          helpText: "Posting Date",
                                                                          context: context,
                                                                          initialDate: DateTime
                                                                              .now(),
                                                                          firstDate: DateTime(1990),
                                                                          lastDate: DateTime(2100)
                                                                      );
                                                                      if (startDate != null) {
                                                                        String formattedDate = DateFormat(
                                                                            'yyyy-MM-dd').format(
                                                                            startDate);
                                                                        postingDateController.text =
                                                                            formattedDate;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 150,
                                                                    child: Row(
                                                                      children: [
                                                                        Text("Invoicing Date"),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(top: 4.0,left: 4),
                                                                          child: Text("*",style: TextStyle(color: Colors.red),),
                                                                        )
                                                                      ],
                                                                    )
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                  width: 200,
                                                                  child: TextFormField(
                                                                    style: const TextStyle(
                                                                        fontSize: 12),
                                                                    controller: invoicingDateController,
                                                                    showCursor: false,
                                                                    focusNode: invoicingDateNode,
                                                                    decoration: Utils
                                                                        .dateDecoration(
                                                                        hintText: "Invoicing Date"),
                                                                    onTap: () async {
                                                                      DateTime? startDate = await showDatePicker(
                                                                          helpText: "Invoicing Date",
                                                                          context: context,
                                                                          initialDate: DateTime
                                                                              .now(),
                                                                          firstDate: DateTime(1990),
                                                                          lastDate: DateTime(2100)
                                                                      );
                                                                      if (startDate != null) {
                                                                        String formattedDate = DateFormat(
                                                                            'yyyy-MM-dd').format(
                                                                            startDate);
                                                                        invoicingDateController
                                                                            .text = formattedDate;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          ///Old As Of Today
                                          // if(isShowBalance)
                                          //   SizedBox(width: 600,
                                          //     child: Padding(
                                          //       padding: const EdgeInsets.only(
                                          //           top: 10, right: 0, bottom: 15, left: 0),
                                          //       child: Card(
                                          //         color: Colors.white,
                                          //         surfaceTintColor: Colors.white,
                                          //         elevation: 8,
                                          //         shape: RoundedRectangleBorder(
                                          //             borderRadius: BorderRadius.circular(4),
                                          //             side: BorderSide(
                                          //               color: const Color(0x6E0075BB).withOpacity(
                                          //                   0.8), width: 0.5,)),
                                          //         child: Padding(
                                          //           padding: const EdgeInsets.all(0.0),
                                          //           child: Column(
                                          //             children: [
                                          //               const SizedBox(height: 10,),
                                          //               const Center(child: Text("As of Today",
                                          //                   style: TextStyle(fontSize: 16,
                                          //                       fontWeight: FontWeight.bold,
                                          //                       color: Color(
                                          //                           0xFF2191D8)))),
                                          //               const SizedBox(height: 10,),
                                          //               Container(color: const Color(0x6E0075BB),
                                          //                   height: 1,
                                          //                   width: 770),
                                          //               Row(
                                          //                 children: [
                                          //
                                          //                   Expanded(
                                          //                     flex: 1,
                                          //                     child: Column(
                                          //                       children: [
                                          //                         const Text("Opening Balance",
                                          //                           style: TextStyle(
                                          //                               fontWeight: FontWeight.bold,
                                          //                               color: Colors.black,
                                          //                               fontSize: 17),),
                                          //                         const SizedBox(height: 5,),
                                          //                         Text(openingBalance,
                                          //                           style: const TextStyle(
                                          //                               fontWeight: FontWeight.bold,
                                          //                               color: Colors.blue,
                                          //                               fontSize: 17),),
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //                   Container(color: const Color(0x6E0075BB),
                                          //                       width: 1,
                                          //                       height: 156),
                                          //                   Expanded(
                                          //                     flex: 1,
                                          //                     child: Column(
                                          //                       children: [
                                          //                         const Text("Closing Balance",
                                          //                           style: TextStyle(
                                          //                               fontWeight: FontWeight.bold,
                                          //                               color: Colors.black,
                                          //                               fontSize: 17),),
                                          //                         const SizedBox(height: 5,),
                                          //                         Text(closingBalance,
                                          //                           style: const TextStyle(
                                          //                               fontWeight: FontWeight.bold,
                                          //                               color: Colors.blue,
                                          //                               fontSize: 17),),
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //                 ],
                                          //               ),
                                          //
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ///Table
                                Padding(
                                  padding: const EdgeInsets.only(left: 24.0,right: 10),
                                  child: SingleChildScrollView(
                                    controller: _horizontalScrollController2,
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, right: 8, bottom: 15, left: 0),

                                      child: Card(
                                        color: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        elevation: 8,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: BorderSide(color: mTextFieldBorder.withOpacity(0.8), width: 1,)),
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ///Header
                                            Container(
                                             // width: typeDropdownValue !=  "Cash Receipt" ? 2360:1760,
                                              width: 2200,
                                              color: Colors.grey[200],
                                              child: const Row(
                                                children: [
                                                  SizedBox(
                                                      width: 150,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text("Item", style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.center,),
                                                      )
                                                  ),
                                                   SizedBox(
                                                      width: 200,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "Business Transaction",
                                                              style: TextStyle(fontSize: 12,
                                                                  fontWeight: FontWeight.bold),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            // Padding(
                                                            //   padding: EdgeInsets.only(top: 4.0,left: 4),
                                                            //   child: Text("*",style: TextStyle(color: Colors.red),),
                                                            // )
                                                          ],
                                                        ),
                                                      )
                                                  ),
                                                   SizedBox(
                                                      width: 140,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "Amount",
                                                              style: TextStyle(fontSize: 12,
                                                                  fontWeight: FontWeight.bold),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 4.0,left: 4),
                                                              child: Text("*",style: TextStyle(color: Colors.red),),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                  ),
                                                   SizedBox(
                                                      width: 150,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text("Customer", style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.bold),
                                                              textAlign: TextAlign.center,),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 4.0,left: 4),
                                                              child: Text("*",style: TextStyle(color: Colors.red),),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                  ),
                                                   SizedBox(
                                                      width: 200,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text("Customer Name", style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.bold),
                                                              textAlign: TextAlign.center,),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 4.0,left: 4),
                                                              child: Text("*",style: TextStyle(color: Colors.red),),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                  ),
                                                   SizedBox(
                                                      width: 250,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text("Text", style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.center,),
                                                      )
                                                  ),
                                                   SizedBox(
                                                      width: 250,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text("Reference", style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.center,),
                                                      )
                                                  ),
                                                  ///TaxCode
                                                  //  SizedBox(
                                                  //     width: 150,
                                                  //     child: Padding(
                                                  //       padding: EdgeInsets.all(8.0),
                                                  //       child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                  //         children: [
                                                  //           Text("Tax Code", style: TextStyle(
                                                  //               fontSize: 12,
                                                  //               fontWeight: FontWeight.bold),
                                                  //             textAlign: TextAlign.center,),
                                                  //
                                                  //         ],
                                                  //       ),
                                                  //     )
                                                  // ),
                                                   SizedBox(
                                                      width: 150,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text("Cost Center", style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.center,),
                                                      )
                                                  ),
                                                   SizedBox(
                                                      width: 150,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text("Profit Center",
                                                          style: TextStyle(fontSize: 12,
                                                              fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.center,),
                                                      )
                                                  ),
                                                   SizedBox(
                                                      width: 250,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text("Assignment", style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.center,),
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ///Table
                                            SizedBox(
                                             // width: typeDropdownValue !=  "Cash Receipt"  ? 2360:1760,
                                              width: 2200,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: customerTable.length,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  TextEditingController amountController = TextEditingController();
                                                  TextEditingController textController = TextEditingController();
                                                  TextEditingController referenceController = TextEditingController();
                                                  TextEditingController assignmentController = TextEditingController();
                                                  TextEditingController customerCont = TextEditingController();
                                                  try{
                                                    customerCont.text=customerTable[index]["GLAccount"];

                                                    customerCont.selection = TextSelection.fromPosition(TextPosition(offset: customerCont.text.length,));
                                                  }
                                                  catch(e){

                                                  }

                                                  amountController.text = (customerTable[index]["amount"] ?? "").toString();
                                                  textController.text = (customerTable[index]["text"] ?? "").toString();
                                                  referenceController.text = (customerTable[index]["reference"] ?? "").toString();
                                                  assignmentController.text = (customerTable[index]["assignment"] ?? "").toString();

                                                  amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                                                  textController.selection = TextSelection.fromPosition(TextPosition(offset: textController.text.length));
                                                  referenceController.selection = TextSelection.fromPosition(TextPosition(offset: referenceController.text.length));
                                                  assignmentController.selection = TextSelection.fromPosition(TextPosition(offset: assignmentController.text.length));

                                                  return Container(
                                                    color: Colors.grey[50],
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 8.0),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                              width: 150,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text("${index + 1}",
                                                                  style: const TextStyle(fontSize: 12,
                                                                      fontWeight: FontWeight.bold),
                                                                  textAlign: TextAlign.center,),
                                                              )
                                                          ),
                                                          SizedBox(
                                                            width: 200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextFormField(
                                                                style: const TextStyle(fontSize: 14),
                                                                //controller: amountController,
                                                                decoration: Utils.customerFieldDecoration(
                                                                  hintText: 'Enter Business Transaction',
                                                                  controller: amountController,
                                                                ),
                                                                onChanged: (val){

                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 140,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextFormField(
                                                                style: const TextStyle(fontSize: 14),
                                                                controller: amountController,
                                                                decoration: Utils.customerFieldDecoration(
                                                                  hintText: 'Enter Amount',
                                                                  controller: amountController,
                                                                ),
                                                                keyboardType: TextInputType.number,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                                                ],
                                                                onChanged: (value) {
                                                                  // Remove commas for calculations
                                                                  String rawValue = value.replaceAll(',', '');
                                                                  customerTable[index]["amount"] = rawValue;

                                                                  if (customerTable[index]["taxValue"] != null) {
                                                                    String taxAmount = (double.parse(customerTable[index]["taxValue"].toString()) *
                                                                        double.parse(rawValue) /
                                                                        100)
                                                                        .toStringAsFixed(2);
                                                                    String totalAmount =
                                                                    (double.parse(taxAmount) + double.parse(rawValue))
                                                                        .toStringAsFixed(2);
                                                                    customerTable[index]["taxAmount"] = taxAmount;
                                                                    customerTable[index]["totalAmount"] = totalAmount;
                                                                  } else {
                                                                    customerTable[index]["totalAmount"] = rawValue;
                                                                  }

                                                                  // Update controller to show formatted value
                                                                  amountController.value = TextEditingValue(
                                                                    text: _formatWithCommas(rawValue),
                                                                    selection: TextSelection.collapsed(
                                                                        offset: _formatWithCommas(rawValue).length),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: 150,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: CustomTextFieldSearch(
                                                                  showAdd: false,
                                                                  decoration: Utils.customerFieldDecoration(hintText: 'Search Gl', controller: customerCont),
                                                                  controller: customerCont,
                                                                  future: (){
                                                                    return getCustomerGLCodes();
                                                                  },
                                                                  getSelectedValue: (SearchCustomerGL v){
                                                                    customerTable[index]["GLAccount"] = v.label;
                                                                    setState(() {
                                                                      customerTable[index]["customerName"] = v.customerName;
                                                                    });
                                                                  },
                                                                  onChanged: (val){

                                                                  },
                                                                ),
                                                              )
                                                          ),
                                                          SizedBox(
                                                            width: 200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextFormField(
                                                                readOnly: true,
                                                                style: const TextStyle(fontSize: 14),
                                                                controller: TextEditingController(text: customerTable[index]["customerName"]),
                                                                decoration: Utils.customerFieldDecoration(
                                                                  hintText: 'Enter Customer Name',
                                                                  controller: TextEditingController(text: customerTable[index]["customerName"]),
                                                                ),
                                                                onChanged: (val){

                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: 250,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: TextFormField(
                                                                  style: const TextStyle(
                                                                      fontSize: 14),
                                                                  controller: textController,
                                                                  decoration: Utils
                                                                      .customerFieldDecoration(
                                                                      hintText: 'Enter Text',
                                                                      controller: textController),
                                                                  onChanged: (value) {
                                                                    customerTable[index]["text"] = value;
                                                                  },
                                                                ),
                                                              )
                                                          ),
                                                          SizedBox(
                                                              width: 250,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: TextFormField(
                                                                  style: const TextStyle(
                                                                      fontSize: 14),
                                                                  controller: referenceController,
                                                                  decoration: Utils
                                                                      .customerFieldDecoration(
                                                                      hintText: 'Enter Reference',
                                                                      controller: referenceController),
                                                                  onChanged: (value) {
                                                                    customerTable[index]["reference"] =
                                                                        value;
                                                                  },
                                                                ),
                                                              )
                                                          ),
                                                          ///TaxCode
                                                          // SizedBox(
                                                          //   width: 150,
                                                          //   child: Padding(
                                                          //     padding: const EdgeInsets.all(8.0),
                                                          //     child: LayoutBuilder(
                                                          //       builder: (BuildContext context,
                                                          //           BoxConstraints constraints) {
                                                          //         return CustomPopupMenuButton(
                                                          //           elevation: 4,
                                                          //           decoration: Utils
                                                          //               .customPopupDecoration(
                                                          //             hintText: customerTable[index]["taxCode"] ==
                                                          //                 ""
                                                          //                 ? "Select"
                                                          //                 : customerTable[index]["taxCode"],
                                                          //           ),
                                                          //           itemBuilder: (
                                                          //               BuildContext context) {
                                                          //             return taxCode.entries.map((
                                                          //                 entry) {
                                                          //               return CustomPopupMenuItem(
                                                          //                 value: entry.key,
                                                          //                 // Use the key to identify selection
                                                          //                 text: entry.key,
                                                          //                 // Display the key (e.g., "AA", "AB")
                                                          //                 child: Text(
                                                          //                     "${entry.key} (${entry
                                                          //                         .value}%)"), // Show key and value
                                                          //               );
                                                          //             }).toList();
                                                          //           },
                                                          //           onSelected: (selectedKey) {
                                                          //             String selectedValue = taxCode[selectedKey]!
                                                          //                 .toString(); // Get the value from the key
                                                          //             print("Selected Key: $selectedKey, Value: $selectedValue");
                                                          //             customerTable[index]["taxCode"] = selectedKey; // Update with the selected key
                                                          //             customerTable[index]["taxValue"] = selectedValue;
                                                          //             if(customerTable[index]["amount"]!=""&& customerTable[index]["amount"]!=null){
                                                          //               String taxAmount = (double.parse(customerTable[index]["taxValue"].toString()) * double.parse(customerTable[index]["amount"].toString()) / 100).toStringAsFixed(2);
                                                          //               String totalAmount = (double.parse(taxAmount.toString()) + double.parse(customerTable[index]["amount"].toString())).toStringAsFixed(2);
                                                          //               customerTable[index]["taxAmount"] = taxAmount;
                                                          //               customerTable[index]["totalAmount"] = totalAmount;
                                                          //             }
                                                          //             // else{
                                                          //             //   tableOne[index]["totalAmount"] = tableOne[index]["taxAmount"] ;
                                                          //             // }
                                                          //
                                                          //
                                                          //
                                                          //             setState(() {
                                                          //
                                                          //             });
                                                          //           },
                                                          //           onCanceled: () {
                                                          //             // Handle cancel if needed
                                                          //           },
                                                          //           hintText: "",
                                                          //           childWidth: constraints.maxWidth,
                                                          //           child: Container(),
                                                          //         );
                                                          //       },
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          SizedBox(
                                                              width: 150,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: LayoutBuilder(
                                                                  builder: (BuildContext context,
                                                                      BoxConstraints constraints) {
                                                                    return CustomPopupMenuButton(
                                                                      elevation: 4,
                                                                      decoration: Utils
                                                                          .customPopupDecoration(
                                                                        hintText: customerTable[index]["CostCenter"] ==
                                                                            ""
                                                                            ? "Select"
                                                                            : customerTable[index]["CostCenter"],),
                                                                      itemBuilder: (
                                                                          BuildContext context) {
                                                                        return costCenterList.map((
                                                                            value) {
                                                                          return CustomPopupMenuItem(
                                                                              value: value,
                                                                              text: value,
                                                                              child: Container()
                                                                          );
                                                                        }).toList();
                                                                      },
                                                                      onSelected: (value) {
                                                                        setState(() {
                                                                          customerTable[index]["CostCenter"] =
                                                                              value;
                                                                        });
                                                                      },
                                                                      onCanceled: () {

                                                                      },
                                                                      hintText: "",
                                                                      childWidth: constraints
                                                                          .maxWidth,
                                                                      child: Container(),
                                                                    );
                                                                  },
                                                                ),
                                                              )
                                                          ),
                                                          SizedBox(
                                                              width: 150,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: LayoutBuilder(
                                                                  builder: (BuildContext context,
                                                                      BoxConstraints constraints) {
                                                                    return CustomPopupMenuButton(
                                                                      elevation: 4,
                                                                      decoration: Utils
                                                                          .customPopupDecoration(
                                                                        hintText: customerTable[index]["ProfitCenter"] ==
                                                                            ""
                                                                            ? "Select"
                                                                            : customerTable[index]["ProfitCenter"],),
                                                                      itemBuilder: (
                                                                          BuildContext context) {
                                                                        return profitCenterList.map((
                                                                            value) {
                                                                          return CustomPopupMenuItem(
                                                                              value: value,
                                                                              text: value,
                                                                              child: Container()
                                                                          );
                                                                        }).toList();
                                                                      },
                                                                      onSelected: (value) {
                                                                        setState(() {
                                                                          customerTable[index]["ProfitCenter"] =
                                                                              value;
                                                                        });
                                                                      },
                                                                      onCanceled: () {

                                                                      },
                                                                      hintText: "",
                                                                      childWidth: constraints
                                                                          .maxWidth,
                                                                      child: Container(),
                                                                    );
                                                                  },
                                                                ),
                                                              )
                                                          ),
                                                          SizedBox(
                                                              width: 250,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: TextFormField(
                                                                  style: const TextStyle(
                                                                      fontSize: 14),
                                                                  controller: assignmentController,
                                                                  decoration: Utils
                                                                      .customerFieldDecoration(
                                                                      hintText: 'Enter Assignment',
                                                                      controller: assignmentController),
                                                                  onChanged: (value) {
                                                                    customerTable[index]["assignment"] =
                                                                        value;
                                                                  },
                                                                ),
                                                              )
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20),
                                                            child: SizedBox(
                                                              width: 100,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  if(customerTable.length == index+1)
                                                                    IconButton(
                                                                        onPressed: () {

                                                                          if(amountController.text.isEmpty){
                                                                            if(mounted) {
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return AlertDialog(
                                                                                    title: const Text('Please Enter Amount'),
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
                                                                          else {
                                                                            setState(() {
                                                                              customerTable.add({
                                                                                "item": "",
                                                                                "amount": "",
                                                                                "GLAccount": "",
                                                                                "houseBank": "",
                                                                                "accountId": "",
                                                                                "text": "",
                                                                                "reference": "",
                                                                                "taxCode": "",
                                                                                "CostCenter": "",
                                                                                "ProfitCenter": "",
                                                                                "assignment": "",
                                                                              });
                                                                            });
                                                                          }
                                                                        },
                                                                        icon: const Icon(
                                                                          Icons.add_circle,
                                                                          color: Colors.blue,)
                                                                    ),
                                                                  IconButton(
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          if (customerTable.length > 1) {
                                                                            customerTable.removeAt(index);
                                                                          } else {
                                                                            Utils.snackBar(
                                                                                "At least one row must remain.",
                                                                                context);
                                                                          }
                                                                        });
                                                                      },
                                                                      icon: const Icon(Icons.delete,
                                                                        color: Colors.red,)
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),))

              ),
            ]),
      ),

    );
  }
  String openingBalance = "";
  double openingTotal =0;
  double closingTotal =0;
  String openingCurrency = "";
  String closingBalance = "";
  String closingCurrency = "";
  Future<void> triggerBalanceApis() async{
    if(companyDropdownValue != "--Select--" && cashDropdownValue != "--Select--"){
      try{
        String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
        String yesterday = DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(const Duration(days: 1)));

        setState(() {
          isLoading = true;
        });

        var openingResponse = await getOpeningBalance(yesterday, companyDropdownValue);
        var closingResponse = await getClosingBalance(today, companyDropdownValue);

        if(openingResponse != null && closingResponse != null){
          bool matchFound = false;
          for(var item in openingResponse){
            if(item["Account"] == cashDropdownValue){
              matchFound = true;
              final String amountString = item["AMOUNT"] ?? "0";
              openingCurrency = item["CompanyCodeCurrency"];
              print(openingCurrency);

              openingTotal = double.tryParse(amountString) ?? 0.0;
              // Parse the string to a double
              final double amount = double.tryParse(amountString) ?? 0.0;

              // Format the parsed double
              final formattedAmount = NumberFormat("#,##0.00", "en_US").format(amount);
              openingBalance = formattedAmount;
              break;
            }
          }

          for(var item in closingResponse){
            if(item["Account"] == cashDropdownValue){
              matchFound = true;
              final String amountString = item["AMOUNT"] ?? "0";

              // Parse the string to a double
              final double amount = double.tryParse(amountString) ?? 0.0;
              closingTotal = double.tryParse(amountString) ?? 0.0;
              // Format the parsed double
              final formattedAmount = NumberFormat("#,##0.00", "en_US").format(amount);
              closingBalance = formattedAmount;
              break;
            }
          }
          setState(() {
            isShowBalance = matchFound;
            isLoading = false;
          });
        }else{
          setState(() {
            isShowBalance = false;
            isLoading = false;
          });
        }
      }catch(e){
        log("Error calling API: $e");
        setState(() {
          isShowBalance = false;
          isLoading = false;
        });
      }
    }
  }
  Future getCustomerGLCodes()async{
    List list=[];
    for(int i=0;i<glAccList.length;i++){
      list.add(SearchCustomerGL.fromJson(glAccList[i]));
    }
    return list;
  }
  Future getHeaderGLCodes()async{
    List list=[];
    for(int i=0;i<cashJournalList.length;i++){
      list.add(SearchGL.fromJson(cashJournalList[i]));
    }
    return list;
  }
  String _formatWithCommas(String value) {
    if (value.isEmpty) return '';
    final parts = value.split('.');
    final intPart = parts[0].replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    return parts.length > 1 ? '$intPart.${parts[1]}' : intPart;
  }
}


class SearchGL {
  final String label;
  dynamic value;

  SearchGL({required this.label, this.value});

  factory SearchGL.fromJson( data) {
    return SearchGL(label: data, value:data);
  }
}

class SearchCustomerGL {
  final String customer;
  final String customerName;
  final String label;
  // dynamic value;
  SearchCustomerGL({
      required this.customer,
      required this.customerName,
      required this.label
      // this.value
  });
  factory SearchCustomerGL.fromJson( data) {
    return SearchCustomerGL(
         customer: data['Customer'].toString(),
         customerName: data['CustomerName'].toString(),
        label: data['Customer'].toString(),
        // value:data
    );
  }
}

