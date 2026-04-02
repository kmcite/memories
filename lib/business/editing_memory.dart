import 'package:image_picker/image_picker.dart';

EditMemoryState editingMemory(EditMemoryState state, action) {
  return state;
}

// void title(String title) => emit(state.copyWith(title: title));
// void description(String description) =>
//     emit(state.copyWith(description: description));
// void mood(String mood) => emit(state.copyWith(mood: mood));
// void tags(List<String> tags) => emit(state.copyWith(tags: tags));
// void save() {}
// void pick() async {
//   final image = await ImagePicker().pickImage(
//     source: ImageSource.gallery,
//   );
//   emit(state.copyWith(image: image));
// }

class EditMemoryState {
  String title = '';
  String description = '';
  String mood = '';
  List<String> tags = [];
  int id = 0;
  XFile? image;
}
