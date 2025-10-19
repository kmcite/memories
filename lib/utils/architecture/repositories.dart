import 'dart:async';
import 'package:memories/utils/architecture/services.dart';

final repositories = <Type, Repository>{};

abstract class Repository<T> {
  final controller = StreamController<void>.broadcast();
  Stream<void> watch() => controller.stream;

  void notifyListeners([any]) {
    controller.add(null);
  }

  S serve<S>() => services[S] as S;
}

void repository<S extends Repository>(S instance) {
  repositories[S] = instance;
}
