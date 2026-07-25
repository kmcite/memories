import 'package:manager/manager.dart';
import 'package:memories/utils/notifier.dart';

final darkStateProvider = provider((ref) => DarkState());

class DarkState extends Notifier {
  late final dark = signal(false);
  void toggleDark() {
    dark((dark) => !dark);
  }
}
