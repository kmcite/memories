import 'package:memories/domain/models/memory.dart';
import 'package:memories/features/features.dart';
import 'package:memories/business/tags.dart';
import 'package:memories/main.dart';

class TagsScreen extends UI {
  @override
  void init() {
    dispatch(SubscribeToTags());
  }

  @override
  void dispose() {
    dispatch(UnsubscribeFromTags());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tags'),
      ),
      body: TagsList(),
    );
  }
}

class TagsList extends UI {
  @override
  Widget build(BuildContext context) {
    final listOfTags = state.tags.tags;
    return listOfTags.isEmpty
        ? Center(child: Text('Okay. no tags yet'))
        : ListView.builder(
            itemCount: listOfTags.length,
            itemBuilder: (context, index) => TagTile(listOfTags[index]),
          );
  }
}

class TagTile extends UI {
  final MemoryTag tag;
  const TagTile(this.tag);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tag.value),
    );
  }
}
