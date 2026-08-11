import 'package:ilajak/core/errors/failures.dart';
import 'package:ilajak/core/errors/safe_call.dart';
import 'package:ilajak/core/networking/api_consumer.dart';
import 'package:ilajak/core/networking/api_endpoints.dart';
import 'package:ilajak/features/doctor/schedule/data/models/appointment/appointment_model.dart';

import 'package:ilajak/features/doctor/schedule/domain/repositories/appointments_repository.dart';

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  final ApiConsumer _apiConsumer;

  AppointmentsRepositoryImpl({required ApiConsumer apiConsumer}) : _apiConsumer = apiConsumer;

  @override
  EitherResult<List<AppointmentModel>> getMyAppointments() {
    return safeCall(() async {
      final response = await _apiConsumer.get(ApiEndpoints.appointments);

      // Defensive: accept either a bare array or a `{ "data": [...] }`
      // envelope — the collection doesn't have a saved example, so we
      // don't know which shape the backend actually returns.
      final list = response is List
          ? response
          : response is Map<String, dynamic>
              ? response['data'] as List?
              : null;

      if (list == null) {
        throw const ServerFailure('Unexpected response format');
      }

      return list
          .map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  EitherResult<AppointmentModel> updateAppointmentStatus({
    required int appointmentId,
    required String status,
  }) {
    return safeCall(() async {
      final response = await _apiConsumer.patch(
        ApiEndpoints.appointmentStatus(appointmentId),
        data: {'status': status},
      );

      if (response is! Map<String, dynamic>) {
        throw const ServerFailure('Unexpected response format');
      }

      // Some APIs wrap the updated resource in a `{ "data": {...} }`
      // envelope — handle both.
      final map = response['data'] is Map<String, dynamic>
          ? response['data'] as Map<String, dynamic>
          : response;

      return AppointmentModel.fromJson(map);
    });
  }
}
