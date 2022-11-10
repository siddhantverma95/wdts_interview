import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:interview_qr/model/pets.dart';

import 'data/data_helper.dart';

class ViewModel extends ChangeNotifier {
  final List<Entry> _pets = [];

  UnmodifiableListView<Entry> get items => UnmodifiableListView(_pets);

  Future<void> add(String api) async {
    final dataHelper = DataHelperImpl.instance;

    final response = await dataHelper.apiHelper.executeList(api);

    response.fold((l) {
      debugPrint('ERROR: $l');
    }, (r) {
      _pets.addAll(r.entries);
    });
    notifyListeners();
  }
}
