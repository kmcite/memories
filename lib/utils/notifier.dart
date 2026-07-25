import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:manager/manager.dart';

// =============================================================================
// BASE NOTIFIER WITH AUTOMATIC RESOURCE CLEANUP
// =============================================================================

class Notifier with ChangeNotifier {
  final List<void Function()> _disposers = [];

  /// Explicitly notify dependent UI elements through the provider engine.
  void notify() => notifyListeners();

  /// Registers a tear-down action executed when this Notifier is disposed.
  void onDispose(void Function() cb) {
    _disposers.add(cb);
  }

  @override
  void dispose() {
    for (final disposer in List.from(_disposers)) {
      disposer();
    }
    _disposers.clear();
    super.dispose();
  }
}

// =============================================================================
// SIGNAL EXTENSIONS FOR NOTIFIER
// =============================================================================

extension NotifierSignalX on Notifier {
  /// Creates a reactive [ValueNotifier] bound to this [Notifier].
  ///
  /// Any change to the returned signal automatically calls [notify()]
  /// to trigger element rebuilds. When [Notifier] disposes, the signal is disposed.
  ValueNotifier<T> signal<T>(T initialValue) {
    final notifier = ValueNotifier<T>(initialValue);

    void listener() => notify();
    notifier.addListener(listener);

    onDispose(() {
      notifier.removeListener(listener);
      notifier.dispose();
    });

    return notifier;
  }
}

// =============================================================================
// VALUE NOTIFIER EXTENSIONS (Callable & Mutator)
// =============================================================================

extension ValueNotifierX<T> on ValueNotifier<T> {
  /// Callable syntax:
  /// - `count()` -> Reads value.
  /// - `count.set(10)` -> Sets value to 10 and returns 10.
  /// - `count((val) => val + 1)` -> Mutates value via callback and returns new value.
  T call([T Function(T)? update]) {
    if (update != null) {
      value = update(value);
    }
    return value;
  }

  /// Explicit setter helper.
  void set(T newValue) {
    value = newValue;
  }
}

class LoggingObserver extends ProviderObserver {
  @override
  void didCreateProvider(Provider provider, Object? value) {
    log('[Provider][Create][${provider.type}]');
  }

  @override
  void didDisposeProvider(Provider<dynamic> provider) {
    log('[Provider][Dispose][${provider.type}]');
  }

  @override
  void didUpdateProvider(
    Provider<dynamic> provider,
    Object? previousValue,
    Object? newValue,
  ) {
    log('[Provider][Update][${provider.type}]');
  }

  void log(String message) {
    developer.log(message, name: 'Manager');
  }
}
