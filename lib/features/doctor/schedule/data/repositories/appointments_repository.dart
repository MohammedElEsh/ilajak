import 'package:ilajak/core/errors/safe_call.dart';
import 'package:ilajak/features/doctor/schedule/data/models/appointment_model.dart';

abstract class AppointmentsRepository {
  /// `GET /appointments` — the doctor's own appointments (no date filter
  /// exists on the backend as of the last Postman check; filter/group by
  /// date client-side for now).
  EitherResult<List<AppointmentModel>> getMyAppointments();

  /// `PATCH /appointments/{id}/status` — body is just `{"status": ...}`.
  /// Use for Confirm / Complete / Cancel (status values confirmed so far:
  /// "confirmed", "completed", "cancelled" — verify the exact allowed set
  /// with the backend, there's no docs/enum for it in the collection).
  EitherResult<AppointmentModel> updateAppointmentStatus({
    required int appointmentId,
    required String status,
  });
}
