import 'package:memories/utils/architecture/repositories.dart';
import 'package:memories/main.dart';

extension StateExtensions on State<StatefulWidget> {
  R depend<R extends Repository>() {
    final instance = repositories[R] as R;
    instance.watch().listen(listener);
    return instance;
  }

  void listener([_]) {
    // ignore: invalid_use_of_protected_member
    if (mounted) setState(() {});
  }
}
