import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  String task;

  Todo({this.task});

  String get title {
    return this.task;
  }
}
