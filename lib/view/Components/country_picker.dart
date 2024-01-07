import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryPicker extends StatelessWidget {
  final String countryName;
  final void Function(String)? onCountryChanged;

  const CountryPicker(
      {Key? key, required this.countryName, required this.onCountryChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 2.h, horizontal: 2.w),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(0, 4)),
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(2, 0)),
          ],
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      margin: EdgeInsets.symmetric(
          vertical: 8.h, horizontal: 8.w),
      child: CSCPicker(
        dropdownHeadingStyle: TextStyle(fontSize: 18.sp),
        dropdownItemStyle: TextStyle(fontSize: 16.sp),
        selectedItemStyle: TextStyle(fontSize: 16.sp),

        dropdownDecoration: const BoxDecoration(),
        onCountryChanged: onCountryChanged,
        countrySearchPlaceholder: "ابحث",
        defaultCountry: DefaultCountry.Syria,
        countryDropdownLabel: countryName,
        showCities: false,
        showStates: false,
      ),
    );
  }
}
