// ignore_for_file: avoid_setters_without_getters

import '../core/rest_client.dart';
import 'api/api_helper.dart';

abstract class DataHelper {
  set setApiHelper(ApiHelper apiHelper);

  ApiHelper get apiHelper;
}

class DataHelperImpl implements DataHelper {
  DataHelperImpl._internal() {
    _apiHelper = ApiHelperImpl(
      RestClient(),
    );
  }

  static final DataHelperImpl _singleton = DataHelperImpl._internal();
  late ApiHelper _apiHelper;

  static DataHelperImpl get instance => _singleton;

  @override
  set setApiHelper(ApiHelper apiHelper) {
    _apiHelper = apiHelper;
  }

  @override
  ApiHelper get apiHelper => _apiHelper;
}
