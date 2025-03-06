import 'dart:developer';
import 'dart:html';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import '../login_screen.dart';
import '../utils/m_colors.dart';
import '../utils/static_data.dart';
import '../utils/utils.dart';
import '../widgets/customButtons.dart';
import '../widgets/custom_message/toastification_msg.dart';
import '../widgets/custom_popup_dropdown/custom_popup_dropdown.dart';
import 'direct_expense_api.dart';
import 'package:xml/xml.dart' as xml;

class DirectExpenses extends StatefulWidget {
  const DirectExpenses({super.key});

  @override
  State<DirectExpenses> createState() => _DirectExpensesState();
}

class _DirectExpensesState extends State<DirectExpenses> {
  final _verticalScrollController = ScrollController();
  final _horizontalScrollController = ScrollController();
  final _horizontalScrollController2 = ScrollController();
  late double screenWidth;
  late double screenHeight;
  String companyDropdownValue = "--Select Company Code--";
  String vendorDropdownValue = "Search Vendor";
  String withHoldingName = "";
  String taxCodeType = "";
  String taxPec = "";
  String vendorName = "";
  String businessDes = "";
  bool enableTaxCode = false;
  bool isLoading = false;
  FocusNode postingDateNode = FocusNode();
  FocusNode invoicingDateNode = FocusNode();
  FocusNode referenceNode = FocusNode();

  final TextEditingController companyCodeController = TextEditingController();
  final TextEditingController vendorController = TextEditingController();
  final TextEditingController postingDateController = TextEditingController();
  final TextEditingController invoicingDateController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController withholdingTaxController = TextEditingController();
  final TextEditingController withholdingTaxCalculateCont = TextEditingController();
  final TextEditingController tdsAmountController = TextEditingController();
  final TextEditingController businessController = TextEditingController();
  final TextEditingController searchGlCont = TextEditingController();
  final TextEditingController searchGlNameCont = TextEditingController();
  final TextEditingController searchVendorCodeCont = TextEditingController();
  final TextEditingController searchVendorNameCont = TextEditingController();
  final TextEditingController searchTaxCodeCont = TextEditingController();
  final TextEditingController searchTaxNameCont = TextEditingController();

  List<CustomPopupMenuEntry<String>> withholdingTaxList = <CustomPopupMenuEntry<String>>[
    const CustomPopupMenuItem(
      height: 40,
      value: 'Yes',
      child: Center(child: SizedBox(width: 350,child: Text('Yes',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11)))),
    ),
    const CustomPopupMenuItem(
      height: 40,
      value: 'No',
      child: Center(child: SizedBox(width: 350,child: Text('No',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11)))),
    ),
  ];
  List<CustomPopupMenuEntry<String>> enableTaxList = <CustomPopupMenuEntry<String>>[
    const CustomPopupMenuItem(
      height: 40,
      value: 'Yes',
      child: Center(child: SizedBox(width: 350,child: Text('Yes',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11)))),
    ),
    const CustomPopupMenuItem(
      height: 40,
      value: 'No',
      child: Center(child: SizedBox(width: 350,child: Text('No',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11)))),
    ),
  ];
  List glNameList =[];
  List displayGLList = [];
  List displayVendorList = [];
  List displayTaxCodeList = [];
  List glAccountList = [];
  List taxCodeNamesList = [];
  List vendorCodeList = [];
  List taxCodesList = [];
  List costCenterList = [];
  List costCenterNameList = [];
  List businessPlaceList = [];

  Future _fetchApiResponse()async{
    setState(() {
      isLoading = true;
    });
    try{
      var glAccount = await getGlAccountDEA();
      var vendor = await getVendorCode();
      var costCenter = await getCostCenter();
      var business = await getBusinessPlace();

      if(glAccount != null){
        setState(() {
          glAccountList = glAccount.map((item)=> {
            "GLAccount": item["GLAccount"].toString(),
            "GLAccountName": item['GLAccountName'].toString(),
          }).toSet().toList();
          displayGLList = glAccountList;
        });
      }
      else{
        log("No data found for G/L Account");
      }
      if(vendor !=null ){
        setState(() {
          vendorCodeList = vendor.map((vendor)=>{
            "Supplier":vendor['Supplier'].toString(),
            "SupplierName":vendor['SupplierName'].toString(),
          }).toList();
          displayVendorList = vendorCodeList;
        });
      }
      else{
        log("No data for Vendor Codes");
      }
      if(costCenter != null){
        setState(() {
          // print('------costCenter------');
          // print(costCenter);

          costCenterList = costCenter.map((cost)=>
          {
           "costCenter" :cost['CostCenter'].toString(),
           "costCenterName":cost['CostCenterName'].toString()

          }).toSet().toList();
        });
      }
      else{
        log("No Data Found for CostCenter");
      }

      if(business != null){
        setState(() {
          businessPlaceList = business.map((item)=>
          {
            "businessPlace":item['BusinessPlace'].toString(),
            "businessPlaceDescription":item['BusinessPlaceDescription'].toString(),
          }
          ).toSet().toList();
          // print('-------businessPlaceList-----');
          // print(businessPlaceList);
        });
      }
      else{
        log("No Data Found for BusinessPlace.");
      }

    }
    catch(e){
      log("Error In fetching dropdown values:$e");
    }
    finally{
      log("Fetching Data Completed");
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> withholdingTaxCodes(String vendorCode) async {
    try {
      var withHoldingTaxCodes = await getWithholdingTax();
      if (withHoldingTaxCodes != null && withHoldingTaxCodes is List) {
        setState(() {
          taxCodesList.clear(); // Clear previous entries
          for (var match in withHoldingTaxCodes) {
            if (match is Map &&
                match.containsKey('Supplier') &&
                match['Supplier'].toString().trim().toLowerCase() == vendorCode.trim().toLowerCase()) {
              taxCodesList.add(match);
            }
          }

          // If no data matches, add a placeholder entry
          if (taxCodesList.isEmpty) {
            taxCodesList.add({"Message": "No Data Found"});
          }

          // Optional: Print for debugging
          // print('------taxCodesList------');
          // print(taxCodesList);
        });
      } else {
        log('withHoldingTaxCodes is null or not a List');
      }
    } catch (e) {
      log("Error In fetching withHolding TaxCodes.: $e");
    }
  }

  Future getGLCodes()async{
    List list = [];
    for(int i =0;i<glAccountList.length;i++){
      list.add(SearchGL.fromJson(glAccountList[i]));
    }
    return list;
  }
  Future getVendorCodes()async{
    List list = [];
    for(int i =0;i<vendorCodeList.length;i++){
      list.add(SearchVendor.fromJson(vendorCodeList[i]));
    }
    return list;
  }
  Future getCostCenterCodes()async{
    List list = [];
    for(int i =0;i<costCenterList.length;i++){
      list.add(SearchCostCenter.fromJson(costCenterList[i]));
    }
    return list;
  }

  Future getWithHoldingTaxCodes()async{
    List list = [];
    for(int i =0;i<withHoldingTax.length;i++){
      list.add(SearchWithHoldingTaxCode.fromJson(withHoldingTax[i]));
    }
    return list;
  }
  String _formatWithCommas(String value) {
    if (value.isEmpty) return '';
    final parts = value.split('.');
    final intPart = parts[0].replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    return parts.length > 1 ? '$intPart.${parts[1]}' : intPart;
  }


  @override
  void initState() {
    // TODO: implement initState.
    _fetchApiResponse();
    displayTaxCodeList = taxCodesDELine;
    makeEmpty();
    super.initState();
  }
  @override
  void dispose() {
    tdsAmountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(elevation: 3,
        centerTitle: true,
        title: const Text("Direct Expenses",
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
      body:isLoading ? const Center(child:  CircularProgressIndicator()): Scaffold(
        appBar:AppBar(
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
                      if (companyDropdownValue == "--Select Company Code--"){
                        showToast(
                          context: context,
                          title: 'Select Company Code',
                          description: 'Company Code Required',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      else if(vendorController.text.isEmpty || vendorController.text == ""){
                        showToast(
                          context: context,
                          title: 'Vendor Code',
                          description: 'Please Vendor Code',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      else if(postingDateController.text.isEmpty || postingDateController.text == ""){
                        showToast(
                          context: context,
                          title: 'Posting Date',
                          description: 'Please select posting date',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      else if(invoicingDateController.text.isEmpty || invoicingDateController.text ==""){
                        showToast(
                          context: context,
                          title: 'Invoicing Date',
                          description: 'Invoicing date is required',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      else if(postingDateController.text != invoicingDateController.text){
                        showToast(
                          context: context,
                          title: 'Posting Date & Invoice Date',
                          description: 'Posting Date & Invoice Date Should Be Same Please Check',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      else if(referenceController.text.isEmpty || referenceController.text == ""){
                        showToast(
                          context: context,
                          title: 'Reference',
                          description: 'Reference Text Required',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      else if(businessController.text.isEmpty || businessController.text == ""){
                        showToast(
                          context: context,
                          title: 'Business Place',
                          description: 'Business Place Is Required',
                          type: ToastificationType.error,
                          icon: Icons.clear,
                        );
                      }
                      else{
                        double tempTotal =0;
                        double withHTax = 0;

                         ///Commented
                        Map inputData = {
                          "companyCode": companyDropdownValue,
                          "vendorCode":vendorController.text,
                          "postingDate": postingDateController.text,
                          "invoiceDate": invoicingDateController.text,
                          "reference": referenceController.text,
                          "taxCodeType":taxCodeType,
                          "wHTCode":withholdingTaxController.text,
                          "wHTCalculate":withholdingTaxCalculateCont.text=="Yes"?true:withholdingTaxCalculateCont.text=="No"?false : null,
                          "tDSAmount":tdsAmountController.text,
                          "headerTotal":"0",
                          'taxCodePer':"0",
                          "table": directExpense,
                        };
                        // print('--------directExpense---------');
                        // print(directExpense);

                        //TotalAmount
                        for(int i=0;i<directExpense.length;i++){
                          try{
                            tempTotal = (tempTotal + double.parse(directExpense[i]['totalAmount'].toString()));
                          }
                          catch(e){
                            error = true;
                          }
                        }

                        //withHoldingTax
                        // for (var expense in directExpense) {
                        //   try {
                        //     if (expense['withHoldingTax'] == "Yes") {
                        //       withHTax += double.parse(expense['totalAmount']?.toString() ?? '0');
                        //       print('----------Testing----------');
                        //       print(withHTax);
                        //     } else {
                        //       break; // Stop processing further if 'withHoldingTax' is not "Yes"
                        //     }
                        //   } catch (e) {
                        //     error = true; // Handle errors gracefully
                        //   }
                        // }
                        ///Previous Withholding Tax isNotEmpty Withholding Tax CalculateCont should be Mandatory.
                        // if((withholdingTaxController.text.isNotEmpty || withholdingTaxController.text!="") &&
                        //     (withholdingTaxCalculateCont.text=="" || withholdingTaxCalculateCont.text.isEmpty)){
                        //   showToast(
                        //     context: context,
                        //     title: 'Withholding Tax Calculate',
                        //     description: 'Withholding Tax Calculate Required...',
                        //     type: ToastificationType.error,
                        //     icon: Icons.clear,
                        //   );
                        // }

                        //For Error.
                        for(int i=0;i<inputData['table'].length;i++){
                          if(inputData['table'][i]['GLAccount'] == "" || inputData['table'][i]['GLAccount'].isEmpty){
                            error = true;
                          }
                         else if(inputData['table'][i]['costCenter'] == "" || inputData['table'][i]['costCenter'].isEmpty){
                            error = true;
                          }
                          else if(inputData['table'][i]['amount'] == "" || inputData['table'][i]['amount'].isEmpty){
                            error = true;
                          }

                          else{
                            error = false;
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

                            inputData['taxCodePer'] = ((double.parse(withHTax.toStringAsFixed(2)) / 100) * 10) .toStringAsFixed(2);

                        final builder = xml.XmlBuilder();
                          ///New
                          builder.element('soapenv:Envelope', nest: () {
                            builder.attribute('xmlns:soapenv', 'http://schemas.xmlsoap.org/soap/envelope/');
                            builder.attribute('xmlns:sfin', 'http://sap.com/xi/SAPSCORE/SFIN');
                            builder.element('soapenv:Header', nest: () {});
                            builder.element('soapenv:Body', nest: () {
                              builder.element('sfin:JournalEntryBulkCreateRequest', nest: () {
                                builder.element('MessageHeader', nest: () {
                                  builder.element('ID', nest: 'MSG_JournalEntryCreateConfi');
                                  builder.element('CreationDateTime', nest: '${inputData['postingDate']}T00:00:00.107Z');
                                });
                                builder.element('JournalEntryCreateRequest', nest: () {
                                  builder.element('MessageHeader', nest: () {
                                    builder.element('ID', nest: 'SUB_MSG_JournalEntryCreateConfi');
                                    builder.element('CreationDateTime', nest: '${inputData['postingDate']}T00:00:00.107Z');
                                  });
                                  builder.element('JournalEntry', nest: () {
                                    builder.element('OriginalReferenceDocumentType', nest: 'BKPFF');
                                    builder.element('BusinessTransactionType', nest: 'RFBU');
                                    builder.element('AccountingDocumentType', nest: 'KR');
                                    builder.element('DocumentHeaderText',nest: "");
                                    builder.element('CompanyCode', nest: inputData['companyCode']);
                                    builder.element('DocumentDate', nest: inputData['invoiceDate']);
                                    builder.element('PostingDate', nest: inputData['postingDate']);
                                    builder.element('TaxDeterminationDate', nest: inputData['postingDate']);
                                    builder.element('TaxReportingDate', nest: inputData['invoiceDate']);
                                    builder.element('DocumentReferenceID', nest: inputData['reference']);
                                    builder.element('CreatedByUser', nest: 'INTEGRATION');
                                    builder.element('CreditorItem', nest: () {
                                      builder.element('ReferenceDocumentItem', nest: '1');
                                      builder.element('Creditor', nest: inputData['vendorCode']);
                                      //Pending Dynamic AmountInTransactionCurrency.
                                      builder.element('AmountInTransactionCurrency',
                                        nest: '-${inputData['headerTotal']}',
                                        attributes: {'currencyCode': "INR"},
                                      );

                                      builder.element('DebitCreditCode', nest: 'H');
                                    });
                                    //ITEM Table.
                                    for(int t=0;t< inputData['table'].length;t++){
                                    builder.element('Item', nest: () {
                                        final item = inputData['table'][t];
                                        builder.element('GLAccount', nest: item['GLAccount']);
                                        //Pending Dynamic AmountInTransactionCurrency.
                                        builder.element('AmountInTransactionCurrency',
                                          nest: item['amount'],
                                          attributes: {'currencyCode': "INR"},
                                        );
                                        builder.element('DebitCreditCode', nest: 'S');
                                        ///Newly Added.
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

                                        builder.element('AccountAssignment', nest: () {
                                          builder.element('CostCenter', nest: item['costCenter']);
                                        });
                                        //Static.
                                        builder.element('BusinessPlace', nest: businessController.text);
                                    });
                                    }
                                    //ProductTaxItem.
                                    for(int tC=0;tC< inputData['table'].length;tC++){
                                      final productTax = inputData['table'][tC];
                                      if(productTax['taxCode']!= null && productTax['taxCode']!= ""){
                                        builder.element('ProductTaxItem', nest: () {
                                          builder.element('TaxCode', nest: productTax['taxCode']);
                                          builder.element('TaxItemGroup', nest: "001");
                                          builder.element('TaxItemClassification', nest: '');
                                          builder.element('TaxJurisdiction', nest: '');
                                          builder.element('AmountInTransactionCurrency', attributes: {'currencyCode': 'INR'}, nest: productTax['taxAmount'].toString());
                                          builder.element('TaxBaseAmountInTransCrcy', attributes: {'currencyCode': 'INR'}, nest: productTax['amount'].toString());
                                        });
                                      }
                                    }

                                    if( (withholdingTaxController.text.isNotEmpty || withholdingTaxController.text!="") &&
                                        // (withholdingTaxCalculateCont.text.isNotEmpty || withholdingTaxCalculateCont.text != "") &&
                                        (tdsAmountController.text.isNotEmpty || tdsAmountController.text != "")
                                    ){
                                      builder.element('WithholdingTaxItem', nest: () {
                                        builder.element('ReferenceDocumentItem', nest: '3');
                                        builder.element('WithholdingTaxType', nest: inputData['taxCodeType']);
                                        builder.element('WithholdingTaxCode', nest: inputData['wHTCode']);

                                        ///Default True
                                         builder.element('TaxIsToBeCalculated', nest:true);
                                        // builder.element('TaxIsToBeCalculated', nest: inputData['wHTCalculate']);

                                        //Pending Dynamic AmountInTransactionCurrency.
                                        builder.element('AmountInTransactionCurrency',
                                         // nest: '${inputData['taxCodePer']}',
                                          nest:tdsAmountController.text,
                                          attributes: {'currencyCode': "INR"},
                                        );
                                        builder.element('TaxBaseAmountInTransCrcy',
                                          nest: '${inputData['headerTotal']}',
                                          attributes: {'currencyCode': "INR"},
                                        );
                                      });
                                    }

                                  });
                                });
                              });
                            });
                          });

                          // Convert XML builder to a string
                          final xmlString = builder.buildDocument().toXmlString(pretty: true);
                          bool returnValue = await postDataDirectExpense(xmlString,context,mounted);
                          if(returnValue){
                          directExpense = [];
                          companyDropdownValue = "--Select Company Code--";
                          vendorController.clear();
                          postingDateController.clear();
                          invoicingDateController.clear();
                          referenceController.clear();
                          withholdingTaxController.clear();
                          withholdingTaxCalculateCont.clear();
                          tdsAmountController.clear();
                          withholdingTaxCalculateCont.clear();
                          withholdingTaxController.text="";
                          withholdingTaxCalculateCont.text ="";
                          tdsAmountController.text = "";
                          tdsAmountController.clear();
                          businessController.text = "";
                          taxPec = "";
                          enableTaxCode = false;
                          //  directExpense = [
                          //   {
                          //     "GLAccount":"",
                          //     "shortText":"",
                          //     "Dc":"",
                          //     "amount":"",
                          //     "taxCode":"",
                          //     "assignment":"",
                          //     "text":"",
                          //     "costCenter":"",
                          //     "withHoldingTax":'',
                          //     "enableTax":false
                          //   }
                          // ];

                           makeEmpty();
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
        ) ,
        body: Column(children: [
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
                                            width: 1400,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ///Left Side Details.
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
                                                              child:
                                                              ///Dropdown.
                                                              DropdownButton<String>(
                                                                iconDisabledColor: Colors.blue,
                                                                iconEnabledColor: Colors.blue,
                                                                padding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
                                                                isExpanded: true,
                                                                underline: Container(),
                                                                style: const TextStyle(fontSize: 14),
                                                                value: companyDropdownValue.isEmpty ? null : companyDropdownValue,
                                                                // hint: const Text("Enter Company Code"),
                                                                items: companyCodeDE.map((String items) {
                                                                  return DropdownMenuItem(
                                                                    value: items,
                                                                    child: Text(items),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (value) async {
                                                                  setState(() {
                                                                    companyDropdownValue = value!;
                                                                  });
                                                                  ///API Call.
                                                                 // await triggerBalanceApis();
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const SizedBox(
                                                                width: 200,
                                                                child: Row(
                                                                  children: [
                                                                    Text("Vendor"),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(top: 4.0,left: 4),
                                                                      child: Text("*",style: TextStyle(color: Colors.red),),
                                                                    )
                                                                  ],
                                                                )
                                                            ),
                                                            ///OLD Vendor.
                                                            // Column(
                                                            //   crossAxisAlignment: CrossAxisAlignment.start,
                                                            //   children: [
                                                            //     SizedBox(
                                                            //         width: 200,
                                                            //         child: CustomTextFieldSearch(
                                                            //           showAdd: false,
                                                            //           decoration: Utils.dateDecoration(hintText: 'Enter Vendor',),
                                                            //           controller: vendorController,
                                                            //           future: (){
                                                            //             return getVendorCodes();
                                                            //           },
                                                            //           getSelectedValue: (SearchVendor v){
                                                            //             setState(() {
                                                            //               vendorController.text =  v.supplier;
                                                            //                vendorName = v.supplierName;
                                                            //             });
                                                            //           },
                                                            //         )
                                                            //     ),
                                                            //     const SizedBox(height: 5,),
                                                            //     if(vendorName != "")
                                                            //       Text(vendorName)
                                                            //   ],
                                                            // ),

                                                            ///New Vendor.
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                ///Old
                                                                // SizedBox(
                                                                //   width: 200,
                                                                //   child: LayoutBuilder(
                                                                //     builder: (BuildContext context, BoxConstraints constraints) {
                                                                //       return CustomPopupMenuButton(
                                                                //         textController: vendorController,
                                                                //         elevation: 4,
                                                                //         decoration:
                                                                //         Utils.customPopupDecoration(hintText: "Select Vendor"),
                                                                //         itemBuilder: (BuildContext context) {
                                                                //           return vendorCodeList.map((value) {
                                                                //             value as Map;
                                                                //             return CustomPopupMenuItem(
                                                                //               value: value, // Pass the whole map as the value
                                                                //               text: value['Supplier']!,
                                                                //               child: Container(),
                                                                //             );
                                                                //           }).toList();
                                                                //         },
                                                                //         onSelected: (value) {
                                                                //           print('-----Debug---value--------');
                                                                //           print(value);
                                                                //           setState(() {
                                                                //             withholdingTaxController.text = "";
                                                                //             withHoldingName = '';
                                                                //             taxCodesList = [];
                                                                //             vendorController.text = value['Supplier'].toString();
                                                                //             vendorName = value['SupplierName'].toString();
                                                                //             if(vendorController.text != "" || vendorController.text.isNotEmpty){
                                                                //                withholdingTaxCodes(vendorController.text);
                                                                //             }
                                                                //           });
                                                                //         },
                                                                //         onCanceled: () {},
                                                                //         hintText: "",
                                                                //         childWidth: constraints.maxWidth,
                                                                //         child: Container(),
                                                                //       );
                                                                //     },
                                                                //   ),
                                                                // ),
                                                                ///New.
                                                                SizedBox(
                                                                  width: 200,
                                                                  child: TextField(
                                                                    controller: vendorController,
                                                                    decoration: Utils.customerFieldDecoration(
                                                                      hintText: 'Search Vendor',
                                                                      controller: vendorController,
                                                                    ),
                                                                    onTap: () {
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (context) => _showDialogVendor(),
                                                                      ).then((value) async {
                                                                        // print('-------Test--------');
                                                                        // print(value);
                                                                        if (value != null && value is Map) {
                                                                          setState(() {
                                                                            withholdingTaxController.text = "";
                                                                            tdsAmountController.text = "";
                                                                            withHoldingName = '';
                                                                            taxCodesList = [];
                                                                            vendorController.text = value['Supplier'].toString();
                                                                            vendorName = value['SupplierName'].toString();
                                                                            if(vendorController.text != "" || vendorController.text.isNotEmpty){
                                                                              withholdingTaxCodes(vendorController.text);
                                                                            }
                                                                          });
                                                                        }
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 5,),
                                                                if(vendorName != "")
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      SizedBox(
                                                                        width:180,
                                                                          child: Text(vendorName,style: const TextStyle(fontSize: 11,
                                                                          fontWeight: FontWeight.bold
                                                                            ),)),
                                                                    ],
                                                                  )
                                                              ],
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
                                                                controller: postingDateController,
                                                                showCursor: false,
                                                                focusNode: postingDateNode,
                                                                decoration: Utils.dateDecoration(hintText: "Posting Date"),
                                                                onTap: () async {
                                                                  DateTime? startDate = await showDatePicker(
                                                                      helpText: "Posting Date",
                                                                      context: context,
                                                                      initialDate: DateTime.now(),
                                                                      firstDate: DateTime(1990),
                                                                      lastDate: DateTime(2100)
                                                                  );
                                                                  if (startDate != null) {
                                                                    String formattedDate = DateFormat('yyyy-MM-dd').format(startDate);
                                                                    postingDateController.text = formattedDate;
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
                                                                width: 200,
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
                                                      //Reference.
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                                width: 200,
                                                                child: Row(
                                                                  children: [
                                                                    Text("Reference"),
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
                                                                controller: referenceController,
                                                                // showCursor: false,
                                                                 focusNode: referenceNode,
                                                                decoration: Utils.dateDecoration(hintText: "Enter Reference"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      /// Business Place.
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                                width: 200,
                                                                child: Row(
                                                                  children: [
                                                                    Text("Business Place"),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(top: 4.0,left: 4),
                                                                      child: Text("*",style: TextStyle(color: Colors.red),),
                                                                    )
                                                                  ],
                                                                )
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 200,
                                                                  child: LayoutBuilder(
                                                                    builder: (BuildContext context, BoxConstraints constraints) {
                                                                      return CustomPopupMenuButton(
                                                                        textController: businessController,
                                                                        elevation: 4,
                                                                        decoration:Utils.customPopupDecoration(hintText: "Select Business Place"),
                                                                        itemBuilder: (BuildContext context) {
                                                                          return businessPlaceList.map((value) {
                                                                            value as Map;
                                                                            // print('-----Selected Value------');
                                                                            // print(value);
                                                                            return CustomPopupMenuItem(
                                                                              value: value, // Pass the whole map as the value
                                                                              text: "${value['businessPlace']} - ${value['businessPlaceDescription']}",
                                                                              child: Container(),
                                                                            );
                                                                          }).toList();
                                                                        },
                                                                        onSelected: (value) async{
                                                                          businessController.text = value['businessPlace'];
                                                                          businessDes = value['businessPlaceDescription'];
                                                                          setState(() { });
                                                                        },
                                                                        onCanceled: () {},
                                                                        hintText: "",
                                                                        childWidth: constraints.maxWidth,
                                                                        child: Container(),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 5,),
                                                                if(businessDes != "")
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      SizedBox(
                                                                          width:180,
                                                                          child: Text(businessDes,style: const TextStyle(fontSize: 11,
                                                                              fontWeight: FontWeight.bold
                                                                          ),)),
                                                                    ],
                                                                  )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(color: const Color(0x6E0075BB),
                                                    height: 350,
                                                    width: 1),
                                                ///Middle.
                                                Padding(
                                                  padding: const EdgeInsets.all(0.0),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(height: 40,
                                                          width: 100,
                                                          child: Center(child: Text("Tax",
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
                                                        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const SizedBox(
                                                                width: 200,
                                                                child: Row(
                                                                  children: [
                                                                    Text("Withholding Tax"),
                                                                    // Padding(
                                                                    //   padding: EdgeInsets.only(top: 4.0,left: 4),
                                                                    //   child: Text("*",style: TextStyle(color: Colors.red),),
                                                                    // )
                                                                  ],
                                                                )
                                                            ),
                                                            ///OLD
                                                            // SizedBox(
                                                            //     width: 200,
                                                            //     child: CustomTextFieldSearch(
                                                            //       showAdd: false,
                                                            //       decoration: Utils.dateDecoration(hintText: 'Enter WHTCode',),
                                                            //       controller: withholdingTaxController,
                                                            //       future: (){
                                                            //         return getWithHoldingTaxCodes();
                                                            //       },
                                                            //       getSelectedValue: (SearchWithHoldingTaxCode v){
                                                            //         setState(() {
                                                            //           withholdingTaxController.text = v.taxCode;
                                                            //           taxCodeType = v.taxType;
                                                            //           taxPec = v.rate.toString();
                                                            //
                                                            //           ///TDS Amount.
                                                            //           for(int ewCost=0;ewCost<directExpense.length;ewCost++){
                                                            //             ///TDS Amount.
                                                            //             if ((taxPec.isNotEmpty && taxPec != "") &&
                                                            //                 (directExpense[ewCost]["amount"] != "" &&
                                                            //                     directExpense[ewCost]["amount"].toString().isNotEmpty)) {
                                                            //
                                                            //               double wHTPer = double.parse(taxPec.toString());
                                                            //               double tempTotal = 0.0;
                                                            //               if(tdsAmountController.text != "" || tdsAmountController.text.isNotEmpty){
                                                            //                 for (var expense in directExpense) {
                                                            //                   final amount = expense['amount']?.toString();
                                                            //
                                                            //                   if (amount != null && amount.isNotEmpty) {
                                                            //                     if (expense['withHoldingTax'] == "Yes") {
                                                            //                       tempTotal += double.parse(amount);
                                                            //                     }
                                                            //                   }
                                                            //                 }
                                                            //                 // Update the controller once, outside the loop
                                                            //                 tdsAmountController.text = ((tempTotal / 100) * wHTPer).toStringAsFixed(2);
                                                            //               }
                                                            //               else{
                                                            //                 tempTotal = double.parse(directExpense[ewCost]['amount'].toString());
                                                            //                 tdsAmountController.text = ((tempTotal / 100) * wHTPer).toStringAsFixed(2);
                                                            //               }
                                                            //             }
                                                            //           }
                                                            //
                                                            //         });
                                                            //       },
                                                            //       onChanged: (val){
                                                            //       if(withholdingTaxController.text.isEmpty || withholdingTaxController.text==""){
                                                            //         withholdingTaxCalculateCont.clear();
                                                            //         withholdingTaxController.text="";
                                                            //         withholdingTaxCalculateCont.text ="";
                                                            //         tdsAmountController.text = "";
                                                            //         tdsAmountController.clear();
                                                            //         taxPec = "";
                                                            //       }
                                                            //     },
                                                            //     )
                                                            // ),

                                                            ///New.
                                                            Column(children: [
                                                              SizedBox(
                                                                width: 200,
                                                                child: LayoutBuilder(
                                                                  builder: (BuildContext context, BoxConstraints constraints) {
                                                                    return CustomPopupMenuButton(
                                                                      textController: withholdingTaxController,
                                                                      elevation: 4,
                                                                      decoration:
                                                                      Utils.customPopupDecoration(hintText: "Select WHTCode"),
                                                                      itemBuilder: (BuildContext context) {
                                                                        return taxCodesList.map((value) {
                                                                          value as Map;
                                                                          String errorMsg = "";
                                                                          if(value.containsKey("Message") ){
                                                                            errorMsg = value['Message']??"";
                                                                          }
                                                                          return CustomPopupMenuItem(
                                                                            value: value, // Pass the whole map as the value
                                                                            text:errorMsg !="" ? errorMsg :  value['WithholdingTaxCode'],
                                                                            child: Container(),
                                                                          );
                                                                        }).toList();
                                                                      },
                                                                      onSelected: (value) async{
                                                                        setState(() {
                                                                          log('-----Withholding selecting-------');
                                                                          log(value.toString());
                                                                          withholdingTaxController.text = value['WithholdingTaxCode'];
                                                                          taxCodeType = value['WithholdingTaxType'];
                                                                          taxPec = value['Rate'];
                                                                          withHoldingName = value['WithHoldgingName'];
                                                                          ///TDS Amount.
                                                                          for(int ewCost=0;ewCost<directExpense.length;ewCost++){
                                                                            ///TDS Amount.
                                                                            if ((taxPec.isNotEmpty && taxPec != "") &&
                                                                                (directExpense[ewCost]["amount"] != "" &&
                                                                                    directExpense[ewCost]["amount"].toString().isNotEmpty)) {

                                                                              double wHTPer = double.parse(taxPec.toString());
                                                                              double tempTotal = 0.0;
                                                                              if(tdsAmountController.text != "" || tdsAmountController.text.isNotEmpty){
                                                                                for (var expense in directExpense) {
                                                                                  final amount = expense['amount']?.toString();

                                                                                  if (amount != null && amount.isNotEmpty) {
                                                                                    if (expense['withHoldingTax'] == "Yes") {
                                                                                      tempTotal += double.parse(amount);
                                                                                    }
                                                                                  }
                                                                                }
                                                                                // Update the controller once, outside the loop
                                                                                tdsAmountController.text = ((tempTotal / 100) * wHTPer).toStringAsFixed(2);
                                                                              }
                                                                              else{
                                                                                tempTotal = double.parse(directExpense[ewCost]['amount'].toString());
                                                                                tdsAmountController.text = ((tempTotal / 100) * wHTPer).toStringAsFixed(2);
                                                                              }
                                                                            }
                                                                          }
                                                                        });
                                                                      },

                                                                      onCanceled: () {},
                                                                      hintText: "",
                                                                      childWidth: constraints.maxWidth,
                                                                      child: Container(),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              const SizedBox(height: 5,),
                                                              if(withHoldingName != "")
                                                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    SizedBox(
                                                                    width:200,
                                                                       child: Text(withHoldingName)),
                                                                  ],
                                                                )
                                                            ],)
                                                          ],
                                                        ),
                                                      ),

                                                      ///Withholding Tax Calculate
                                                      // Padding(
                                                      //   padding: const EdgeInsets.all(8),
                                                      //   child: Row(
                                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                                      //     children: [
                                                      //       const SizedBox(
                                                      //           width: 200,
                                                      //           child: Row(
                                                      //             children: [
                                                      //               Text("Withholding Tax Calculate"),
                                                      //               // Padding(
                                                      //               //   padding: EdgeInsets.only(top: 4.0,left: 4),
                                                      //               //   child: Text("*",style: TextStyle(color: Colors.red),),
                                                      //               // )
                                                      //             ],
                                                      //           )
                                                      //       ),
                                                      //       SizedBox(
                                                      //         height: 30,
                                                      //         width: 200,
                                                      //         child: Focus(
                                                      //             skipTraversal: true,
                                                      //             descendantsAreFocusable: true,
                                                      //             child: LayoutBuilder(
                                                      //               builder: (BuildContext context, BoxConstraints constraints) {
                                                      //                 return
                                                      //                   CustomPopupMenuButton(
                                                      //                   decoration: Utils.customPopupDecoration2(hintText:"Withholding tax Calculate",),
                                                      //                   itemBuilder: (BuildContext context) {
                                                      //                     return withholdingTaxList;
                                                      //                   },
                                                      //                   hintText: "",
                                                      //                   childWidth: constraints.maxWidth,
                                                      //                   textController: withholdingTaxCalculateCont,
                                                      //                   shape:  const RoundedRectangleBorder(
                                                      //                     side: BorderSide(color: mSaveButtonBorder),
                                                      //                     borderRadius: BorderRadius.all(
                                                      //                       Radius.circular(5),
                                                      //                     ),
                                                      //                   ),
                                                      //                   offset: const Offset(1, 40),
                                                      //                   tooltip: '',
                                                      //                   onSelected: ( value) {
                                                      //                     setState(() {
                                                      //                       withholdingTaxCalculateCont.text = value;
                                                      //
                                                      //                       for(int index=0;index<directExpense.length;index++){
                                                      //                         ///TDS Amount.
                                                      //                         if ((taxPec.isNotEmpty && taxPec != "") &&
                                                      //                             (directExpense[index]["amount"] != "" &&
                                                      //                                 directExpense[index]["amount"].toString().isNotEmpty)) {
                                                      //
                                                      //                           double wHTPer = double.parse(taxPec.toString());
                                                      //                           double tempTotal = 0.0;
                                                      //                           if(tdsAmountController.text != "" || tdsAmountController.text.isNotEmpty){
                                                      //                             for (var expense in directExpense) {
                                                      //                               final amount = expense['amount']?.toString();
                                                      //                               if (amount != null && amount.isNotEmpty) {
                                                      //                                 if (expense['withHoldingTax'] == "Yes") {
                                                      //                                   tempTotal += double.parse(amount);
                                                      //                                 }
                                                      //                               }
                                                      //                             }
                                                      //                              // Update the controller once, outside the loop
                                                      //                             tdsAmountController.text = ((tempTotal / 100) * wHTPer).toStringAsFixed(2);
                                                      //                           }
                                                      //                           else{
                                                      //                             tempTotal = double.parse(directExpense[index]['amount'].toString());
                                                      //                             tdsAmountController.text = ((tempTotal / 100) * wHTPer).toStringAsFixed(2);
                                                      //                           }
                                                      //                         }
                                                      //                       }
                                                      //                     });
                                                      //                   },
                                                      //                   onCanceled: () {
                                                      //
                                                      //                   },
                                                      //                   child: Container(),
                                                      //                 );
                                                      //               },
                                                      //             )
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),

                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                                width: 200,
                                                                child: Row(
                                                                  children: [
                                                                    Text("TDS Amount"),
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
                                                                readOnly: true,
                                                                controller: tdsAmountController,
                                                                decoration: Utils.dateDecoration(hintText: "TDS Amount"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(color: const Color(0x6E0075BB),
                                                    height: 350,
                                                    width: 1),
                                                ///Right
                                                Padding(
                                                  padding: const EdgeInsets.all(0.0),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(height: 40,
                                                          width: 100,
                                                          child: Center(child: Text("Calculate Tax",
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
                                                                width: 200,
                                                                child: Row(
                                                                  children: [
                                                                    Text("Calculate Tax"),
                                                                    // Padding(
                                                                    //   padding: EdgeInsets.only(top: 4.0,left: 4),
                                                                    //   child: Text("*",style: TextStyle(color: Colors.red),),
                                                                    // )
                                                                  ],
                                                                )
                                                            ),
                                                            Checkbox(
                                                              value: enableTaxCode,
                                                              onChanged: (bool? value) {
                                                                setState(() {
                                                                  enableTaxCode = value ?? false; // Handle null safety
                                                                });
                                                              },
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            ///Table.
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
                                          width: 2200,
                                          color: Colors.grey[200],
                                          child:const  Row(
                                            children: [
                                              SizedBox(
                                                  width: 150,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Text("Serial Number", style: TextStyle(
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
                                                          "G/L Account",
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
                                                        Text("Short Text", style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.center,),
                                                        // Padding(
                                                        //   padding: EdgeInsets.only(top: 4.0,left: 4),
                                                        //   child: Text("*",style: TextStyle(color: Colors.red),),
                                                        // )
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
                                                        Text("D/C", style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.center,),

                                                        // Padding(
                                                        //   padding: EdgeInsets.only(top: 4.0,left: 4),
                                                        //   child: Text("*",style: TextStyle(color: Colors.red),),
                                                        // )
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
                                                        Text("Amount", style: TextStyle(
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
                                                        Text("Tax Code", style: TextStyle(
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
                                                    child: Text("Assignment", style: TextStyle(
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
                                                        Text("Text", style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.center,),

                                                      ],
                                                    ),
                                                  )
                                              ),
                                              SizedBox(
                                                  width: 200,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                              SizedBox(
                                                  width: 200,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text("Enable Withholding Cost", style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.center,),
                                                        // Padding(
                                                        //   padding: EdgeInsets.only(top: 4.0,left: 4),
                                                        //   child: Text("*",style: TextStyle(color: Colors.red),),
                                                        // )
                                                      ],
                                                    ),
                                                  )
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 20),
                                                child: Text("+ ADD", style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,),
                                              ),

                                              // Padding(
                                              //   padding: EdgeInsets.only(left: 40),
                                              //   child: Text("Enable Tax Code", style: TextStyle(
                                              //       fontSize: 12,
                                              //       fontWeight: FontWeight.bold),
                                              //     textAlign: TextAlign.center,),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        ///Table Body
                                        SizedBox(
                                          width: 2200,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: directExpense.length,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context, index) {
                                              taxCodeNamesList.add(TextEditingController(text: ""));
                                              glNameList.add(TextEditingController(text: ""));
                                              costCenterNameList.add(TextEditingController(text: ""));

                                              TextEditingController amountController = TextEditingController();
                                              amountController.text = (directExpense[index]["amount"] ?? "").toString();

                                              // amountController.selection =
                                              //     TextSelection.fromPosition(TextPosition(
                                              //         offset: amountController.text.length));
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
                                                      /// OLD GL
                                                      // SizedBox(
                                                      //     width: 200,
                                                      //     child: Padding(
                                                      //       padding: const EdgeInsets.all(8.0),
                                                      //       child: CustomTextFieldSearch(
                                                      //         showAdd: false,
                                                      //         decoration: Utils.customerFieldDecoration(hintText: 'Enter G/L Account',
                                                      //             controller: TextEditingController(text: "")),
                                                      //         controller: TextEditingController(text: directExpense[index]['GLAccount']),
                                                      //         future: (){
                                                      //           return getGLCodes();
                                                      //         },
                                                      //         getSelectedValue: (SearchGL v){
                                                      //           setState(() {
                                                      //             directExpense[index]["GLAccount"] = v.label;
                                                      //           });
                                                      //         },
                                                      //
                                                      //       ),
                                                      //     )
                                                      // ),
                                                      ///New.
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
                                                          //               text: directExpense[index]["GLAccount"] ?? ""),
                                                          //           elevation: 4,
                                                          //           decoration: Utils.customPopupDecoration(hintText: "Select GL"),
                                                          //           itemBuilder: (BuildContext context) {
                                                          //             return glAccountList.map((value) {
                                                          //               value as Map;
                                                          //               return CustomPopupMenuItem(
                                                          //                 value: value, // Pass the whole map as the value
                                                          //                 text: value['GLAccount']!,
                                                          //                 child: Container(),
                                                          //               );
                                                          //             }).toList();
                                                          //           },
                                                          //           onSelected: (value) {
                                                          //             // print('-----Debug---value--------');
                                                          //             // print(value);
                                                          //             setState(() {
                                                          //               directExpense[index]["GLAccount"] = value['GLAccount'].toString();
                                                          //               directExpense[index]['shortText'] = value['GLAccountName'].toString();
                                                          //               // glNameList[index].text = value['GLAccountName'].toString();
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
                                                          ///New.
                                                          SizedBox(
                                                            width: 200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: TextField(
                                                                controller: TextEditingController(text: directExpense[index]["GLAccount"] ?? ""),
                                                                decoration: Utils.customerFieldDecoration(
                                                                  hintText: 'Search GL',
                                                                  controller: TextEditingController(text: directExpense[index]["GLAccount"] ?? ""),
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
                                                                        directExpense[index]["GLAccount"] = value['GLAccount'].toString();
                                                                        glNameList[index].text = value['GLAccountName'].toString();
                                                                        directExpense[index]['shortText'] = value['GLAccountName'].toString();
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
                                                          width: 200,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: TextFormField(readOnly: true,
                                                              style: const TextStyle(
                                                                  fontSize: 14),
                                                              controller: TextEditingController(text: directExpense[index]['shortText']??""),
                                                              decoration: Utils.customerFieldDecoration(
                                                                  hintText: 'Enter Short Text',
                                                                  controller: TextEditingController(text: directExpense[index]['shortText']),),
                                                              onChanged: (value) {
                                                                directExpense[index]['shortText'] = value;
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
                                                              style: const TextStyle(
                                                                  fontSize: 14),
                                                              controller: TextEditingController(text: "Debit "),
                                                              //controller: TextEditingController(text: directExpense[index]['Dc']),
                                                              decoration: Utils.customerFieldDecoration(
                                                                  hintText: 'Enter D/C',
                                                                  controller: TextEditingController(text: "Debit "),),
                                                                  //controller: TextEditingController(text: directExpense[index]['Dc']),),
                                                              onChanged: (value) {
                                                                directExpense[index]['Dc'] = value;
                                                              },
                                                            ),
                                                          )
                                                      ),
                                                      SizedBox(
                                                          width: 200,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: TextFormField(
                                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                              style: const TextStyle(
                                                                  fontSize: 14),
                                                              controller: amountController,
                                                              decoration: Utils.customerFieldDecoration(
                                                                  hintText: 'Enter Amount',
                                                                  controller: amountController ),
                                                              onChanged: (value) {
                                                                String rawValue = value.replaceAll(',', '');
                                                                directExpense[index]["amount"] = rawValue;

                                                                if (directExpense[index]["taxValue"] != null) {
                                                                  String taxAmount = (double.parse(directExpense[index]["taxValue"].toString()) * double.parse(rawValue) / 100).toStringAsFixed(2);
                                                                  String totalAmount = (double.parse(taxAmount) + double.parse(rawValue)).toStringAsFixed(2);
                                                                  directExpense[index]["taxAmount"] = taxAmount;
                                                                  directExpense[index]["totalAmount"] = totalAmount;
                                                                } else {
                                                                  directExpense[index]["totalAmount"] = rawValue;
                                                                }
                                                                ///TDS Amount.
                                                                if(value.isEmpty || value==""){
                                                                  tdsAmountController.text = "";
                                                                }
                                                                else{
                                                                  if ((taxPec.isNotEmpty && taxPec != "") &&
                                                                      (directExpense[index]["amount"] != "" &&
                                                                          directExpense[index]["amount"].toString().isNotEmpty)) {
                                                                    double wHTPer = double.parse(taxPec.toString());
                                                                    double tempTotal = 0.0;
                                                                    if(tdsAmountController.text != "" || tdsAmountController.text.isNotEmpty){
                                                                      for (var expense in directExpense) {
                                                                        final amount = expense['amount']?.toString();
                                                                        if (amount != null && amount.isNotEmpty) {
                                                                          if (expense['withHoldingTax'] == "Yes") {
                                                                            tempTotal += double.parse(amount);
                                                                          }
                                                                        }
                                                                      }
                                                                      // Update the controller once, outside the loop
                                                                      tdsAmountController.text = ((tempTotal / 100) * wHTPer).toStringAsFixed(2);
                                                                    }
                                                                    else{
                                                                      tempTotal = double.parse(directExpense[index]['amount'].toString());
                                                                      tdsAmountController.text = ((tempTotal / 100) * wHTPer).toStringAsFixed(2);
                                                                    }
                                                                  }
                                                                }

                                                                amountController.value = TextEditingValue(
                                                                  text: _formatWithCommas(rawValue),
                                                                  selection: TextSelection.collapsed(
                                                                      offset: _formatWithCommas(rawValue).length),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                      ),
                                                      ///OLD
                                                      // SizedBox(
                                                      //   width: 200,
                                                      //   child: Padding(
                                                      //     padding: const EdgeInsets.all(8.0),
                                                      //     child: LayoutBuilder(
                                                      //       builder: (BuildContext context, BoxConstraints constraints) {
                                                      //        // Check the condition for enableTaxCode
                                                      //         if (enableTaxCode || directExpense[index]['enableTax']) {
                                                      //           return CustomPopupMenuButton(
                                                      //             elevation: 4,
                                                      //             decoration: Utils.customPopupDecoration(
                                                      //               hintText: directExpense[index]["taxCode"] == ""
                                                      //                   ? "Select"
                                                      //                   : directExpense[index]["taxCode"],
                                                      //             ),
                                                      //             itemBuilder: (BuildContext context) {
                                                      //               return taxCode.entries.map((entry) {
                                                      //                 return CustomPopupMenuItem(
                                                      //                   value: entry.key,
                                                      //                   // Use the key to identify selection
                                                      //                   text: entry.key,
                                                      //                   // Display the key (e.g., "AA", "AB")
                                                      //                   child: Text("${entry.key} (${entry.value}%)"), // Show key and value
                                                      //                 );
                                                      //               }).toList();
                                                      //             },
                                                      //             onSelected: (selectedKey) {
                                                      //               String selectedValue = taxCode[selectedKey]!.toString(); // Get the value from the key
                                                      //               print('---------Line Level Items---------');
                                                      //               print("Selected Key: $selectedKey, Value: $selectedValue");
                                                      //               directExpense[index]["taxCode"] = selectedKey; // Update with the selected key
                                                      //               directExpense[index]["taxValue"] = selectedValue;
                                                      //               if (directExpense[index]["amount"] != "" && directExpense[index]["amount"] != null) {
                                                      //                 String taxAmount = (double.parse(directExpense[index]["taxValue"].toString()) *
                                                      //                     double.parse(directExpense[index]["amount"].toString()) / 100).toStringAsFixed(2);
                                                      //                 String totalAmount = (double.parse(taxAmount.toString()) +
                                                      //                     double.parse(directExpense[index]["amount"].toString())).toStringAsFixed(2);
                                                      //                 directExpense[index]["taxAmount"] = taxAmount;
                                                      //                 directExpense[index]["totalAmount"] = totalAmount;
                                                      //               }
                                                      //               setState(() {});
                                                      //             },
                                                      //             onCanceled: () {
                                                      //               // Handle cancel if needed
                                                      //             },
                                                      //             hintText: "",
                                                      //             childHeight: 200,
                                                      //             childWidth: constraints.maxWidth,
                                                      //             child: Container(),
                                                      //           );
                                                      //         }
                                                      //         else {
                                                      //           // Display a disabled dropdown-like container
                                                      //           return
                                                      //             Row(
                                                      //               children: [
                                                      //                 const Text("Enable Tax Code", style: TextStyle(
                                                      //                     fontSize: 12,
                                                      //                     fontWeight: FontWeight.bold),
                                                      //                   textAlign: TextAlign.center,),
                                                      //
                                                      //                 //   Container(
                                                      //                 //   height: 30,
                                                      //                 //   width: 100,
                                                      //                 //   padding: const EdgeInsets.symmetric(horizontal: 12),
                                                      //                 //   alignment: Alignment.centerLeft,
                                                      //                 //   decoration: BoxDecoration(
                                                      //                 //     border: Border.all(color: Colors.grey, width: 1),
                                                      //                 //     borderRadius: BorderRadius.circular(5),
                                                      //                 //     color: Colors.white,
                                                      //                 //   ),
                                                      //                 //   child: Text(
                                                      //                 //     "Enable Tax Above",
                                                      //                 //     style: TextStyle(color: Colors.grey[700]),
                                                      //                 //   ),
                                                      //                 // ),
                                                      //                  const SizedBox(width: 5,),
                                                      //                 Checkbox(
                                                      //                   value: directExpense[index]['enableTax'],
                                                      //                   onChanged: (bool? value) {
                                                      //                     setState(() {
                                                      //                       directExpense[index]['enableTax'] = value ?? false; // Handle null safety
                                                      //                     });
                                                      //                   },
                                                      //                 ),
                                                      //               ],
                                                      //             );
                                                      //         }
                                                      //       },
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      ///New.
                                                      Column(
                                                        children: [
                                                          ///Old
                                                          // SizedBox(
                                                          //   width: 200,
                                                          //   child: Padding(
                                                          //     padding: const EdgeInsets.all(8.0),
                                                          //     child: LayoutBuilder(
                                                          //       builder: (BuildContext context, BoxConstraints constraints) {
                                                          //         // Check the condition for enableTaxCode
                                                          //         if (enableTaxCode || directExpense[index]['enableTax']) {
                                                          //           return CustomPopupMenuButton(
                                                          //             elevation: 4,
                                                          //             decoration: Utils.customPopupDecoration(
                                                          //               hintText: directExpense[index]["taxCode"] == "" ? "Select" : directExpense[index]["taxCode"],
                                                          //             ),
                                                          //             itemBuilder: (BuildContext context) {
                                                          //               return taxCodesDELine.map((entry) {
                                                          //                 entry as Map;
                                                          //                 return CustomPopupMenuItem(
                                                          //                   value: entry,
                                                          //                   // Use the key to identify selection
                                                          //                   text: entry['TAXCODE'],
                                                          //                   child: Container(),
                                                          //                   // Display the key (e.g., "AA", "AB")
                                                          //                   // child: Text("${entry.key} (${entry.value}%)"), // Show key and value
                                                          //                 );
                                                          //               }).toList();
                                                          //             },
                                                          //             onSelected: (selectedKey) {
                                                          //               String selectedValue = selectedKey['TAXPER'].toString(); // Get the value from the key
                                                          //               print('---------Line Level Items---------');
                                                          //               print("Selected Key: ${selectedKey['TAXCODE']}, Value: $selectedValue");
                                                          //               directExpense[index]["taxCode"] = selectedKey['TAXCODE']; // Update with the selected key
                                                          //               directExpense[index]["taxValue"] = selectedValue;
                                                          //               if (directExpense[index]["amount"] != "" && directExpense[index]["amount"] != null) {
                                                          //                 String taxAmount = (double.parse(directExpense[index]["taxValue"].toString()) * double.parse(directExpense[index]["amount"].toString()) / 100).toStringAsFixed(2);
                                                          //                 String totalAmount = (double.parse(taxAmount.toString()) + double.parse(directExpense[index]["amount"].toString())).toStringAsFixed(2);
                                                          //                 directExpense[index]["taxAmount"] = taxAmount;
                                                          //                 directExpense[index]["totalAmount"] = totalAmount;
                                                          //               }
                                                          //
                                                          //               taxCodeNamesList[index].text = "${selectedKey['TAXCODE']}-${selectedKey['TAXCODENAME']}";
                                                          //               // print(taxCodeNamesList[index].text);
                                                          //               setState(() {});
                                                          //             },
                                                          //             onCanceled: () {
                                                          //               // Handle cancel if needed
                                                          //             },
                                                          //             hintText: "",
                                                          //             // childHeight: 200,
                                                          //             childWidth: constraints.maxWidth,
                                                          //             child: Container(),
                                                          //           );
                                                          //         }
                                                          //         else {
                                                          //           // Display a disabled dropdown-like container
                                                          //           return
                                                          //             Row(
                                                          //               children: [
                                                          //                 const Text("Enable Tax Code", style: TextStyle(
                                                          //                     fontSize: 12,
                                                          //                     fontWeight: FontWeight.bold),
                                                          //                   textAlign: TextAlign.center,),
                                                          //                 const SizedBox(width: 5,),
                                                          //                 Checkbox(
                                                          //                   value: directExpense[index]['enableTax'],
                                                          //                   onChanged: (bool? value) {
                                                          //                     setState(() {
                                                          //                       directExpense[index]['enableTax'] = value ?? false; // Handle null safety
                                                          //                     });
                                                          //                   },
                                                          //                 ),
                                                          //               ],
                                                          //             );
                                                          //         }
                                                          //       },
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          ///New.
                                                          if (enableTaxCode || directExpense[index]['enableTax'])...{
                                                            SizedBox(
                                                              width: 200,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: TextField(
                                                                  controller: TextEditingController(text: directExpense[index]["taxCode"] ?? ""),
                                                                  decoration: Utils.customerFieldDecoration(
                                                                    hintText: 'Search TaxName',
                                                                    controller: TextEditingController(text: directExpense[index]["taxCode"] ?? ""),
                                                                  ),
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context: context,
                                                                      builder: (context) => _showDialogTaxCodes(),
                                                                    ).then((value) async {
                                                                      if (value != null && value is Map) {

                                                                        String selectedValue = value['TAXPER'].toString(); // Get the value from the key
                                                                        print('---------Line Level Items---------');
                                                                        print("Selected Key: ${value['TAXCODE']}, Value: $selectedValue");
                                                                        directExpense[index]["taxCode"] = value['TAXCODE']; // Update with the selected key
                                                                        directExpense[index]["taxValue"] = selectedValue;
                                                                        if (directExpense[index]["amount"] != "" && directExpense[index]["amount"] != null) {
                                                                          String taxAmount = (double.parse(directExpense[index]["taxValue"].toString()) * double.parse(directExpense[index]["amount"].toString()) / 100).toStringAsFixed(2);
                                                                          String totalAmount = (double.parse(taxAmount.toString()) + double.parse(directExpense[index]["amount"].toString())).toStringAsFixed(2);
                                                                          directExpense[index]["taxAmount"] = taxAmount;
                                                                          directExpense[index]["totalAmount"] = totalAmount;
                                                                        }
                                                                        taxCodeNamesList[index].text = "${value['TAXCODE']}-${value['TAXCODENAME']}";

                                                                        setState(() {

                                                                        });
                                                                      }
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          }
                                                          else ...{
                                                            // Display a disabled dropdown-like container
                                                            Padding(padding:const EdgeInsets.all(8),
                                                            child: SizedBox(
                                                              width:200,
                                                              child: Row(
                                                                children: [
                                                                  const Text("Enable Tax Code", style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.bold),
                                                                    textAlign: TextAlign.center,),
                                                                  const SizedBox(width: 5,),
                                                                  Checkbox(
                                                                    value: directExpense[index]['enableTax'],
                                                                    onChanged: (bool? value) {
                                                                      setState(() {
                                                                        directExpense[index]['enableTax'] = value ?? false; // Handle null safety
                                                                      });
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            )
                                                          },
                                                          const SizedBox(height: 5),
                                                          if (taxCodeNamesList[index].text != "" && taxCodeNamesList.isNotEmpty ) // Check if GLAccountName exists
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
                                                      SizedBox(
                                                          width: 200,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: TextFormField(
                                                              style: const TextStyle(
                                                                  fontSize: 14),
                                                              controller: TextEditingController(text: directExpense[index]['assignment']),
                                                              decoration: Utils.customerFieldDecoration(
                                                                  hintText: 'Enter Assignment',
                                                                  controller: TextEditingController(text: directExpense[index]['assignment']),),
                                                              onChanged: (value) {
                                                                directExpense[index]['assignment'] = value;
                                                              },
                                                            ),
                                                          )
                                                      ),
                                                      SizedBox(
                                                          width: 200,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: TextFormField(
                                                              style: const TextStyle(
                                                                  fontSize: 14),
                                                              controller: TextEditingController(text: directExpense[index]['text']),
                                                              decoration: Utils.customerFieldDecoration(
                                                                  hintText: 'Enter Text',
                                                                  controller: TextEditingController(text: directExpense[index]['text']),),
                                                              onChanged: (value) {
                                                                directExpense[index]['text'] = value;
                                                              },
                                                            ),
                                                          )
                                                      ),
                                                      ///Enter Cost Center.
                                                      // SizedBox(
                                                      //     width: 200,
                                                      //     child: Padding(
                                                      //       padding: const EdgeInsets.all(8.0),
                                                      //       child: CustomTextFieldSearch(
                                                      //         showAdd: false,
                                                      //         decoration: Utils.customerFieldDecoration(hintText: 'Enter Cost Center',
                                                      //             controller: TextEditingController(text: "")),
                                                      //         controller: TextEditingController(text: directExpense[index]['costCenter']??""),
                                                      //         future: (){
                                                      //           return getCostCenterCodes();
                                                      //         },
                                                      //         getSelectedValue: (SearchCostCenter v){
                                                      //           setState(() {
                                                      //             directExpense[index]['costCenter'] = v.label;
                                                      //           });
                                                      //         },
                                                      //         onChanged: (val){
                                                      //           if(val.isEmpty || val==""){
                                                      //             directExpense[index]['costCenter'] = "";
                                                      //           }
                                                      //         },
                                                      //
                                                      //       ),
                                                      //     )
                                                      // ),
                                                      ///New Cost Center Dropdown
                                                      Column(
                                                        children: [
                                                          SizedBox(
                                                            width: 200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: LayoutBuilder(
                                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                                  return CustomPopupMenuButton(
                                                                    textController:TextEditingController(text: directExpense[index]['costCenter']),
                                                                    elevation: 4,
                                                                    decoration: Utils.customPopupDecoration(hintText: "Select Cost Center"),
                                                                    itemBuilder: (BuildContext context) {
                                                                      return costCenterList.map((entry) {
                                                                        entry as Map;
                                                                        return CustomPopupMenuItem(
                                                                          value: entry,
                                                                          text: "${entry['costCenter']} - ${entry['costCenterName']}",
                                                                          child: Container(),
                                                                        );
                                                                      }).toList();
                                                                    },
                                                                    onSelected: (value) {
                                                                      directExpense[index]['costCenter'] = value['costCenter'];
                                                                      costCenterNameList[index].text =  value['costCenterName'];

                                                                      setState(() {});
                                                                    },
                                                                    onCanceled: () {
                                                                      // Handle cancel if needed
                                                                    },
                                                                    hintText: "",
                                                                    // childHeight: 200,
                                                                    childWidth: constraints.maxWidth,
                                                                    child: Container(),
                                                                  );
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
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: SizedBox(
                                                          height: 30,
                                                          width: 200,
                                                          child: Focus(
                                                              skipTraversal: true,
                                                              descendantsAreFocusable: true,
                                                              child: LayoutBuilder(
                                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                                  return
                                                                    CustomPopupMenuButton(
                                                                      decoration: Utils.customPopupDecoration2(hintText:"Withholding Tax",),
                                                                      itemBuilder: (BuildContext context) {
                                                                        return enableTaxList;
                                                                      },
                                                                      hintText: "",
                                                                      childWidth: constraints.maxWidth,
                                                                      textController: TextEditingController(text: directExpense[index]['withHoldingTax']??""),
                                                                      shape:  const RoundedRectangleBorder(
                                                                        side: BorderSide(color: mSaveButtonBorder),
                                                                        borderRadius: BorderRadius.all(
                                                                          Radius.circular(5),
                                                                        ),
                                                                      ),
                                                                      offset: const Offset(1, 40),
                                                                      tooltip: '',
                                                                      onSelected: ( value) {
                                                                        setState(() {
                                                                          directExpense[index]['withHoldingTax'] = value;
                                                                          //For TDS Amount.
                                                                          for(int ewCost=0;ewCost<directExpense.length;ewCost++){
                                                                            ///TDS Amount.
                                                                            if ((taxPec.isNotEmpty && taxPec != "") &&
                                                                                (directExpense[ewCost]["amount"] != "" &&
                                                                                    directExpense[ewCost]["amount"].toString().isNotEmpty)) {

                                                                              double wHTPer = double.parse(taxPec.toString());
                                                                              double tempTotal = 0.0;
                                                                              if(tdsAmountController.text != "" || tdsAmountController.text.isNotEmpty){
                                                                                for (var expense in directExpense) {
                                                                                  final amount = expense['amount']?.toString();

                                                                                  if (amount != null && amount.isNotEmpty) {
                                                                                    if (expense['withHoldingTax'] == "Yes") {
                                                                                      tempTotal += double.parse(amount);
                                                                                    }
                                                                                  }
                                                                                }
                                                                               // Update the controller once, outside the loop
                                                                                tdsAmountController.text = ((tempTotal / 100) * wHTPer).toStringAsFixed(2);
                                                                              }
                                                                              else{
                                                                                tempTotal = double.parse(directExpense[ewCost]['amount'].toString());
                                                                                tdsAmountController.text = ((tempTotal / 100) * wHTPer).toStringAsFixed(2);
                                                                              }
                                                                            }
                                                                          }

                                                                        });
                                                                      },
                                                                      onCanceled: () {

                                                                      },
                                                                      child: Container(),
                                                                    );
                                                                },
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20),
                                                        child: SizedBox(
                                                          width: 100,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                               if(directExpense.length == index+1)
                                                                IconButton(
                                                                    onPressed: () {
                                                                      if(directExpense[index]["GLAccount"].isEmpty || directExpense[index]["GLAccount"]==""){
                                                                        if(mounted) {
                                                                          showDialog(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Please Enter G/L Account'),
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
                                                                      else{
                                                                        setState(() {
                                                                          directExpense.add(
                                                                              {
                                                                                "GLAccount":"",
                                                                                "shortText":"",
                                                                                "Dc":"",
                                                                                "amount":"",
                                                                                "taxCode":"",
                                                                                "assignment":"",
                                                                                "text":"",
                                                                                "costCenter":"",
                                                                                "withHoldingTax":'',
                                                                                "enableTax":false,
                                                                              }
                                                                          );
                                                                        });
                                                                      }
                                                                    },
                                                                    icon: const Icon(
                                                                      Icons.add_circle,
                                                                      color: Colors.blue,)
                                                                ),
                                                              //Delete Button.
                                                              IconButton(
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      if (directExpense.length > 1) {
                                                                        directExpense.removeAt(index);
                                                                      } else {
                                                                        Utils.snackBar("At least one row must remain.", context);
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

  ///ShowDialoge
  void filterGlCode(String gl) {
    setState(() {
      displayGLList = glAccountList.where((glAccount) {
        return glAccount["GLAccount"]?.contains(gl) ?? false;
      }).toList();
    });
  }
  void filterGlName(String gl) {
    setState(() {
      displayGLList = glAccountList.where((glAccount) {
        return glAccount["GLAccountName"]?.toString().toLowerCase().contains(gl.toString().toLowerCase()) ?? false;
      }).toList();
    });
  }
  void filterVendorCode(String gl) {
    setState(() {
      displayVendorList = vendorCodeList.where((glAccount) {
        return glAccount["Supplier"]?.toString().toLowerCase().contains(gl.toLowerCase()) ?? false;
      }).toList();
    });
  }
  void filterVendorName(String gl) {
    setState(() {
      displayVendorList = vendorCodeList.where((glAccount) {
        return glAccount["SupplierName"]?.toString().toLowerCase().contains(gl.toLowerCase()) ?? false;
      }).toList();
    });
  }
  void filterTaxCodes(String tName) {
    setState(() {
      displayTaxCodeList = taxCodesDELine.where((taxName) {
        return taxName["TAXCODE"]?.toString().toLowerCase().contains(tName.toLowerCase()) ?? false;
      }).toList();
    });
  }
  void filterTaxNames(String tName) {
    setState(() {
      displayTaxCodeList = taxCodesDELine.where((taxName) {
        return taxName["TAXCODENAME"]?.toString().toLowerCase().contains(tName.toString().toLowerCase()) ?? false;
      }).toList();
    });
  }

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
                            controller: searchGlCont,
                            decoration: const InputDecoration(
                              labelText: 'Search By GLCode',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                                if(value.isEmpty || value.trim().isEmpty){
                                  displayGLList = glAccountList;
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
                                  displayGLList = glAccountList;
                                }
                                else{
                                  filterGlName(value);
                                }
                                if(searchGlCont.text != ""){
                                  searchGlCont.text = "";
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
  ///Vendor show
  _showDialogVendor() {
    return AlertDialog(
      title: const Text("Select Vendor"),
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
                            controller: searchVendorCodeCont,
                            decoration: const InputDecoration(
                              labelText: 'Search By Vendor Code',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                                if(value.isEmpty || value.trim().isEmpty){
                                  displayVendorList = vendorCodeList;
                                }
                                else{
                                  filterVendorCode(value);
                                }
                                if(searchVendorNameCont.text != ""){
                                  searchVendorNameCont.text = "";
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
                            controller: searchVendorNameCont,
                            decoration: const InputDecoration(
                              labelText: 'Search By VendorName',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                                if(value.isEmpty || value.trim().isEmpty){
                                  displayVendorList = vendorCodeList;
                                }
                                else{
                                  filterVendorName(value);
                                }
                                if(searchVendorCodeCont.text != ""){
                                  searchVendorCodeCont.text = "";
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
                    child:displayVendorList.isEmpty
                        ? const Center(
                      child: Text(
                        "No Matching Records Found.",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ) :  ListView.builder(
                      shrinkWrap: true,
                      itemCount: displayVendorList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pop(context,displayVendorList[index]);
                          },
                          child: ListTile(
                            title:  Text(displayVendorList[index]['Supplier']??""),
                            subtitle: Text(displayVendorList[index]['SupplierName']??""),
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
  ///TaxCodes.
  _showDialogTaxCodes() {
    return AlertDialog(
      title: const Text("Select TaxCode"),
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
                              labelText: 'Search By TaxCode',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                                if(value.isEmpty || value.trim().isEmpty){
                                  displayTaxCodeList = taxCodesDELine;
                                }
                                else{
                                  filterTaxCodes(value);
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
                              labelText: 'Search By TaxName',
                            ),
                            onChanged: (value) {
                              // print('-------value-----');
                              // print(value);
                              setState(() {
                                if(value.isEmpty || value.trim().isEmpty){
                                  displayTaxCodeList = taxCodesDELine;
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
                    child:displayTaxCodeList.isEmpty
                        ? const Center(
                      child: Text(
                        "No Matching Records Found.",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ) :  ListView.builder(
                      shrinkWrap: true,
                      itemCount: displayTaxCodeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pop(context,displayTaxCodeList[index]);
                          },
                          child: ListTile(
                            title:  Text(displayTaxCodeList[index]['TAXCODE']??""),
                            subtitle: Text(displayTaxCodeList[index]['TAXCODENAME']??""),
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

  makeEmpty(){
    directExpense = [
      {
        "GLAccount":"",
        "shortText":"",
        "Dc":"",
        "amount":"",
        "taxCode":"",
        "assignment":"",
        "text":"",
        "costCenter":"",
        "withHoldingTax":'',
        "enableTax":false
      }
    ];
    vendorName = "";
    taxCodeNamesList = [];
    glNameList = [];
    businessController.text = "";
    searchGlNameCont.text = '';
    searchVendorCodeCont.text = "";
    searchVendorNameCont.text = "";
    searchGlCont.text = "";
  }
}

// class SearchGL {
//   final String label;
//   final String gLAccount;
//   final String gLAccountName;
//
//   dynamic value;
//
//   SearchGL({
//     required this.label,
//     required this.gLAccount,
//     required this.gLAccountName,
//     this.value});
//
//   factory SearchGL.fromJson( data) {
//     return SearchGL(
//         label: data['GLAccount'],
//         value:data,
//         gLAccount: data['GLAccount'],
//         gLAccountName: data['GLAccountName']
//     );
//   }
// }

class SearchGL {
  final String label;
  final String gLAccount;
  final String gLAccountName;
  final Map<String, dynamic> value;

  const SearchGL({
    required this.label,
    required this.gLAccount,
    required this.gLAccountName,
    required this.value,
  });

  factory SearchGL.fromJson(Map<String, dynamic> data) {
    final gLAccount = data['GLAccount'] as String? ?? '';
    final gLAccountName = data['GLAccountName'] as String? ?? '';

    return SearchGL(
      label: gLAccount,
      gLAccount: gLAccount,
      gLAccountName: gLAccountName,
      value: data,
    );
  }
}


class SearchVendor {
  final String label;
  final String supplier;
  final String supplierName;
  //dynamic value;

  SearchVendor({
    required this.label,
    required this.supplier,
    required this.supplierName,

  //  this.value
  });

  factory SearchVendor.fromJson( data) {
    return SearchVendor(
        label: data['Supplier'],
        supplier: data['Supplier'],
        supplierName: data['SupplierName'],

        //value:data
    );
  }
}

class SearchCostCenter {
  final String label;
  dynamic value;

  SearchCostCenter({required this.label, this.value});

  factory SearchCostCenter.fromJson( data) {
    return SearchCostCenter(label: data, value:data);
  }
}

class SearchWithHoldingTaxCode {
  // final String withHoldingTaxType;
  // final String withHoldingTaxCode;
  // final String officialWhdgTaxCode;
  final double rate;
  final String taxType;
  final String taxCode;
  final String woTaxName;
  final String label;

  SearchWithHoldingTaxCode({
    // required this.withHoldingTaxType,
    // required this.withHoldingTaxCode,
    // required this.officialWhdgTaxCode,
    required this.rate,
    required this.taxType,
    required this.taxCode,
    required this.woTaxName,
    required this.label,
  });

  /// Factory constructor to create an instance from JSON
  factory SearchWithHoldingTaxCode.fromJson(Map<String, dynamic> data) {
    return SearchWithHoldingTaxCode(
      label: data['Tax Code']?.toString()?? "",
      rate: data['Rate'],
      taxType: data['Tax Type']?. toString() ?? "",
      taxCode: data['Tax Code']?.toString() ?? "",
      woTaxName: data['WO Tax Name']?.toString() ?? "",

      // label: data['WITHHOLDINGTAXCODE']?.toString() ?? '',
      // withHoldingTaxType: data['WITHHOLDINGTAXTYPE']?.toString() ?? '',
      // withHoldingTaxCode: data['WITHHOLDINGTAXCODE']?.toString() ?? '',
      // officialWhdgTaxCode: data['OFFICIALWHLDGTAXCODE']?.toString() ?? '',
    );
  }
}

