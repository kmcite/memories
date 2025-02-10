import 'package:memories/main.dart';

class MemoriesUI extends UI {
  const MemoriesUI();
  @override
  Widget build(BuildContext context) {
    return Container();
    // ListView.builder(
    //   itemCount: memories().length,
    //   itemBuilder: (context, index) {
    //     final memory = memories()[index];
    //     return MemoryTile(memory: memory);
    //   },
    // );
  }
}
