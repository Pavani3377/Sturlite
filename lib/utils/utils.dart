
import 'package:flutter/material.dart';

import 'm_colors.dart';

class Utils{


  static snackBar(String message, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  static void fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus,
      ){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static customerFieldDecoration( {required TextEditingController controller, required String hintText, bool? error}) {
    return  InputDecoration(
      constraints: BoxConstraints(maxHeight: error==true ? 50:30),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 11,),
      border: const OutlineInputBorder(
          borderSide: BorderSide(color:  Colors.blue)),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 10),
      enabledBorder:const OutlineInputBorder(borderSide: BorderSide(color: mTextFieldBorder)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    );
  }

  static searchGl( {required TextEditingController controller, required String hintText, bool? error}) {
    return  InputDecoration(
      constraints: BoxConstraints(maxHeight: error==true ? 50:30),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14,color: Colors.black),
      border: const OutlineInputBorder(
          borderSide: BorderSide(color:  Colors.blue)),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
      enabledBorder:const OutlineInputBorder(borderSide: BorderSide(color: mTextFieldBorder)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    );
  }

  static dateDecoration({required String hintText}) {
    return InputDecoration(
      constraints: const BoxConstraints(maxHeight: 30),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 1.0), // Adjusted thickness
      ),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 11),
      counterText: '',
      // contentPadding: const EdgeInsets.fromLTRB(12, 8, 10, 10),
      contentPadding: const EdgeInsets.fromLTRB(12, 0,0,0),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: mTextFieldBorder, width: 1.0), // Adjusted thickness
      ),
      errorBorder:  const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffC62828), width: 1.0), // Adjusted thickness
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color:  Color(0xffC62828), width: 1.0), // Adjusted thickness
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 1.0), // Adjusted thickness
      ),
    );
  }

  static textFieldDecoration({required String hintText}) {
    return  InputDecoration(
      border: const OutlineInputBorder(
          borderSide: BorderSide(color:  Colors.blue)),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 11),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(12, 8, 10, 10),
      enabledBorder:const OutlineInputBorder(borderSide: BorderSide(color: mTextFieldBorder)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    );
  }

  static customPopupDecoration({required String hintText}) {
    return InputDecoration(
      hoverColor: mHoverColor,
      disabledBorder:  const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4)),borderSide: BorderSide(color: mTextFieldBorder)),
      suffixIcon: const Icon(Icons.arrow_drop_down_circle_sharp, color: mSaveButton, size: 14),
      border:  const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4)),borderSide: BorderSide(color: Colors.transparent)),
      constraints: const BoxConstraints(maxHeight: 30),
      hintText: hintText,

      hintStyle:  TextStyle(fontSize:hintText!='Select'?14: 12, color:hintText!='Select'? Colors.black:Colors.black54),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 0),

    );
  }

  static  customPopupDecoration2({required String hintText, bool? error, bool ? isFocused,}) {
    return InputDecoration(
      hoverColor: mHoverColor,
      suffixIcon:  const Icon(Icons.arrow_drop_down_circle_sharp, color: mSaveButton, size: 14),
      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      constraints:  BoxConstraints(maxHeight:error==true? 60: 35),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 11, color: Color(0xB2000000)),
      counterText: '',
      contentPadding: const EdgeInsets.fromLTRB(12, 00, 0, 0),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: isFocused == true ? Colors.blue : error == true ? mErrorColor : mTextFieldBorder)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: error == true ? mErrorColor : mTextFieldBorder)),
      focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: error == true ? mErrorColor : Colors.blue)),
    );
  }
}