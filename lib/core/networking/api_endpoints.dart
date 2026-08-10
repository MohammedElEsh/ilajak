class ApiEndpoints {
  static const String baseUrl =
      'https://fifty-partly-blighted.ngrok-free.dev/api';
  static const String login = '/login';
  static const String logout = '/logout';
  static const String refresh = '/auth/refresh-token';
  // NOTE: still the old placeholder value, not the real '/register' — left
  // untouched since patient registration is a separate, not-yet-scoped
  // task (AuthRegisterCubit is still a Future.delayed stub). Flagged in
  // chat, fix it together with wiring patient signup for real.
  static const String register = '/users';
  static const String doctorRegister = '/doctor/register';
  static const String registerPatient = '/register';
  static const String registerDoctor = '/doctor/register';
  static const String profile = '/auth/profile';
  static const String checkEmailAvailability = '/users/is-available';
  static const String categories = '/categories';
  static const String products = '/products';

  // ── Account (shared patient/doctor) ───────────────────────────────────
  static const String changePassword = '/user/change-password';

  // ── Doctor profile ─────────────────────────────────────────────────────
  static const String doctorProfile = '/doctor/profile';
  static const String doctorProfileAvatar = '/doctor/profile/avatar';

  // ── Doctor: Appointments / Schedule ───────────────────────────────────────
  // GET  -> doctor's own appointments (no server-side date filter as of the
  //         last Postman check — filter/group client-side).
  // POST -> book a new appointment (named "(Patient)" in the collection —
  //         unconfirmed whether a doctor can call this too, ask backend).
  static const String appointments = '/appointments';

  /// PATCH — body: `{"status": "confirmed" | "completed" | "cancelled"}`
  static String appointmentStatus(int appointmentId) => '/appointments/$appointmentId/status';

  // ── Doctor: Medical Records ────────────────────────────────────────────────
  // GET  -> add ?patient_id= to scope to one patient (confirmed in Postman).
  // POST -> raw JSON: patient_id, chronic_diseases, allergies,
  //         lab_results (object), radiology_results (object),
  //         attachments (array of strings) — confirmed against the current
  //         "3ilajak Backend API v1" collection. The old multipart /
  //         appointment_id / diagnosis / treatment_plan shape mentioned here
  //         previously is stale — not the live contract.
  static const String medicalRecords = '/medical-records';

  // ── Doctor: Prescriptions ──────────────────────────────────────────────────
  // GET  -> add ?patient_id= to scope to one patient (confirmed in Postman).
  // POST -> body: appointment_id, medication_name, dosage, instructions.
  // NOTE: separate "Prescription API Tests" Postman collection has a
  // similarly-named "Add New Prescription" — that one is patient-facing
  // self-service (different body shape). Use THIS endpoint for the
  // doctor-side "Add Prescription" flow, not that one.
  static const String prescriptions = '/prescriptions';
  static const String doctors = '/doctors';
  static const String bookAppointment = '/appointments';
  // Profile
  static const String profileOverView = '/profile';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String resetPassword = '/reset-password';
  static const String logout = '/logout';
}
