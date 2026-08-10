// import '../../../../core/errors/failures.dart';
// import '../../../../core/errors/safe_call.dart';
// import '../../../../core/networking/api_consumer.dart';
// import '../../../../core/networking/api_endpoints.dart';
// import '../models/prescription_model.dart';
// import 'prescription_repository.dart';
//
// class PrescriptionRepositoryImpl implements PrescriptionRepository {
//   final ApiConsumer _apiConsumer;
//
//   PrescriptionRepositoryImpl({required ApiConsumer apiConsumer})
//       : _apiConsumer = apiConsumer;
//
//   @override
//   EitherResult<List<PrescriptionModel>> getPrescriptions() {
//     return safeCall(() async {
//       final response = await _apiConsumer.get(ApiEndpoints.prescriptions);
//
//       if (response is! List) {
//         throw const ServerFailure('Unexpected response format');
//       }
//
//       return response
//           .map((e) => PrescriptionModel.fromJson(e as Map<String, dynamic>))
//           .toList();
//     });
//   }
//
//   @override
//   EitherResult<PrescriptionModel> getPrescriptionById(int id) {
//     return safeCall(() async {
//       final response =
//           await _apiConsumer.get('${ApiEndpoints.prescriptions}/$id');
//
//       if (response is! Map<String, dynamic>) {
//         throw const ServerFailure('Unexpected response format');
//       }
//
//       return PrescriptionModel.fromJson(response);
//     });
//   }
// }
