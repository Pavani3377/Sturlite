import 'package:flutter/material.dart';

Future selectDate(BuildContext context, TextEditingController dateController)async{
  DateTime? newStartDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  if(newStartDate != null){
    String formattedDate = "${newStartDate.year}-${newStartDate.month.toString().padLeft(2, '0')}-${newStartDate.day.toString().padLeft(2, '0')}";
    dateController.text = formattedDate;
      return  "${newStartDate.year}${newStartDate.month.toString().padLeft(2, '0')}${newStartDate.day.toString().padLeft(2, '0')}";
  }
   return "";
}