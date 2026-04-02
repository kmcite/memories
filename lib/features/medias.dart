import 'package:memories/business/medias.dart';
import 'package:memories/features/features.dart';
import 'package:memories/main.dart';

class MediasScreen extends UI {
  @override
  void init() {
    dispatch(SubscribedToMedias());
  }

  @override
  void dispose() {
    dispatch(UnsubscribedFromMedias());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medias'),
        actions: [
          Text(
            state.medias.queue.length.toString(),
            style: TextStyle(
              fontWeight: .bold,
              fontSize: 24,
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: state.medias.medias.isEmpty
          ? Center(child: Text('No medias here yet'))
          : ListView.builder(
              itemCount: state.medias.medias.length,
              itemBuilder: (context, index) {
                final media = state.medias.medias[index];
                return ListTile(
                  title: Text(media.note.toString()),
                  subtitle: Text(media.path),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Text(
          state.medias.failures.toString(),
          style: TextStyle(
            fontWeight: .bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
