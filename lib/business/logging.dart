import 'dart:developer' show log;

import 'package:memories/business/business.dart';
import 'package:redux/redux.dart';

class LoggingMW extends MiddlewareClass<Business> {
  @override
  void call(_, action, next) {
    next(action);
    log(action.runtimeType.toString(), name: runtimeType.toString());
  }
}
