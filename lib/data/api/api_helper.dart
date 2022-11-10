import 'package:dartz/dartz.dart';
import 'package:interview_qr/model/pets.dart';

import '../../core/custom_exception.dart';
import '../../core/rest_client.dart';

enum ApiEnvironment {
  production,
}

abstract class ApiHelper {
  Future<Either<CustomException, Pets>> executeList(String api);
}

class ApiHelperImpl extends ApiHelper {
  final RestClient _api;

  ApiHelperImpl(this._api);

  @override
  Future<Either<CustomException, Pets>> executeList(String api) async {
    try {
      final response = await _api.get(api);
      return Right(Pets.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }
}
