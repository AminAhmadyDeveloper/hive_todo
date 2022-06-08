import 'package:hive_flutter/hive_flutter.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  normal,
  @HiveField(2)
  hight
}

@HiveType(typeId: 1)
class TODO extends HiveObject {
  @HiveField(0)
  String name = '';
  @HiveField(1)
  bool isDone = false;
  @HiveField(2)
  Priority priority = Priority.normal;
}
