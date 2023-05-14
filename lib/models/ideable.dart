import 'package:hive/hive.dart';

part 'ideable.g.dart';

@HiveType(typeId: 0)
class Iideable {
  @HiveField(0)
  late int id;
  // Iideable(this.id);
}
