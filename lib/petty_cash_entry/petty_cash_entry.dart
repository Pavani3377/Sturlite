import 'dart:developer';
import 'dart:html';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sturlite/login_screen.dart';
import 'package:sturlite/petty_cash_entry/petty_cash_api.dart';
import 'package:sturlite/utils/static_data.dart';
import 'package:sturlite/widgets/customButtons.dart';
import 'package:sturlite/widgets/custom_popup_dropdown/custom_popup_dropdown.dart';
import 'package:toastification/toastification.dart';
import 'package:xml/xml.dart' as xml;
import '../utils/m_colors.dart';
import '../utils/utils.dart';
import '../widgets/custom_message/toastification_msg.dart';

class PettyCashEntry extends StatefulWidget {
  const PettyCashEntry({super.key});

  @override
  State<PettyCashEntry> createState() => _PettyCashEntryState();
}

class _PettyCashEntryState extends State<PettyCashEntry> {
  bool isLoading = false;
  bool isShowBalance = false;
  bool isShowTable1 = false;
  bool isShowTable2 = false;

  late double screenWidth;
  late double screenHeight;

  String companyDropdownValue = "--Select--";
  String cashDropdownValue = "";
  String cashJournalName = "";
  String typeDropdownValue = "--Select--";

  FocusNode postingDateNode = FocusNode();
  FocusNode invoicingDateNode = FocusNode();
  FocusNode referenceNode = FocusNode();

  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();
  final _horizontalScrollController2 = ScrollController();

  final TextEditingController postingDateController = TextEditingController();
  final TextEditingController invoicingDateController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  TextEditingController searchCashJournalCodeCont = TextEditingController();
  TextEditingController searchCashJournalNameController = TextEditingController();
  TextEditingController searchGlCodeCont = TextEditingController();
  TextEditingController searchGlNameCont = TextEditingController();
  TextEditingController searchTaxCodeCont = TextEditingController();
  TextEditingController searchTaxNameCont = TextEditingController();
  TextEditingController searchCustomerCodeCont = TextEditingController();
  TextEditingController searchCustomerNameCont = TextEditingController();

  List houseBankList = [];
  List<String> accountIdBankList = [];
  List glAccList = [];
  List glNameList = [];
  List taxCodeNamesList = [];
  List costCenterList = [];
  List costCenterNameList = [];
  List<String> profitCenterList = [];
  List customerList = [];

  ///For Show Dialog.
  List displayCashJournalList = [];
  List displayGLList = [];
  List displayTaxCodesList = [];
  List displayCostCenterList=[];
  List displayCustomerList = [];
  List initialJournalList=[];
  ///Cash Journal Values Based On Transaction Type.
  cashJournalValues(){
    setState(() {
      if(typeDropdownValue == "Cash Receipt"){
        displayCashJournalList = initialJournalList;
        // print('--------cashReceiptValues-------');
        // print(cashReceiptValues);
      }
      if(typeDropdownValue == "Cash Payment"){
        displayCashJournalList = initialJournalList;
            // cashPaymentValues;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeEmpty();
    _fetchApiResponse();
    // displayCashJournalList = cashJournalList2;
    displayTaxCodesList = taxCodesDELine;
  }
  @override
  void dispose() {
    for (var controller in glNameList) {
      controller.dispose();
    }

    super.dispose();
  }

  Color logYesTextColor = Colors.black;
  Color logNoTextColor = Colors.black;
  Future<void> _fetchApiResponse() async{
    setState(() {
      isLoading = true;
    });
    try{
      var cashJournalHeader = await getCashJournal(typeDropdownValue);
      // var glAcc  = await getGlAccount();
      var glAcc=await getGlAccount(typeDropdownValue);
      var houseBank = await getHouseBank();
      // var costCenter = await getCostCenter();
      var costCenter=await getGlAccount(typeDropdownValue);
      var profitCenter = await getProfitCenter();
      var customer = await getCustomerGLAccount();

      if(cashJournalHeader != null){
        setState(() {

          initialJournalList = cashJournalHeader.map((item) => {
            "Code": item["Journal_Accounts"],
            "Name": item['CashJournalDesc'],
            // "Type": item['TypeOfTransaction_Text'],
          }).toSet().toList();

          displayCashJournalList = initialJournalList;
        });
      } else{
        log('No data found for GL Account.');
      }

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
          glAccList = glAcc.map((item) => {
           "GLAccount": item["GLAccount"].toString(),
           "GLAccountName": item['AccountName'].toString(),

            "CostCenter": item["CostCenter"].toString(),
            "CostCenterName": item["CostCenterName"].toString()
          }).toSet().toList();

          displayGLList = glAccList;
        });
      } else{
        log('No data found for GL Account.');
      }

      if(costCenter != null){
        setState(() {
          // print('--------costCenter-----');
          // print(costCenter);

          //OLD
          //costCenterList = costCenter.map<String>((item) => item["CostCenter"].toString() ).toSet().toList();

          costCenterList = costCenter.map((item) =>
          {
            // "CostCenter": item["CostCenter"].toString(),
            // "CostCenterName": item["CostCenterName"].toString()
          } ).toSet().toList();
          displayCostCenterList = costCenterList;

        });
      } else{
        log('No data found for Cost Center.');
      }

      if(profitCenter != null){
        setState(() {
          profitCenterList = profitCenter.map<String>((item) => item["ProfitCenter"].toString() ).toSet().toList();
        });
      } else{
        log('No data found for Profit Center.');
      }

      if(customer !=null){
        setState(() {
          customerList = customer.map((item)=>{
          "Customer":item["Customer"].toString(),
          "CustomerName":item['CustomerName'].toString()
          }).toSet().toList();

          displayCustomerList = customerList;
        });
      }
      else{
        log('No data found for Customer.');
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
  Future getCustomerGLCodes()async{
    List list=[];
    for(int i=0;i<customerList.length;i++){
      list.add(SearchCustomerGL.fromJson(customerList[i]));
    }
    return list;
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
        title: const Text("Petty Cash Entry",
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

                    ///New
                    onTap: () async {
                      bool error = false;
                      if(companyDropdownValue =="--Select--"){
                        showToast(
                          context: context,
                          title: 'Company Code',
                          description: 'Company Code Is Required',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      else if(typeDropdownValue =="--Select--" || typeDropdownValue == ""){
                        showToast(
                          context: context,
                          title: 'Type Of Transaction',
                          description: 'Type Of Transaction Is Required',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      else if(cashDropdownValue =="--Search Cash Journal--" || cashDropdownValue == ""){
                        showToast(
                          context: context,
                          title: 'Cash Journal',
                          description: 'Cash Journal Is Required',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      else if (postingDateController.text.isEmpty) {
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
                      // else if (postingDateController.text != invoicingDateController.text) {
                      //   showToast(
                      //     context: context,
                      //     title: 'Posting Date & Invoicing Date',
                      //     description: 'Posting Date & Invoicing Date Should Be Same.',
                      //     type: ToastificationType.error,
                      //     icon: Icons.clear,
                      //   );
                      // }
                      else{
                        double tempTotal =0;
                        Map inputData = {
                          "companyCode": companyDropdownValue,
                          "cashJournal": cashDropdownValue,
                          "typeOfTrans": typeDropdownValue,
                          "postingDate": postingDateController.text,
                          "invoiceDate": postingDateController.text,
                          'headerTotal':"0",
                          "table": (typeDropdownValue =="Customer Receipt")? customerTable : tableOne,

                        };
                        print('--------Table-------');
                        print(inputData);
                        // print(inputData['table']);
                        ///Error For Customer Receipt.
                        if(typeDropdownValue == "Customer Receipt" ){
                          for(int i=0;i<inputData['table'].length;i++){
                            if(inputData['table'][i]['costCenter'] == "" || inputData['table'][i]['costCenter'] == null){
                              error = true;
                            }
                          }
                        }

                        else {
                          ///OLD
                          // for(int i=0;i<inputData['table'].length;i++){
                          //   if(inputData['table'][i]['CostCenter'] == "" || inputData['table'][i]['CostCenter'] == null){
                          //     error = true;
                          //   }
                          // }

                          ///Based On (Cash Receipt and Cash Payment).
                           if(typeDropdownValue == "Cash Receipt"){
                            for(int i=0;i<inputData['table'].length;i++){
                              if(inputData['table'][i]['CostCenter'] == "" || inputData['table'][i]['CostCenter'] == null){
                                error = false;
                              }
                            }
                          }

                          if(typeDropdownValue == "Cash Payment"){
                            for(int i=0;i<inputData['table'].length;i++){
                              if(inputData['table'][i]['CostCenter'] == "" || inputData['table'][i]['CostCenter'] == null){
                                error = true;
                              }
                            }
                          }
                        }

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

                          if(typeDropdownValue =="Cash Payment"){
                            ///Through error Total amount is grater than Closing balance.
                            // if(tempTotal>closingTotal){
                            //   if(mounted) {
                            //     showDialog(
                            //       context: context,
                            //       builder: (BuildContext context) {
                            //         return AlertDialog(
                            //           title: const Text('Total Amount is greater than closing balance'),
                            //           actions: <Widget>[
                            //             TextButton(
                            //               onPressed: () {
                            //                 // Close the AlertDialog
                            //                 Navigator.of(context).pop();
                            //               },
                            //               child: const Text('OK'),
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //     );
                            //   }
                            // }
                           // else{
                              final builder = xml.XmlBuilder();
                              builder.element('soapenv:Envelope', namespaces: {
                                'http://schemas.xmlsoap.org/soap/envelope/':'soapenv',
                                'http://sap.com/xi/SAPSCORE/SFIN':'sfin',
                              }, nest: () {
                                builder.element('soapenv:Header');
                                builder.element('soapenv:Body', nest: () {
                                  builder.element('sfin:JournalEntryBulkCreateRequest', nest: () {
                                    // MessageHeader
                                    builder.element('MessageHeader', nest: () {
                                      builder.element('ID', nest: 'MSG_JournalEntryCreateConfi');
                                      builder.element('CreationDateTime', nest: '${inputData['postingDate']}T00:00:00.107Z');
                                    });

                                    // JournalEntryCreateRequest
                                    builder.element('JournalEntryCreateRequest', nest: () {
                                      // Sub-MessageHeader
                                      builder.element('MessageHeader', nest: () {
                                        builder.element('ID', nest: 'SUB_MSG_JournalEntryCreateConfi');
                                        builder.element(
                                            'CreationDateTime', nest: '${inputData['postingDate']}T00:00:00.107Z');
                                      });

                                      // JournalEntry
                                      builder.element('JournalEntry', nest: () {
                                        builder.element('OriginalReferenceDocumentType', nest: 'BKPFF');
                                        builder.element('BusinessTransactionType', nest: 'RFBU');
                                        builder.element('AccountingDocumentType', nest: 'SA');
                                        builder.element('CompanyCode', nest: inputData['companyCode']);
                                        builder.element('DocumentDate', nest: inputData['invoiceDate']);
                                        builder.element('PostingDate', nest: inputData['postingDate']);
                                        builder.element('TaxDeterminationDate', nest: inputData['postingDate']);
                                        builder.element('CreatedByUser', nest: 'INTEGRATION');
                                        ///New Added.
                                          builder.element('DocumentReferenceID', nest: referenceController.text);

                                        builder.element('Item', nest: () {
                                          builder.element('GLAccount', nest: inputData['cashJournal']);
                                          builder.element(
                                              'AmountInTransactionCurrency',
                                              attributes: {'currencyCode': 'INR'},
                                              nest:  typeDropdownValue == "Cash Receipt"  ? "${inputData['headerTotal']}":"-${inputData['headerTotal']}");
                                          builder.element('DebitCreditCode', nest: typeDropdownValue == "Cash Receipt" ? "S":'H');
                                          builder.element('HouseBank', nest: '');
                                          builder.element('HouseBankAccount', nest: '');
                                        });
                                        // Items
                                        for (var i = 0; i < inputData['table'].length; i++) {
                                          final item = inputData['table'][i];
                                          builder.element('Item', nest: () {
                                            builder.element(
                                                'ReferenceDocumentItem', nest: (i + 1).toString());
                                            builder.element('GLAccount', nest: item['GLAccount'] ?? '');
                                            builder.element(
                                                'AmountInTransactionCurrency',
                                                attributes: {'currencyCode': 'INR'},
                                                nest: typeDropdownValue == "Cash Receipt" ? "-${item['amount'].toString()}":item['amount'].toString());
                                            builder.element(
                                                'DebitCreditCode',
                                                nest: (typeDropdownValue == "Cash Receipt" ? "H":'S'));

                                            ///Newly added.
                                            builder.element('DocumentItemText', nest: '${item['text']}');
                                            builder.element('AssignmentReference', nest: '${item['assignment']}');

                                            // Add Tax
                                            if(item['taxCode']!=null && item['taxCode']!=""  ) {
                                              builder.element('Tax', nest: () {
                                                builder.element('TaxCode', nest: item['taxCode']); // Replace 'GB' with dynamic value if available
                                                builder.element('TaxJurisdiction', nest: ''); // Empty or dynamic value
                                                builder.element('TaxItemGroup', nest: '001'); // Replace '001' with dynamic value if available
                                              });
                                            }

                                            // Add AccountAssignment
                                            builder.element('AccountAssignment', nest: () {
                                              builder.element('CostCenter', nest: item['CostCenter'] ?? '');
                                              builder.element('ProfitCenter', nest: item['ProfitCenter'] ?? '');
                                            });

                                            if (item['houseBank'] != null  ) {
                                              builder.element('HouseBank', nest: item['accountId']);
                                              builder.element('HouseBankAccount', nest: item['accountId']);
                                            }


                                          });
                                        }


                                        for (var i = 0; i < inputData['table'].length; i++) {
                                          final item = inputData['table'][i];
                                          if(item['taxCode']!=null &&  item['taxCode']!="") {
                                            builder.element('ProductTaxItem', nest: () {
                                              builder.element('TaxCode', nest: item['taxCode']);
                                              builder.element('TaxItemGroup', nest: '001');
                                              builder.element('TaxItemClassification', nest: '');
                                              builder.element('DebitCreditCode', nest: 'S');
                                              builder.element('TaxJurisdiction', nest: '');
                                              builder.element('AmountInTransactionCurrency', attributes: {'currencyCode': 'INR'}, nest: item['taxAmount'].toString());
                                              builder.element('TaxBaseAmountInTransCrcy', attributes: {'currencyCode': 'INR'}, nest: item['amount'].toString());
                                            });
                                          }
                                        }
                                      });
                                    });
                                  });
                                });
                              });

                              // Convert XML builder to a string
                              final xmlString = builder.buildDocument().toXmlString(pretty: true);
                              // print(xmlString);
                              bool returnValue = await postData(xmlString,context,mounted);
                              if(returnValue){
                                tableOne =[];
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
                                makeEmpty();
                                // tableOne = [
                                //   {
                                //     "item": "",
                                //     "amount": "",
                                //     "GLAccount": "",
                                //     "houseBank": "",
                                //     "accountId": "",
                                //     "text": "",
                                //     "reference": "",
                                //     "taxCode": "",
                                //     "CostCenter": "",
                                //     "ProfitCenter": "",
                                //     "assignment": "",
                                //   },
                                // ];
                                setState(() {

                                });

                              }
                           // }
                          }
                          else if(typeDropdownValue =="Customer Receipt"){
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
                                      ///New Added.
                                      builder.element('DocumentReferenceID', nest: referenceController.text);

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

                                          ///Newly Added.
                                          builder.element('DocumentItemText', nest: '${customer['text']}');
                                          builder.element('AssignmentReference', nest: '${customer['assignment']}');
                                        });
                                      }
                                    });
                                  });
                                });
                              });
                            });

                            // Convert XML builder to a string
                            final xmlString = builder.buildDocument().toXmlString(pretty: true);
                            print('-----Customer Receipt------');
                            print(xmlString);
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

                              makeEmpty();

                              // customerTable = [
                              //   {
                              //     "item": "",
                              //     "amount": "",
                              //     "GLAccount": "",
                              //     "houseBank": "",
                              //     "accountId": "",
                              //     "text": "",
                              //     "reference": "",
                              //     "taxCode": "",
                              //     "CostCenter": "",
                              //     "ProfitCenter": "",
                              //     "assignment": "",
                              //   },
                              // ];
                              setState(() {

                              });

                            }
                          }
                          else{
                            final builder = xml.XmlBuilder();
                            builder.element('soapenv:Envelope', namespaces: {
                              'http://schemas.xmlsoap.org/soap/envelope/':'soapenv',
                              'http://sap.com/xi/SAPSCORE/SFIN':'sfin',
                            }, nest: () {
                              builder.element('soapenv:Header');
                              builder.element('soapenv:Body', nest: () {
                                builder.element('sfin:JournalEntryBulkCreateRequest', nest: () {
                                  // MessageHeader
                                  builder.element('MessageHeader', nest: () {
                                    builder.element('ID', nest: 'MSG_JournalEntryCreateConfi');
                                    builder.element('CreationDateTime', nest: '${inputData['postingDate']}T00:00:00.107Z');
                                  });

                                  // JournalEntryCreateRequest
                                  builder.element('JournalEntryCreateRequest', nest: () {
                                    // Sub-MessageHeader
                                    builder.element('MessageHeader', nest: () {
                                      builder.element('ID', nest: 'SUB_MSG_JournalEntryCreateConfi');
                                      builder.element(
                                          'CreationDateTime', nest: '${inputData['postingDate']}T00:00:00.107Z');
                                    });

                                    // JournalEntry
                                    builder.element('JournalEntry', nest: () {
                                      builder.element('OriginalReferenceDocumentType', nest: 'BKPFF');
                                      builder.element('BusinessTransactionType', nest: 'RFBU');
                                      builder.element('AccountingDocumentType', nest: 'SA');
                                      builder.element('CompanyCode', nest: inputData['companyCode']);
                                      builder.element('DocumentDate', nest: inputData['invoiceDate']);
                                      builder.element('PostingDate', nest: inputData['postingDate']);
                                      builder.element('TaxDeterminationDate', nest: inputData['postingDate']);
                                      builder.element('CreatedByUser', nest: 'INTEGRATION');
                                      ///New Added. (ML Any One Reference)
                                      builder.element('DocumentReferenceID', nest: referenceController.text);

                                      builder.element('Item', nest: () {
                                        builder.element('GLAccount', nest: inputData['cashJournal']);
                                        builder.element('HouseBank', nest: '');
                                        builder.element(
                                            'AmountInTransactionCurrency',
                                            attributes: {'currencyCode': 'INR'},
                                            // nest:  typeDropdownValue == "Cash Receipt"  ? "${inputData['headerTotal']}":"-${inputData['headerTotal']}");
                                            nest:  "-${inputData['headerTotal']}");

                                        builder.element('DebitCreditCode', nest: "H");

                                        builder.element('HouseBankAccount', nest: '');
                                      });
                                      // Items LINE
                                      for (var i = 0; i < inputData['table'].length; i++) {
                                        final item = inputData['table'][i];
                                        builder.element('Item', nest: () {
                                          builder.element(
                                              'ReferenceDocumentItem', nest: (i + 1).toString());
                                          builder.element('GLAccount', nest: item['GLAccount'] ?? '');
                                          builder.element(
                                              'AmountInTransactionCurrency',
                                              attributes: {'currencyCode': 'INR'},
                                              //OLD
                                              // nest: typeDropdownValue == "Cash Receipt" ? "-${item['amount'].toString()}":item['amount'].toString());

                                              nest:item['amount'].toString() );
                                          builder.element(
                                              'DebitCreditCode',
                                              // nest: (typeDropdownValue == "Cash Receipt" ? "H":'S')
                                              nest: "S"
                                          );
                                          ///New Added.(Text, Reference)
                                          builder.element('DocumentItemText', nest: '${item['text']}');
                                          builder.element('AssignmentReference', nest: '${item['assignment']}');

                                          // Add Tax
                                          if(item['taxCode']!= null && item['taxCode']!="" ) {
                                            builder.element('Tax', nest: () {
                                              builder.element('TaxCode', nest: item['taxCode']); // Replace 'GB' with dynamic value if available
                                              builder.element('TaxJurisdiction', nest: ''); // Empty or dynamic value
                                              builder.element('TaxItemGroup', nest: '001'); // Replace '001' with dynamic value if available
                                            });
                                          }

                                          // Add AccountAssignment
                                          builder.element('AccountAssignment', nest: () {
                                            builder.element('CostCenter', nest: item['CostCenter'] ?? '');
                                            builder.element('ProfitCenter', nest: item['ProfitCenter'] ?? '');
                                          });

                                          if (item['houseBank'] != null) {
                                            builder.element('HouseBank', nest: item['accountId']);
                                            builder.element('HouseBankAccount', nest: item['accountId']);
                                          }


                                        });
                                      }


                                      for (var i = 0; i < inputData['table'].length; i++) {
                                        final item = inputData['table'][i];
                                        if(item['taxCode']!=null &&  item['taxCode']!="") {
                                          builder.element('ProductTaxItem', nest: () {
                                            builder.element('TaxCode', nest: item['taxCode']);
                                            builder.element('TaxItemGroup', nest: '001');
                                            builder.element('TaxItemClassification', nest: '');
                                            builder.element('DebitCreditCode', nest: 'S');
                                            builder.element('TaxJurisdiction', nest: '');
                                            builder.element('AmountInTransactionCurrency', attributes: {'currencyCode': 'INR'}, nest: item['taxAmount'].toString());
                                            builder.element('TaxBaseAmountInTransCrcy', attributes: {'currencyCode': 'INR'}, nest: item['amount'].toString());
                                          });
                                        }
                                      }
                                    });
                                  });
                                });
                              });
                            });

                            // Convert XML builder to a string
                            final xmlString = builder.buildDocument().toXmlString(pretty: true);
                            // print(xmlString);
                            bool returnValue = await postData(xmlString,context,mounted);
                            if(returnValue){
                              tableOne =[];
                              companyDropdownValue ="";
                              cashDropdownValue ="";
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
                              isShowBalance = false;
                              closingCurrency = "";
                              makeEmpty();

                              // tableOne = [
                              //   {
                              //     "item": "",
                              //     "amount": "",
                              //     "GLAccount": "",
                              //     "houseBank": "",
                              //     "accountId": "",
                              //     "text": "",
                              //     "reference": "",
                              //     "taxCode": "",
                              //     "CostCenter": "",
                              //     "ProfitCenter": "",
                              //     "assignment": "",
                              //   },
                              // ];

                              setState(() {

                              });

                            }
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
                              builderHeader(),
                              builderTable(),
                            ],
                          ),
                        ),
                      ),))
            ),
          ]),
      ),
    );
  }
  ///Header
  Widget builderHeader(){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Scrollbar(
        controller: _horizontalScrollController,
        thumbVisibility: screenWidth < 900 ? true : false,
        thickness: 10,
        radius: Radius.zero,
        child: SingleChildScrollView(
          controller: _horizontalScrollController,
          scrollDirection: Axis.horizontal,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: DropdownButton<String>(
                                            padding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
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
                                                cashDropdownValue = "";
                                                typeDropdownValue = value!;
                                                cashJournalValues();

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
                                                makeEmpty();
                                                _fetchApiResponse();

                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: 200,
                                            child: Row(
                                              children: [
                                                Text(typeDropdownValue == "Cash Payment"? "Cash GL" :  "Happay GL"),
                                                const Padding(
                                                  padding: EdgeInsets.only(top: 4.0,left: 4),
                                                  child: Text("*",style: TextStyle(color: Colors.red),),
                                                )

                                              ],
                                            )
                                        ),
                                        ///old
                                        // SizedBox(
                                        //     width: 200,
                                        //     child: CustomTextFieldSearch(
                                        //       showAdd: false,
                                        //       decoration: Utils.searchGl(hintText: '--Search GL--', controller: TextEditingController(text: cashDropdownValue)),
                                        //       controller: TextEditingController(text: cashDropdownValue),
                                        //       future: (){
                                        //         return getHeaderGLCodes();
                                        //       },
                                        //       getSelectedValue: (SearchGL v) async {
                                        //         cashDropdownValue = v.label;
                                        //         if(companyDropdownValue != "--Select--"){
                                        //           await triggerBalanceApis();
                                        //         }
                                        //
                                        //         setState(() {
                                        //
                                        //         });
                                        //         // tableOne[index]["GLAccount"]= v.label;
                                        //
                                        //       },
                                        //
                                        //     )
                                        // ),
                                        ///New.
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: TextField(
                                                controller: TextEditingController(text: cashDropdownValue),
                                                decoration: Utils.searchGl(
                                                  hintText: '--Search Cash Journal--',
                                                  controller: TextEditingController(text: cashDropdownValue),
                                                ),
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => _showDialogCashJournal(),
                                                  ).then((value) async {
                                                    // print('-------Test--------');
                                                    // print(value['glID']);
                                                    // print(value['glName']);
                                                    if (value != null && value is Map) {
                                                      setState(() {
                                                        isLoading = true;
                                                        cashDropdownValue = value['Code'];
                                                        cashJournalName = value['Name'];
                                                        if (companyDropdownValue != "--Select--") {
                                                          triggerBalanceApis();
                                                        }
                                                        isLoading = false;
                                                      });
                                                    }
                                                  });
                                                },
                                                onChanged: (val){
                                                },
                                              ),
                                            ),
                                            if(cashJournalName!= "")
                                              const SizedBox(height:5),
                                            Text(cashJournalName,style:const TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ],)
                            ],
                          ),
                        ),
                        Container(color: const Color(0x6E0075BB),
                            height: cashJournalName != "" ? 215 : 200,

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
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    // const SizedBox(
                                    //     width: 150,
                                    //     child: Row(
                                    //       children: [
                                    //         Text("Invoicing Date"),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(top: 4.0,left: 4),
                                    //           child: Text("*",style: TextStyle(color: Colors.red),),
                                    //         )
                                    //       ],
                                    //     )
                                    // ),
                                    // SizedBox(
                                    //   height: 30,
                                    //   width: 200,
                                    //   child: TextFormField(
                                    //     style: const TextStyle(
                                    //         fontSize: 12),
                                    //     controller: invoicingDateController,
                                    //     showCursor: false,
                                    //     focusNode: invoicingDateNode,
                                    //     decoration: Utils
                                    //         .dateDecoration(
                                    //         hintText: "Invoicing Date"),
                                    //     onTap: () async {
                                    //       DateTime? startDate = await showDatePicker(
                                    //           helpText: "Invoicing Date",
                                    //           context: context,
                                    //           initialDate: DateTime
                                    //               .now(),
                                    //           firstDate: DateTime(1990),
                                    //           lastDate: DateTime(2100)
                                    //       );
                                    //       if (startDate != null) {
                                    //         String formattedDate = DateFormat(
                                    //             'yyyy-MM-dd').format(
                                    //             startDate);
                                    //         invoicingDateController
                                    //             .text = formattedDate;
                                    //       }
                                    //     },
                                    //   ),
                                    // ),
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
                                            Text("Reference"),
                                            // Padding(
                                            //   padding: EdgeInsets.only(top: 4.0,left: 4),
                                            //   child: Text("*",style: TextStyle(color: Colors.red),),
                                            // )
                                          ],
                                        )
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 200,
                                      child: TextFormField(
                                        style: const TextStyle(
                                            fontSize: 12),
                                        controller: referenceController,
                                        showCursor: true,
                                        focusNode: referenceNode,
                                        decoration: Utils.dateDecoration(hintText: "Reference"),
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
              if(isShowBalance && (cashDropdownValue!='' || cashDropdownValue!= "--Select--") )
                SizedBox(width: 600,
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
            ],
          ),
        ),
      ),
    );
  }
  ///Table
  Widget builderTable(){
    return  Padding(
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

                ///For Header.
                if(typeDropdownValue ==  "Cash Receipt")...[
                  Container(
                    width: 900,
                    color: Colors.grey[200],
                    child:   const Row(
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
                            width: 200,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Cash GL", style: TextStyle(
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
                              child: Text("Narration", style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,),
                            )
                        ),

                        // const SizedBox(
                        //     width: 200,
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
                        // SizedBox(
                        //     width: 150,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           const Text("Cost Center", style: TextStyle(
                        //               fontSize: 12,
                        //               fontWeight: FontWeight.bold),
                        //             textAlign: TextAlign.center,),
                        //
                        //           Padding(
                        //             padding:const EdgeInsets.only(top: 4.0,left: 4),
                        //             child:
                        //             Text(typeDropdownValue=="Cash Receipt"? "" : typeDropdownValue=="Cash Payment"? "*":"",style:const TextStyle(color: Colors.red),),
                        //           )
                        //         ],
                        //       ),
                        //     )
                        // ),
                        // SizedBox(
                        //     width: 150,
                        //     child: Padding(
                        //       padding: EdgeInsets.all(8.0),
                        //       child: Text("Profit Center",
                        //         style: TextStyle(fontSize: 12,
                        //             fontWeight: FontWeight.bold),
                        //         textAlign: TextAlign.center,),
                        //     )
                        // ),
                        // SizedBox(
                        //     width: 250,
                        //     child: Padding(
                        //       padding: EdgeInsets.all(8.0),
                        //       child: Text("Assignment", style: TextStyle(
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.bold),
                        //         textAlign: TextAlign.center,),
                        //     )
                        // ),
                      ],
                    ),
                  ),
                ],
                if(typeDropdownValue ==  "Customer Receipt")...[
                  Container(
                    width: 2200,
                    color: Colors.grey[200],
                    child: const Row(children: [
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
                          width: 200,
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
                          width: 200,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Narration", style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                          )
                      ),
                      ///Reference.
                      // SizedBox(
                      //     width: 200,
                      //     child: Padding(
                      //       padding: EdgeInsets.all(8.0),
                      //       child: Text("Reference", style: TextStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold),
                      //         textAlign: TextAlign.center,),
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
                          width: 200,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Assignment", style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                          )
                      ),
                    ]),
                  ),
                ],
                if(typeDropdownValue !=  "Cash Receipt" && typeDropdownValue !=  "Customer Receipt")...[
                  Container(
                    width: 1100,
                    color: Colors.grey[200],
                    child:  Row(children: [
                      const SizedBox(
                          width: 150,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Item", style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                          )
                      ),
                      const SizedBox(
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
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(typeDropdownValue == "Cash Payment"? "Expanses GL" :  "Cash GL", style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,),
                                const Padding(
                                  padding: EdgeInsets.only(top: 4.0,left: 4),
                                  child: Text("*",style: TextStyle(color: Colors.red),),
                                )
                              ],
                            ),
                          )
                      ),
                      ///Commented (House Bank, Account ID)
                      // SizedBox(
                      //     width: 250,
                      //     child: Padding(
                      //       padding: EdgeInsets.all(8.0),
                      //       child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text("House Bank", style: TextStyle(
                      //               fontSize: 12,
                      //               fontWeight: FontWeight.bold),
                      //             textAlign: TextAlign.center,),
                      //           // if(typeDropdownValue !=  "Cash Receipt")
                      //           //   const Padding(
                      //           //     padding: EdgeInsets.only(top: 4.0,left: 4),
                      //           //     child: Text("*",style: TextStyle(color: Colors.red),),
                      //           //   )
                      //         ],
                      //       ),
                      //     )
                      // ),
                      // SizedBox(
                      //     width: 150,
                      //     child: Padding(
                      //       padding: EdgeInsets.all(8.0),
                      //       child: Text("Account ID", style: TextStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold),
                      //         textAlign: TextAlign.center,),
                      //     )
                      // ),
                      const SizedBox(
                          width: 250,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Narration", style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,),
                          )
                      ),
                      ///Reference.
                      // SizedBox(
                      //     width: 250,
                      //     child: Padding(
                      //       padding: EdgeInsets.all(8.0),
                      //       child: Text("Reference", style: TextStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold),
                      //         textAlign: TextAlign.center,),
                      //     )
                      // ),
                      // const SizedBox(
                      //     width: 200,
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
                      const SizedBox(
                          width: 150,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Cost Center", style: TextStyle(
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
                      // const SizedBox(
                      //     width: 150,
                      //     child: Padding(
                      //       padding: EdgeInsets.all(8.0),
                      //       child: Text("Profit Center",
                      //         style: TextStyle(fontSize: 12,
                      //             fontWeight: FontWeight.bold),
                      //         textAlign: TextAlign.center,),
                      //     )
                      // ),
                      // const SizedBox(
                      //     width: 250,
                      //     child: Padding(
                      //       padding: EdgeInsets.all(8.0),
                      //       child: Text("Assignment", style: TextStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold),
                      //         textAlign: TextAlign.center,),
                      //     )
                      // ),
                    ]),
                  ),
                ],

                ///Table.
                if(typeDropdownValue ==  "Cash Receipt")...[
                  SizedBox(
                    width: 900,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tableOne.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        glNameList.add(TextEditingController(text: ""));
                        taxCodeNamesList.add(TextEditingController(text: ""));
                        costCenterNameList.add(TextEditingController(text: ""));

                        TextEditingController amountController = TextEditingController();
                        TextEditingController textController = TextEditingController();
                        // TextEditingController accountIdController = TextEditingController();
                        TextEditingController referenceController = TextEditingController();
                        TextEditingController assignmentController = TextEditingController();
                        TextEditingController hsnController = TextEditingController();
                        try{
                          hsnController.text=tableOne[index]["GLAccount"];

                          hsnController.selection = TextSelection.fromPosition(TextPosition(offset: hsnController.text.length,));
                        }
                        catch(e){

                        }

                        amountController.text =
                            (tableOne[index]["amount"] ?? "").toString();
                        textController.text =
                            (tableOne[index]["text"] ?? "").toString();
                        referenceController.text =
                            (tableOne[index]["reference"] ?? "")
                                .toString();
                        assignmentController.text =
                            (tableOne[index]["assignment"] ?? "")
                                .toString();

                        amountController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: amountController.text.length));
                        textController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: textController.text.length));
                        referenceController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: referenceController.text.length));
                        assignmentController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: assignmentController.text
                                    .length));
                        return Container(
                          color: Colors.grey[50],
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        tableOne[index]["amount"] = rawValue;

                                        if (tableOne[index]["taxValue"] != null) {
                                          String taxAmount = (double.parse(tableOne[index]["taxValue"].toString()) *
                                              double.parse(rawValue) /
                                              100)
                                              .toStringAsFixed(2);
                                          String totalAmount =
                                          (double.parse(taxAmount) + double.parse(rawValue))
                                              .toStringAsFixed(2);
                                          tableOne[index]["taxAmount"] = taxAmount;
                                          tableOne[index]["totalAmount"] = totalAmount;
                                        } else {
                                          tableOne[index]["totalAmount"] = rawValue;
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
                                ///Old
                                // SizedBox(
                                //     width: 150,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: CustomTextFieldSearch(
                                //         showAdd: false,
                                //         decoration: Utils.customerFieldDecoration(hintText: 'Search Gl', controller: hsnController),
                                //         controller: hsnController,
                                //         future: (){
                                //           return getGLCodes();
                                //         },
                                //         getSelectedValue: (SearchGL v){
                                //
                                //           tableOne[index]["GLAccount"]= v.label;
                                //
                                //         },
                                //
                                //       ),
                                //     )
                                // ),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   width: 200,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: LayoutBuilder(
                                    //       builder: (BuildContext context, BoxConstraints constraints) {
                                    //         return CustomPopupMenuButton(
                                    //           textController: TextEditingController(
                                    //               text: tableOne[index]["GLAccount"] ?? ""),
                                    //           elevation: 4,
                                    //           decoration:
                                    //           Utils.customPopupDecoration(hintText: "Select GL"),
                                    //           itemBuilder: (BuildContext context) {
                                    //             return glAccList.map((value) {
                                    //               value as Map;
                                    //               return CustomPopupMenuItem(
                                    //                 value: value, // Pass the whole map as the value
                                    //                 text: value['GLAccount']!,
                                    //                 child: Container(),
                                    //               );
                                    //             }).toList();
                                    //           },
                                    //           onSelected: (value) {
                                    //             setState(() {
                                    //               tableOne[index]["GLAccount"] = value['GLAccount'].toString();
                                    //               glNameList[index].text = value['GLAccountName'].toString();
                                    //             });
                                    //           },
                                    //           onCanceled: () {},
                                    //           hintText: "",
                                    //           childWidth: constraints.maxWidth,
                                    //           child: Container(),
                                    //         );
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),
                                    ///BTSD.
                                    SizedBox(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: TextEditingController(text: tableOne[index]["GLAccount"] ?? ""),
                                          decoration: Utils.customerFieldDecoration(
                                            hintText: 'Search GL',
                                            controller: TextEditingController(text: tableOne[index]["GLAccount"] ?? ""),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => _showDialogGL(),
                                            ).then((value) async {
                                              // print('-------Test--------');
                                              // print(value);
                                              if (value != null && value is Map) {
                                                setState(() {
                                                  tableOne[index]["GLAccount"] = value['GLAccount'].toString();
                                                  glNameList[index].text = value['GLAccountName'].toString();
                                                });
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    if (glNameList[index].text != "" && glNameList.isNotEmpty ) // Check if GLAccountName exists
                                      Text(
                                        '${glNameList[index].text}',
                                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                      ),
                                  ],
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
                                          tableOne[index]["narration"] = value;
                                        },
                                      ),
                                    )
                                ),
                                ///Reference.

                                ///New Tax Code.
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   width: 200,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: TextField(
                                    //       controller: TextEditingController(text: tableOne[index]["taxCode"] ?? ""),
                                    //       decoration: Utils.customerFieldDecoration(
                                    //         hintText: 'Search TaxName',
                                    //         controller: TextEditingController(text: tableOne[index]["taxCode"] ?? ""),
                                    //       ),
                                    //       onTap: () {
                                    //         showDialog(
                                    //           context: context,
                                    //           builder: (context) => _showDialogTaxCodes(),
                                    //         ).then((value) async {
                                    //
                                    //           if (value != null && value is Map) {
                                    //             print('----Onselected Hare Krishna----');
                                    //             print(value['TAXCODE']);
                                    //             if(value['TAXCODE']== "--Select--"){
                                    //               tableOne[index]["taxCode"] = '--Select--';
                                    //               taxCodeNamesList[index].text = "${value['TAXCODE']}-${value['TAXCODENAME']}";
                                    //             }
                                    //             else {
                                    //               String selectedValue = value['TAXPER'].toString(); // Get the value from the key
                                    //
                                    //               // print('---------Line Level Items---------');
                                    //               // print("Selected Key: ${value['TAXCODE']}, Value: $selectedValue");
                                    //
                                    //               tableOne[index]["taxCode"] = value['TAXCODE']; // Update with the selected key
                                    //               tableOne[index]["taxValue"] = selectedValue;
                                    //               if (tableOne[index]["amount"] != "" && tableOne[index]["amount"] != null) {
                                    //                 String taxAmount = (double.parse(tableOne[index]["taxValue"].toString()) * double.parse(tableOne[index]["amount"].toString()) / 100).toStringAsFixed(2);
                                    //                 String totalAmount = (double.parse(taxAmount.toString()) + double.parse(tableOne[index]["amount"].toString())).toStringAsFixed(2);
                                    //                 tableOne[index]["taxAmount"] = taxAmount;
                                    //                 tableOne[index]["totalAmount"] = totalAmount;
                                    //               }
                                    //               taxCodeNamesList[index].text = "${value['TAXCODE']}-${value['TAXCODENAME']}";
                                    //             }
                                    //
                                    //             setState(() {
                                    //
                                    //             });
                                    //           }
                                    //         });
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),
                                    if (taxCodeNamesList[index].text != "" && taxCodeNamesList.isNotEmpty && taxCodeNamesList[index].text != "--Select---") // Check if GLAccountName exists
                                      SizedBox(
                                        width: 185,
                                        child: Column(
                                          children: [
                                            Text(
                                              '${taxCodeNamesList[index].text}',
                                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                ///Cost Center
                                Column(
                                  children: [
                                    // SizedBox(
                                    //     width: 150,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(8.0),
                                    //       child: LayoutBuilder(
                                    //         builder: (BuildContext context,
                                    //             BoxConstraints constraints) {
                                    //           // Sort the costCenterList in ascending order
                                    //           // final sortedCostCenterList = List<String>.from(costCenterList)..sort();
                                    //           return CustomPopupMenuButton(
                                    //             elevation: 4,
                                    //             decoration: Utils.customPopupDecoration(
                                    //               hintText: tableOne[index]["CostCenter"] == "" ? "Select" : tableOne[index]["CostCenter"],),
                                    //             itemBuilder: (BuildContext context) {
                                    //               return costCenterList.map((value) {
                                    //                 value as Map;
                                    //                 return CustomPopupMenuItem(
                                    //                     value: value,
                                    //                     text: "${value["costCenter"]} - ${value["costCenterName"]}",
                                    //                     child: Container()
                                    //                 );
                                    //               }).toList();
                                    //             },
                                    //             onSelected: (value) {
                                    //               setState(() {
                                    //                 tableOne[index]["CostCenter"] = value["costCenter"];
                                    //                 costCenterNameList[index].text = value["costCenterName"];
                                    //               });
                                    //             },
                                    //             onCanceled: () {
                                    //
                                    //             },
                                    //             hintText: "",
                                    //             childWidth: constraints.maxWidth,
                                    //             child: Container(),
                                    //           );
                                    //         },
                                    //       ),
                                    //     )
                                    // ),
                                    if(costCenterNameList[index].text != "" || costCenterNameList[index].text.isNotEmpty)
                                      SizedBox(
                                        width: 140,
                                        child: Column(
                                          children: [
                                            Text(
                                              costCenterNameList[index].text,
                                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                // SizedBox(
                                //     width: 150,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: LayoutBuilder(
                                //         builder: (BuildContext context,
                                //             BoxConstraints constraints) {
                                //           final profitSortCenterList = List<String>.from(profitCenterList)..sort();
                                //           return CustomPopupMenuButton(
                                //             elevation: 4,
                                //             decoration: Utils
                                //                 .customPopupDecoration(
                                //               hintText: tableOne[index]["ProfitCenter"] ==
                                //                   ""
                                //                   ? "Select"
                                //                   : tableOne[index]["ProfitCenter"],),
                                //             itemBuilder: (BuildContext context) {
                                //               return profitSortCenterList.map((value) {
                                //                 return CustomPopupMenuItem(
                                //                     value: value,
                                //                     text: value,
                                //                     child: Container()
                                //                 );
                                //               }).toList();
                                //             },
                                //             onSelected: (value) {
                                //               setState(() {
                                //                 tableOne[index]["ProfitCenter"] =
                                //                     value;
                                //               });
                                //             },
                                //             onCanceled: () {
                                //
                                //             },
                                //             hintText: "",
                                //             childWidth: constraints
                                //                 .maxWidth,
                                //             child: Container(),
                                //           );
                                //         },
                                //       ),
                                //     )
                                // ),
                                // SizedBox(
                                //     width: 250,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: TextFormField(
                                //         style: const TextStyle(
                                //             fontSize: 14),
                                //         controller: assignmentController,
                                //         decoration: Utils
                                //             .customerFieldDecoration(
                                //             hintText: 'Enter Assignment',
                                //             controller: assignmentController),
                                //         onChanged: (value) {
                                //           tableOne[index]["assignment"] = value;
                                //         },
                                //       ),
                                //     )
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        if(tableOne.length == index+1)
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
                                                    tableOne.add({
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
                                                if (tableOne.length > 1) {
                                                  tableOne.removeAt(index);
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
                if(typeDropdownValue ==  "Customer Receipt")...[
                  SizedBox(
                    // width: typeDropdownValue !=  "Cash Receipt"  ? 2360:1760,
                    width: 2200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: customerTable.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        costCenterNameList.add(TextEditingController(text: ""));

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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                ///Old Customer
                                // SizedBox(
                                //     width: 150,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: CustomTextFieldSearch(
                                //         showAdd: false,
                                //         decoration: Utils.customerFieldDecoration(hintText: 'Search Gl', controller: customerCont),
                                //         controller: customerCont,
                                //         future: (){
                                //           return getCustomerGLCodes();
                                //         },
                                //         getSelectedValue: (SearchCustomerGL v){
                                //           customerTable[index]["GLAccount"] = v.label;
                                //           setState(() {
                                //             customerTable[index]["customerName"] = v.customerName;
                                //           });
                                //         },
                                //         onChanged: (val){
                                //
                                //         },
                                //       ),
                                //     )
                                // ),
                                ///New
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: TextEditingController(text: customerTable[index]["GLAccount"] ?? ""),
                                          decoration: Utils.customerFieldDecoration(
                                            hintText: 'Search Customer',
                                            controller: TextEditingController(text: customerTable[index]["GLAccount"] ?? ""),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => _showDialogCustomer(),
                                            ).then((value) async {
                                              if (value != null && value is Map) {
                                                customerTable[index]["GLAccount"]  = value['Customer'];
                                                customerTable[index]["customerName"] = value['CustomerName'];

                                                setState(() { });
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    if (customerTable[index]["customerName"] != "" ) // Check if GLAccountName exists
                                      SizedBox(
                                        width: 185,
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${customerTable[index]["customerName"]??""}',
                                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
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
                                    width: 200,
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
                                ///Reference.
                                // SizedBox(
                                //     width: 200,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: TextFormField(
                                //         style: const TextStyle(
                                //             fontSize: 14),
                                //         controller: referenceController,
                                //         decoration: Utils
                                //             .customerFieldDecoration(
                                //             hintText: 'Enter Reference',
                                //             controller: referenceController),
                                //         onChanged: (value) {
                                //           customerTable[index]["reference"] = value;
                                //         },
                                //       ),
                                //     )
                                // ),
                                Column(
                                  children: [
                                    // SizedBox(
                                    //     width: 150,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(8.0),
                                    //       child: LayoutBuilder(
                                    //         builder: (BuildContext context,
                                    //             BoxConstraints constraints) {
                                    //           // Sort the costCenterList in ascending order
                                    //           // final sortedCostCenterList = List<String>.from(costCenterList)..sort();
                                    //           return CustomPopupMenuButton(
                                    //             elevation: 4,
                                    //             decoration: Utils.customPopupDecoration(
                                    //               hintText: tableOne[index]["CostCenter"] == "" ? "Select" : tableOne[index]["CostCenter"],),
                                    //             itemBuilder: (BuildContext context) {
                                    //               return costCenterList.map((value) {
                                    //                 value as Map;
                                    //                 return CustomPopupMenuItem(
                                    //                     value: value,
                                    //                     text: "${value["costCenter"]} - ${value["costCenterName"]}",
                                    //                     child: Container()
                                    //                 );
                                    //               }).toList();
                                    //             },
                                    //             onSelected: (value) {
                                    //               setState(() {
                                    //
                                    //                 tableOne[index]["CostCenter"] = value["costCenter"];
                                    //                 costCenterNameList[index].text = value["costCenterName"];
                                    //
                                    //               });
                                    //             },
                                    //             onCanceled: () {
                                    //
                                    //             },
                                    //             hintText: "",
                                    //             childWidth: constraints.maxWidth,
                                    //             child: Container(),
                                    //           );
                                    //         },
                                    //       ),
                                    //     )
                                    // ),
                                    if(costCenterNameList[index].text != "" || costCenterNameList[index].text.isNotEmpty)
                                      SizedBox(
                                        width: 140,
                                        child: Column(
                                          children: [
                                            Text(
                                              costCenterNameList[index].text,
                                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                // SizedBox(
                                //     width: 150,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: LayoutBuilder(
                                //         builder: (BuildContext context,
                                //             BoxConstraints constraints) {
                                //           // Sort the costCenterList in ascending order
                                //           final sortedProfitCenterList = List<String>.from(profitCenterList)..sort();
                                //           return CustomPopupMenuButton(
                                //             elevation: 4,
                                //             decoration: Utils
                                //                 .customPopupDecoration(
                                //               hintText: customerTable[index]["ProfitCenter"] ==
                                //                   ""
                                //                   ? "Select"
                                //                   : customerTable[index]["ProfitCenter"],),
                                //             itemBuilder: (
                                //                 BuildContext context) {
                                //               return sortedProfitCenterList.map((
                                //                   value) {
                                //                 return CustomPopupMenuItem(
                                //                     value: value,
                                //                     text: value,
                                //                     child: Container()
                                //                 );
                                //               }).toList();
                                //             },
                                //             onSelected: (value) {
                                //               setState(() {
                                //                 customerTable[index]["ProfitCenter"] =
                                //                     value;
                                //               });
                                //             },
                                //             onCanceled: () {
                                //
                                //             },
                                //             hintText: "",
                                //             childWidth: constraints
                                //                 .maxWidth,
                                //             child: Container(),
                                //           );
                                //         },
                                //       ),
                                //     )
                                // ),
                                // SizedBox(
                                //     width: 200,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: TextFormField(
                                //         style: const TextStyle(
                                //             fontSize: 14),
                                //         controller: assignmentController,
                                //         decoration: Utils
                                //             .customerFieldDecoration(
                                //             hintText: 'Enter Assignment',
                                //             controller: assignmentController),
                                //         onChanged: (value) {
                                //           customerTable[index]["assignment"] = value;
                                //         },
                                //       ),
                                //     )
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                if(typeDropdownValue !=  "Cash Receipt" && typeDropdownValue !=  "Customer Receipt")...[
                  SizedBox(
                    width: 1100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tableOne.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        glNameList.add(TextEditingController(text: ""));
                        taxCodeNamesList.add(TextEditingController(text: ""));
                        costCenterNameList.add(TextEditingController(text: ""));

                        TextEditingController amountController = TextEditingController();
                        TextEditingController textController = TextEditingController();
                        TextEditingController referenceController = TextEditingController();
                        TextEditingController assignmentController = TextEditingController();
                        TextEditingController hsnController = TextEditingController();
                        try{
                          hsnController.text=tableOne[index]["GLAccount"];
                          hsnController.text=tableOne[index]["CostCenter"];

                          hsnController.selection = TextSelection.fromPosition(TextPosition(offset: hsnController.text.length,));
                        }
                        catch(e){

                        }

                        amountController.text =
                            (tableOne[index]["amount"] ?? "").toString();
                        textController.text =
                            (tableOne[index]["text"] ?? "").toString();
                        referenceController.text =
                            (tableOne[index]["reference"] ?? "")
                                .toString();
                        assignmentController.text =
                            (tableOne[index]["assignment"] ?? "")
                                .toString();

                        amountController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: amountController.text.length));
                        textController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: textController.text.length));
                        referenceController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: referenceController.text.length));
                        assignmentController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: assignmentController.text
                                    .length));
                        return Container(
                          color: Colors.grey[50],
                          // height: 90,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        tableOne[index]["amount"] = rawValue;

                                        if (tableOne[index]["taxValue"] != null) {
                                          String taxAmount = (double.parse(tableOne[index]["taxValue"].toString()) *
                                              double.parse(rawValue) /
                                              100)
                                              .toStringAsFixed(2);
                                          String totalAmount =
                                          (double.parse(taxAmount) + double.parse(rawValue))
                                              .toStringAsFixed(2);
                                          tableOne[index]["taxAmount"] = taxAmount;
                                          tableOne[index]["totalAmount"] = totalAmount;
                                        } else {
                                          tableOne[index]["totalAmount"] = rawValue;
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
                                ///GL OLD.
                                // SizedBox(
                                //     width: 150,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: CustomTextFieldSearch(
                                //         showAdd: false,
                                //         decoration: Utils.customerFieldDecoration(hintText: 'Search Gl', controller: hsnController),
                                //         controller: hsnController,
                                //         future: (){
                                //           return getGLCodes();
                                //         },
                                //         getSelectedValue: (SearchGL v){
                                //
                                //           tableOne[index]["GLAccount"]= v.label;
                                //
                                //         },
                                //
                                //       ),
                                //     )
                                // ),

                                // Column(
                                //   children: [
                                //     // SizedBox(
                                //     //     width: 200,
                                //     //     child: Padding(
                                //     //       padding: const EdgeInsets.all(8.0),
                                //     //       child: LayoutBuilder(
                                //     //         builder: (BuildContext context,
                                //     //             BoxConstraints constraints) {
                                //     //           return CustomPopupMenuButton(
                                //     //             textController: TextEditingController(text: tableOne[index]["GLAccount"]??""),
                                //     //             elevation: 4,
                                //     //             decoration: Utils.customPopupDecoration(hintText: "Select Gl",),
                                //     //             itemBuilder: (
                                //     //                 BuildContext context) {
                                //     //               return glAccList.map((value) {
                                //     //                 value as Map;
                                //     //                 return CustomPopupMenuItem(
                                //     //                     value: value['GLAccount'],
                                //     //                     text: value['GLAccount'],
                                //     //                     child: Container()
                                //     //                 );
                                //     //               }).toList();
                                //     //             },
                                //     //             onSelected: (value) {
                                //     //               setState(() {
                                //     //                 tableOne[index]["GLAccount"] = value.toString();
                                //     //                 // glNameList[index] = value['GLAccountName'].toSting();
                                //     //                 print('----------------------');
                                //     //                 print(glNameList[index]);
                                //     //               });
                                //     //             },
                                //     //             onCanceled: () {
                                //     //
                                //     //             },
                                //     //             hintText: "",
                                //     //             childWidth: constraints.maxWidth,
                                //     //             child: Container(),
                                //     //           );
                                //     //         },
                                //     //       ),
                                //     //     )
                                //     // ),
                                //
                                //     SizedBox(
                                //       width: 200,
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: LayoutBuilder(
                                //           builder: (BuildContext context, BoxConstraints constraints) {
                                //             return CustomPopupMenuButton(
                                //               textController: TextEditingController(
                                //                   text: tableOne[index]["GLAccount"] ?? ""),
                                //               elevation: 4,
                                //               decoration: Utils.customPopupDecoration(hintText: "Select Gl"),
                                //               itemBuilder: (BuildContext context) {
                                //                 return glAccList.map((value) {
                                //                   value as Map;
                                //                   return CustomPopupMenuItem(
                                //                     value: value, // Pass the whole map as the value
                                //                     text: value['GLAccount'],
                                //                     child: Container(),
                                //                   );
                                //                 }).toList();
                                //               },
                                //               onSelected: (value) {
                                //                 setState(() {
                                //                   // Extract values from the selected map
                                //                   tableOne[index]["GLAccount"] = value['GLAccount'].toString();
                                //                   glNameList[index] = value['GLAccountName'].toString();
                                //                   print('Selected GLAccountName: ${glNameList[index]}');
                                //                 });
                                //               },
                                //               onCanceled: () {},
                                //               hintText: "",
                                //               childWidth: constraints.maxWidth,
                                //               child: Container(),
                                //             );
                                //           },
                                //         ),
                                //       ),
                                //     ),
                                //     const SizedBox(height:5),
                                //
                                //     // if(glNameList[index] != "" && glNameList[index] != )
                                //     //   Text('${glNameList[index] ?? ""}')
                                //   ],
                                // ),

                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///Old Dropdown
                                    // SizedBox(
                                    //   width: 200,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: LayoutBuilder(
                                    //       builder: (BuildContext context, BoxConstraints constraints) {
                                    //         return CustomPopupMenuButton(
                                    //           textController: TextEditingController(
                                    //               text: tableOne[index]["GLAccount"] ?? ""),
                                    //           elevation: 4,
                                    //           decoration:
                                    //           Utils.customPopupDecoration(hintText: "Select GL"),
                                    //           itemBuilder: (BuildContext context) {
                                    //             return glAccList.map((value) {
                                    //               value as Map;
                                    //               return CustomPopupMenuItem(
                                    //                 value: value, // Pass the whole map as the value
                                    //                 text: value['GLAccount']!,
                                    //                 child: Container(),
                                    //               );
                                    //             }).toList();
                                    //           },
                                    //           onSelected: (value) {
                                    //             setState(() {
                                    //               tableOne[index]["GLAccount"] = value['GLAccount'].toString();
                                    //               glNameList[index].text = value['GLAccountName'].toString();
                                    //             });
                                    //           },
                                    //           onCanceled: () {},
                                    //           hintText: "",
                                    //           childWidth: constraints.maxWidth,
                                    //           child: Container(),
                                    //         );
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),

                                    ///Both
                                    SizedBox(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: TextEditingController(text: tableOne[index]["GLAccount"] ?? ""),
                                          decoration: Utils.customerFieldDecoration(
                                            hintText: 'Search GL',
                                            controller: TextEditingController(text: tableOne[index]["GLAccount"] ?? ""),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => _showDialogGL(),
                                            ).then((value) async {
                                              print('-------Test--------');
                                              print(value);
                                              if (value != null && value is Map) {
                                                setState(() {
                                                  tableOne[index]["GLAccount"] = value['GLAccount'].toString();
                                                  glNameList[index].text = value['GLAccountName'].toString();
                                                  print('-------------------gTesting -gg-jh------');
                                                  print(value['CostCenter'].toString());

                                                  tableOne[index]["CostCenter"] = value['CostCenter'].toString();
                                                  costCenterNameList[index].text = value['CostCenterName'].toString();
                                                  print("-------------$costCenterNameList");
                                                  print(value['CostCenter'].toString());
                                                  if (typeDropdownValue != "--Select--") {
                                                    triggerBalanceApis();
                                                  }
                                                  isLoading = false;
                                                });
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    if (glNameList[index].text != "" && glNameList.isNotEmpty ) // Check if GLAccountName exists
                                      Text(
                                        '${glNameList[index].text}',
                                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                      ),
                                  ],
                                ),
                                ///Commented (House Bank, Account ID)
                                // SizedBox(
                                //       width: 250,
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: LayoutBuilder(
                                //           builder: (BuildContext context,
                                //               BoxConstraints constraints) {
                                //             return CustomPopupMenuButton(
                                //               elevation: 4,
                                //               decoration: Utils.customPopupDecoration(hintText: tableOne[index]["houseBank"] == "" ? "Select" : tableOne[index]["houseBank"],),
                                //               itemBuilder: (
                                //                   BuildContext context) {
                                //                 return houseBankList.map((value) {
                                //
                                //                   return CustomPopupMenuItem(
                                //                       value: value,
                                //                       text: "${value['HouseBank']}- ${value['BankAccountDescription']}",
                                //                       child: Container()
                                //                   );
                                //                 }).toList();
                                //               },
                                //               onSelected: (value) {
                                //                 value as Map;
                                //                 setState(() {
                                //                   tableOne[index]["houseBank"] = value['BankAccountDescription'];
                                //                   tableOne[index]["accountId"] = value['HouseBank'];
                                //
                                //                 });
                                //               },
                                //               onCanceled: () {
                                //
                                //               },
                                //               hintText: "",
                                //               childWidth: constraints
                                //                   .maxWidth,
                                //               child: Container(),
                                //             );
                                //           },
                                //         ),
                                //       )
                                //   ),
                                // SizedBox(
                                //       width: 150,
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: TextFormField(readOnly:  true,
                                //           style: const TextStyle(
                                //               fontSize: 14),
                                //           controller: TextEditingController(text: tableOne[index]["accountId"] ),
                                //           decoration: Utils
                                //               .customerFieldDecoration(hintText: 'Accounted ID', controller: textController),
                                //           onChanged: (value) {
                                //             tableOne[index]["accountIdController"] = value;
                                //           },
                                //         ),
                                //       )
                                //   ),
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
                                          tableOne[index]["text"] = value;
                                        },
                                      ),
                                    )
                                ),
                                ///Reference.

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (taxCodeNamesList[index].text != "" && taxCodeNamesList.isNotEmpty && taxCodeNamesList[index].text != "--Select---") // Check if GLAccountName exists
                                      SizedBox(
                                        width: 185,
                                        child: Column(
                                          children: [
                                            Text(
                                              '${taxCodeNamesList[index].text}',
                                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    // SizedBox(
                                    //     width: 150,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(8.0),
                                    //
                                    //           // Sort the costCenterList in ascending order
                                    //           // final sortedCostCenterList = List<String>.from(costCenterList)..sort();
                                    //
                                    //
                                    //             decoration: Utils.customPopupDecoration(
                                    //               hintText: tableOne[index]["CostCenter"] == "" ? "Select" : tableOne[index]["CostCenter"],),
                                    //             itemBuilder: (BuildContext context) {
                                    //               return costCenterList.map((value) {
                                    //                 value as Map;
                                    //                 return CustomPopupMenuItem(
                                    //                     value: value,
                                    //                     text: "${value["costCenter"]} - ${value["costCenterName"]}",
                                    //                     child: Container()
                                    //                 );
                                    //               }).toList();
                                    //             },
                                    //             onSelected: (value) {
                                    //               setState(() {
                                    //                 tableOne[index]["CostCenter"] = value["costCenter"];
                                    //                 costCenterNameList[index].text = value["costCenterName"];
                                    //               });
                                    //             },
                                    //             onCanceled: () {
                                    //
                                    //             },
                                    //
                                    //             child: Container(),
                                    //
                                    //
                                    //
                                    //     )
                                    // ),
                                    SizedBox(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          readOnly: true,
                                          controller: TextEditingController(text: tableOne[index]["CostCenter"] ?? ""),
                                          decoration: Utils.customerFieldDecoration(
                                            hintText: 'Search GL',
                                            controller: TextEditingController(text: tableOne[index]["CostCenter"] ?? ""),
                                          ),
                                          onTap: () {
                                            // showDialog(
                                            //   context: context,
                                            //   builder: (context) => _showDialogGL(),
                                            // ).then
                                              ((value) async {
                                              print('-------Test--------');
                                              print(value);
                                              if (value != null && value is Map) {
                                                setState(() {
                                                  tableOne[index]["CostCenter"] = value['CostCenter'].toString();
                                                  costCenterNameList[index].text = value['CostCenterName'].toString();
                                                });
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    if(costCenterNameList[index].text != "" || costCenterNameList[index].text.isNotEmpty)
                                      SizedBox(
                                        width: 140,
                                        child: Column(
                                          children: [
                                            Text(
                                              costCenterNameList[index].text,
                                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                // SizedBox(
                                //     width: 150,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: LayoutBuilder(
                                //         builder: (BuildContext context,
                                //             BoxConstraints constraints) {
                                //           final profitSortCenterList = List<String>.from(profitCenterList)..sort();
                                //           return CustomPopupMenuButton(
                                //             elevation: 4,
                                //             decoration: Utils
                                //                 .customPopupDecoration(
                                //               hintText: tableOne[index]["ProfitCenter"] ==
                                //                   ""
                                //                   ? "Select"
                                //                   : tableOne[index]["ProfitCenter"],),
                                //             itemBuilder: (
                                //                 BuildContext context) {
                                //               return profitSortCenterList.map((
                                //                   value) {
                                //                 return CustomPopupMenuItem(
                                //                     value: value,
                                //                     text: value,
                                //                     child: Container()
                                //                 );
                                //               }).toList();
                                //             },
                                //             onSelected: (value) {
                                //               setState(() {
                                //                 tableOne[index]["ProfitCenter"] =
                                //                     value;
                                //               });
                                //             },
                                //             onCanceled: () {
                                //
                                //             },
                                //             hintText: "",
                                //             childWidth: constraints
                                //                 .maxWidth,
                                //             child: Container(),
                                //           );
                                //         },
                                //       ),
                                //     )
                                // ),
                                // SizedBox(
                                //     width: 250,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: TextFormField(
                                //         style: const TextStyle(
                                //             fontSize: 14),
                                //         controller: assignmentController,
                                //         decoration: Utils
                                //             .customerFieldDecoration(
                                //             hintText: 'Enter Assignment',
                                //             controller: assignmentController),
                                //         onChanged: (value) {
                                //           tableOne[index]["assignment"] = value;
                                //         },
                                //       ),
                                //     )
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        if(tableOne.length == index+1)
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
                                                    tableOne.add({
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
                                                if (tableOne.length > 1) {
                                                  tableOne.removeAt(index);
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void filterCashJournalCode(String cashJ) {
    setState(() {
      if(typeDropdownValue == "Cash Receipt"){
        displayCashJournalList = initialJournalList.where((cashJournal) {
          return cashJournal["Code"]?.contains(cashJ) ?? false;
        }).toList();
      }
      if (typeDropdownValue == "Cash Payment"){
        displayCashJournalList = initialJournalList.where((cashJournal) {
          return cashJournal["Code"]?.contains(cashJ) ?? false;
        }).toList();
      }

    });
  }
  void filterCashJournalName(String cashJ) {
    setState(() {
      if(typeDropdownValue == "Cash Receipt"){
        displayCashJournalList = initialJournalList.where((cashJournal) {
          return cashJournal["Name"]?.toString().toLowerCase().contains(cashJ.toString().toLowerCase()) ?? false;
        }).toList();
      }
      if(typeDropdownValue == "Cash Payment"){
        displayCashJournalList = initialJournalList.where((cashJournal) {
          return cashJournal["Name"]?.toString().toLowerCase().contains(cashJ.toString().toLowerCase()) ?? false;
        }).toList();
      }

    });
  }
  void filterGlCode(String gl) {
    setState(() {
      displayGLList = glAccList.where((glAccount) {
        return glAccount["Code"]?.contains(gl) ?? false;
      }).toList();
    });
  }
  void filterGlName(String gl) {
    setState(() {
      displayGLList = glAccList.where((glAccount) {
        return glAccount["Name"]?.toString().toLowerCase().contains(gl.toString().toLowerCase()) ?? false;
      }).toList();
    });
  }
  void filterTaxCodes(String tName) {
    setState(() {
      displayTaxCodesList = taxCodesDELine.where((taxName) {
        return taxName["TAXCODE"]?.toString().toLowerCase().contains(tName.toLowerCase()) ?? false;
      }).toList();
    });
  }
  void filterTaxNames(String tName) {
    setState(() {
      displayTaxCodesList = taxCodesDELine.where((taxName) {
        return taxName["TAXCODENAME"]?.toString().toLowerCase().contains(tName.toLowerCase()) ?? false;
      }).toList();
    });
  }
  void filterCustomerCodes(String cName) {
    setState(() {
      displayCustomerList = costCenterList.where((customerName) {
        return customerName["customer"]?.toString().toLowerCase().contains(cName.toLowerCase()) ?? false;
      }).toList();
    });
  }
  void filterCustomerNames(String cName) {
    setState(() {
      displayCustomerList = costCenterList.where((customerName) {
        return customerName["customerName"]?.toString().toLowerCase().contains(cName.toLowerCase()) ?? false;
      }).toList();
    });
  }

  _showDialogCashJournal() {
    return AlertDialog(
      title: const Text("Select Cash Journal"),
      content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(height: 500,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchCashJournalCodeCont,
                            decoration: const InputDecoration(
                              labelText: 'Search By Cash Journal Code',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                              if(value.isEmpty || value.trim().isEmpty){
                               // displayCashJournalList = cashJournalList2;
                                cashJournalValues();
                              }
                              else{
                                filterCashJournalCode(value);
                              }
                              if(searchCashJournalNameController.text != ""){
                                searchCashJournalNameController.text = '';
                              }

                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchCashJournalNameController,
                            decoration: const InputDecoration(
                              labelText: 'Search By Cash Journal Name',
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty || value == "") {
                                  // displayCashJournalList = cashJournalList2;
                                  cashJournalValues();
                                }
                                else{
                                  filterCashJournalName(value);
                                }
                                if(searchCashJournalCodeCont.text != ""){
                                  searchCashJournalCodeCont.text = "";
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 600,
                    height: 350,
                    child:displayCashJournalList.isEmpty
                        ?  Center(
                      child: Text(
                        ((typeDropdownValue == "--Select--") || (typeDropdownValue == "")) ? "Please Select Type Of Transaction.": "No Matching Records Found.",
                        style:const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ) :  ListView.builder(
                      shrinkWrap: true,
                      itemCount: displayCashJournalList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pop(context,displayCashJournalList[index]);
                          },
                          child: ListTile(
                            title:  Text(displayCashJournalList[index]['Code']??""),
                            subtitle: Text(displayCashJournalList[index]['Name']??""),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
      ),
    );
  }
  ///Search GL Show Dialog.
  _showDialogGL() {
    return AlertDialog(
      title: const Text("Select GL"),
      content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(height: 500,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchGlCodeCont,
                            decoration: const InputDecoration(
                              labelText: 'Search By GLCode',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                              if(value.isEmpty || value.trim().isEmpty){
                                displayGLList = glAccList;
                              }
                              else{
                                filterGlCode(value);
                              }
                              if(searchGlNameCont.text != ""){
                                searchGlNameCont.text = "";
                              }
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchGlNameCont,
                            decoration: const InputDecoration(
                              labelText: 'Search By GLName',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                                if(value.isEmpty || value.trim().isEmpty){
                                  displayGLList = glAccList;
                                }
                                else{
                                  filterGlName(value);
                                }
                                if(searchGlCodeCont.text != ""){
                                  searchGlCodeCont.text = "";
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 600,
                    height: 350,
                    child:displayGLList.isEmpty
                        ? const Center(
                      child: Text(
                        "No Matching Records Found.",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ) :  ListView.builder(
                      shrinkWrap: true,
                      itemCount: displayGLList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pop(context,displayGLList[index]);
                          },
                          child: ListTile(
                            title:  Text(displayGLList[index]['GLAccount']??""),
                            subtitle: Text(displayGLList[index]['GLAccountName']??""),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
      ),
    );
  }
  ///TaxCode.
  _showDialogTaxCodes() {
    return AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Select TaxCode"),
          // if(taxCode != "")
          //   MaterialButton(
          //       color: Colors.blue,
          //       onPressed: (){
          //         setState(() {
          //           taxCode = "Clear";
          //           Navigator.pop(context,taxCode);
          //         });
          //       },
          //       child:const Text("Clear TaxCode",style: TextStyle(color: Colors.white),))
        ],
      ),
      content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(height: 500,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchTaxCodeCont,
                            decoration: const InputDecoration(
                              labelText: 'Search TaxCode',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                              if(value.isEmpty || value.trim().isEmpty){
                                displayTaxCodesList = taxCodesDELine;
                              }
                              else{
                                filterTaxCodes(value);
                              }
                              if(searchTaxNameCont.text != ""){
                                searchTaxNameCont.text = "";
                              }
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchTaxNameCont,
                            decoration: const InputDecoration(
                              labelText: 'Search TaxName',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                                if(value.isEmpty || value.trim().isEmpty){
                                  displayTaxCodesList = taxCodesDELine;
                                }
                                else{
                                  filterTaxNames(value);
                                }
                                if(searchTaxCodeCont.text != ""){
                                  searchTaxCodeCont.text = "";
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 600,
                    height: 350,
                    child:displayTaxCodesList.isEmpty
                        ? const Center(
                      child: Text(
                        "No Matching Records Found.",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ) :  ListView.builder(
                      shrinkWrap: true,
                      itemCount: displayTaxCodesList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pop(context,displayTaxCodesList[index]);
                          },
                          child: ListTile(
                            title:  Text(displayTaxCodesList[index]['TAXCODE']??""),
                            subtitle: Text(displayTaxCodesList[index]['TAXCODENAME']??""),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
      ),
    );
  }
  ///Customer
  _showDialogCustomer() {
    return AlertDialog(
      title: const Text("Select Customer"),
      content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(height: 500,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchCustomerCodeCont,
                            decoration: const InputDecoration(
                              labelText: 'Search By CustomerCode',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                              if(value.isEmpty || value.trim().isEmpty){
                                displayCustomerList = customerList;
                              }
                              else{
                                filterCustomerCodes(value);
                              }
                              if(searchCustomerNameCont.text != ""){
                                searchCustomerNameCont.text = "";
                              }
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchCustomerNameCont,
                            decoration: const InputDecoration(
                              labelText: 'Search By CustomerName',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                                if(value.isEmpty || value.trim().isEmpty){
                                  displayCustomerList = customerList;
                                }
                                else{
                                  filterCustomerNames(value);
                                }
                                if(searchCustomerCodeCont.text != ""){
                                  searchCustomerCodeCont.text = "";
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 600,
                    height: 350,
                    child:displayCustomerList.isEmpty
                        ? const Center(
                      child: Text(
                        "No Matching Records Found.",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ) :  ListView.builder(
                      shrinkWrap: true,
                      itemCount: displayCustomerList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pop(context,displayCustomerList[index]);
                          },
                          child: ListTile(
                            title:  Text(displayCustomerList[index]['Customer']??""),
                            subtitle: Text(displayCustomerList[index]['CustomerName']??""),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
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
  Future getGLCodes()async{
    List list=[];
    for(int i=0;i<glAccList.length;i++){
      list.add(SearchGL.fromJson(glAccList[i]));
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

  makeEmpty(){
    tableOne = [
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
        "customerName":""
      },
    ];
    cashJournalName = "";
    glNameList = [];
    taxCodeNamesList = [];
    searchTaxCodeCont.text = '';
    searchTaxNameCont.text = "";
    searchGlCodeCont.text = "";
    searchGlNameCont.text = '';
    searchCashJournalCodeCont.text = '';
    searchCashJournalNameController.text = "";
    searchCustomerCodeCont.text = '';
    searchCustomerNameCont.text = "";
    costCenterNameList = [];

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
