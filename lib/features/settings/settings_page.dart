import 'package:memories/business/dark.dart';
import 'package:memories/main.dart';
import 'package:memories/features/features.dart';

class SettingsPage extends UI {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Settings'),
          ),
          SliverList.list(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton(
                  onPressed: () => toggleDark(),
                  child: Text('Toggle Mode'),
                ),
              ),
              // UserProfile(),
            ],
          ),
        ],
      ),
    );
  }
}
