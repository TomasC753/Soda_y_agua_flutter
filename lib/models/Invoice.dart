import 'ideable.dart';
import 'package:hive/hive.dart';

part 'Invoice.g.dart';

@HiveType(typeId: 4)
class Invoice implements Iideable {
  @override
  @HiveField(0)
  late int id;

  Invoice({required this.id});

  // TODO: crear el modelo invoice
}
