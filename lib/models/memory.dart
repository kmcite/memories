import 'package:objectbox/objectbox.dart';

@Entity()
class Memory {
  @Id()
  int id = 0;
  String name = "";
  String description = "";
  String path = "";
  bool isHidden = false;
}
