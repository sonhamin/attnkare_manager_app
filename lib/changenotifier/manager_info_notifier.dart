import 'package:attnkare_manager_app/services/api_service.dart';
import 'package:flutter/material.dart';

import '../models/subscribe_model.dart';

// extension Log on Object {
//   void log() => devtools.log(toString());
// }

class ManagerInfoChangeNotifier extends ChangeNotifier {
  SubscribeModel? _subscribeModel;
  bool loading = false;

  SubscribeModel? get subscribeModel => _subscribeModel;

  void doManagerInfo() async {
    loading = true;
    _subscribeModel = await ApiService.getManagerInfo().then((info) async {
      return null;

      // _subscribeModel = await ApiService.getSubscribeInfo(info!.id);
      // return _subscribeModel;
    });

    // _subscribeModel!.log();

    loading = false;
    notifyListeners();
  }
}
// bluekare_doctor