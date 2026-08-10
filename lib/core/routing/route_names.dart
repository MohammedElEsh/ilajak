class RouteNames {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String doctorSignup = '/doctor-signup';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String roleSelection = '/role-selection';
  static const String gettingStarted = '/getting-started';

  // Patient shell tabs
  static const String patientHome = '/patient-home';
  static const String patientAppointments = '/patient-appointments';
  static const String patientHealth = '/patient-health';
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
  static const String patientLabResults = '/patient-lab-results';

  // Prescriptions routes
  static const String patientPrescriptions = '/patient-prescriptions';

  // Doctor sub-routes — nested under doctorHome
  static const String doctorSchedule = 'schedule';
  static const String doctorScheduleFullPath =
      '$doctorHome/$doctorSchedule';

  // Nested under doctorPatients
  static const String doctorPatientProfile = 'profile';
  static const String doctorPatientProfileFullPath =
      '$doctorPatients/$doctorPatientProfile';

  // Nested under doctorPatientProfile
  static const String doctorPatientRecords = 'records';
  static const String doctorPatientRecordsFullPath =
      '$doctorPatientProfileFullPath/$doctorPatientRecords';

  // Nested under doctorPatientProfile — Add Prescription (Doctor)
  static const String doctorAddPrescription = 'add-prescription';
  static const String doctorAddPrescriptionFullPath =
      '$doctorPatientProfileFullPath/$doctorAddPrescription';

  // Nested under doctorPatientRecords — Create Medical Record
  static const String doctorCreateMedicalRecord = 'create';
  static const String doctorCreateMedicalRecordFullPath =
      '$doctorPatientRecordsFullPath/$doctorCreateMedicalRecord';

  // Nested under doctorProfile
  static const String doctorChangePassword = 'change-password';
  static const String doctorChangePasswordFullPath =
      '$doctorProfile/$doctorChangePassword';
}
