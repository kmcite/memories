import 'package:signals/signals_flutter.dart';

// bool dark(bool state, action) {
//   if (action is DarkToggled) {
//     return !state;
//   }
//   return state;
// }

// class DarkEvent {}

// class DarkToggled extends DarkEvent {}

final darkSignal = signal(false);
void toggleDark() {
  darkSignal.set(!darkSignal.value);
}
