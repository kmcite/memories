import 'package:flutter_native_splash/flutter_native_splash.dart';

bool isInitialized(bool state, action) {
  if (action is RemoveFlutterNativeSplash) {
    FlutterNativeSplash.remove();
    return true;
  }
  if (action is InitializeObjectBoxStore) {
    return true;
  }
  return state;
}

class InitializeEvent {}

class InitializeObjectBoxStore extends InitializeEvent {}

class RemoveFlutterNativeSplash extends InitializeEvent {}
