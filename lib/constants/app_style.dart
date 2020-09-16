import 'package:flutter/material.dart';

import 'app_colors.dart';


AppBar mainAppBar(String title) {
  return AppBar(
    centerTitle: true,
    title: Text(title,  style: TextStyle(color: AppColors.ACCENT_COLOR),),
    backgroundColor: AppColors.PRIMARY_COLOR,
    iconTheme: IconThemeData(color: AppColors.ACCENT_COLOR),
  );
}
InputDecoration textInputDecoration(String hint) {
  return InputDecoration(
    fillColor: AppColors.PRIMARY_COLOR_DARK,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding:
      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
  hintText: hint);
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: AppColors.PRIMARY_COLOR_DARK),
      focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: AppColors.PRIMARY_COLOR_DARK)),
      enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: AppColors.PRIMARY_COLOR_DARK)));
}

RoundedRectangleBorder buttonMainShape(){
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: BorderSide(color: AppColors.PRIMARY_COLOR_DARK)
  );
}

InputDecoration searchTextDecoration (){
  return InputDecoration(
      focusColor: AppColors.PRIMARY_COLOR_DARK,
      labelText: "Rechercher",
      hintText: "Rechercher",
      prefixIcon: Icon(Icons.search),
      focusedBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.all(Radius.circular(16.0)),

        borderSide: BorderSide(color: AppColors.PRIMARY_COLOR_DARK),
      ),
      border: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(16.0))));
}
