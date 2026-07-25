import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientArticlesView extends StatelessWidget {
  const PatientArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Articles', style: TextStyle(fontSize: 24.sp)),
        ),
      ),
    );
  }
}
