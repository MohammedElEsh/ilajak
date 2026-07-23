import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientNotificationsView extends StatelessWidget {
  const PatientNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Notifications', style: TextStyle(fontSize: 24.sp)),
        ),
      ),
    );
  }
}
