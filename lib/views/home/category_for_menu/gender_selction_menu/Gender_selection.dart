import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderSelection extends StatefulWidget {
  final Function(String) onGenderSelected; // Updated to pass gender as a string

  const GenderSelection({Key? key, required this.onGenderSelected})
      : super(key: key);

  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGender = "MEN"; // Male
                });
                widget.onGenderSelected("MEN");
              },
              child: _buildGenderCard(
                'assets/images/mens.jpg',
                'Men',
              ),
            ),
            SizedBox(width: 20.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGender = "WOMEN"; // Female
                });
                widget.onGenderSelected("WOMEN");
              },
              child: _buildGenderCard(
                'assets/images/womens.jpg',
                'Women',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderCard(String imagePath, String genderLabel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            imagePath,
            width: 150.w,
            height: 150.h,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          genderLabel,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
