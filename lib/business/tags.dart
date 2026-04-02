import 'dart:async';

import 'package:memories/business/business.dart';
import 'package:memories/domain/api/crud_repository.dart';
import 'package:memories/domain/models/memory.dart';
import 'package:memories/features/features.dart';
import 'package:redux/redux.dart';

class TagsState {
  List<MemoryTag> tags = [];
}

TagsState tags(TagsState state, action) {
  return state;
}

class TagsMW extends MiddlewareClass<Business> {
  StreamSubscription? _sub;
  @override
  call(store, action, next) {
    next(action);
    if (action is SubscribeToTags) {
      _sub = memoryTagsRepository.watch().listen(
        (tags) => dispatch(TagsChanged(tags)),
      );
    } else if (action is UnsubscribeFromTags) {
      _sub?.cancel();
      _sub = null;
    }
  }
}

class TagsChanged {
  final List<MemoryTag> tags;
  const TagsChanged(this.tags);
}

class SubscribeToTags {}

class UnsubscribeFromTags {}
