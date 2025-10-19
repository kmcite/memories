import 'package:memories/utils/architecture/crud.dart';
import 'package:memories/utils/architecture/repositories.dart';

abstract class CrudRepository<T> = Repository<T> with CRUD<T>;
