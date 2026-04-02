import 'package:flutter_redux/flutter_redux.dart';
import 'package:memories/business/business.dart';
import 'package:memories/main.dart';
import 'package:signals/signals_flutter.dart';

void dispatch(action) => store.dispatch(action);
void dispatchAll(Iterable actions) {
  for (var action in actions) {
    dispatch(action);
  }
}

abstract class UI extends StatefulWidget {
  const UI({super.key});
  void init() {}
  void dispose() {}
  void firstBuild() {}
  void preChange() {}
  void postChange() {}
  @override
  State<UI> createState() => _UIState();
  Widget build(BuildContext context);

  Business get state => store.state;
}

class _UIState extends State<UI> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<Business>(
      builder: (context, _) => Watch((_) => widget.build(context)),
      onInit: (_) => widget.init(),
      onDispose: (_) => widget.dispose(),
      onInitialBuild: (viewModel) => widget.firstBuild(),
      onWillChange: (_, _) => widget.preChange(),
      onDidChange: (_, _) => widget.postChange(),
    );
  }
}
