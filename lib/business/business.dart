import 'package:memories/business/adding_memory.dart';
// import 'package:memories/business/dark.dart';
import 'package:memories/business/editing_memory.dart';
import 'package:memories/business/locking_mechanism.dart';
import 'package:memories/business/medias.dart';
import 'package:memories/business/memories.dart';
import 'package:memories/business/reset_password.dart';
import 'package:memories/business/user_profile.dart';
import 'package:memories/business/is_initialized.dart';
import 'package:memories/business/memory_detail.dart';
import 'package:memories/business/tags.dart';

class Business {
  var addingMemory = AddingMemoryState();
  var dark = false;
  var editingMemory = EditMemoryState();
  var isInitialized = false;
  var lockingMechanism = LockingMechanismState();
  var memories = MemoriesState();
  var memoryDetail = MemoryDetailState();
  var resetPassword = ResetPasswordState();
  var userProfile = UserProfileState();
  var tags = TagsState();
  var medias = Medias();
}

Business business(Business state, action) {
  return state
    ..addingMemory = addingMemory(state.addingMemory, action)
    // ..dark = dark(state.dark, action)
    ..editingMemory = editingMemory(state.editingMemory, action)
    ..isInitialized = isInitialized(state.isInitialized, action)
    ..lockingMechanism = lockingMechanism(state.lockingMechanism, action)
    ..memories = memories(state.memories, action)
    ..memoryDetail = memoryDetails(state.memoryDetail, action)
    ..resetPassword = resetPassword(state.resetPassword, action)
    ..userProfile = userProfile(state.userProfile, action)
    ..tags = tags(state.tags, action)
    ..medias = medias(state.medias, action);
}
