class RouteNames {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String gettingStarted = '/getting-started';

  // Patient shell tabs
  static const String patientHome = '/patient-home';
  static const String patientAppointments = '/patient-appointments';
  static const String patientArticles = '/patient-articles';
  static const String patientNotifications = '/patient-notifications';
  static const String patientProfile = '/patient-profile';

  // Doctor shell tabs
  static const String doctorHome = '/doctor-home';
  static const String doctorPatients = '/doctor-patients';
  static const String doctorArticles = '/doctor-articles';
  static const String doctorNotifications = '/doctor-notifications';
  static const String doctorProfile = '/doctor-profile';

  // Patient sub-routes
  static const String patientPersonalInfo = '/patient-personal-info';
  static const String patientHealthInfo = '/patient-health-info';
  static const String patientEmergencyContacts = '/patient-emergency-contacts';
  static const String patientChangePassword = '/patient-change-password';

  // Doctor sub-routes — nested under doctorHome (unlike the patient
  // sub-routes above) so the bottom nav bar stays visible with "Home"
  // selected while these are pushed on top, matching the Figma flow.
  static const String doctorSchedule = 'schedule'; // relative segment
  static const String doctorScheduleFullPath = '$doctorHome/$doctorSchedule';

  // Nested under doctorPatients for the same reason — keeps the bottom
  // nav bar visible with "Patients" selected while the profile is pushed
  // on top. Patient data travels via `state.extra` (see verifyOtp for the
  // existing precedent of this pattern) rather than a path segment, since
  // there's no patient-id source yet.
  static const String doctorPatientProfile = 'profile'; // relative segment
  static const String doctorPatientProfileFullPath =
      '$doctorPatients/$doctorPatientProfile';

  // Nested one level deeper still — reached from the "View Medical
  // History" link on the profile — so the bottom nav bar + "Patients"
  // selection stay put all the way down.
  static const String doctorPatientRecords = 'records'; // relative segment
  static const String doctorPatientRecordsFullPath =
      '$doctorPatientProfileFullPath/$doctorPatientRecords';

  // Nested under doctorProfile — reached from the "Password" row on the
  // doctor's own profile — so the bottom nav bar stays visible with
  // "Profile" selected. Note this deliberately does NOT mirror
  // patientChangePassword above (a top-level sibling route that hides the
  // bottom nav): the doctor mock shows the nav bar staying put, so this
  // one is nested instead.
  static const String doctorChangePassword = 'change-password'; // relative segment
  static const String doctorChangePasswordFullPath =
      '$doctorProfile/$doctorChangePassword';
}
