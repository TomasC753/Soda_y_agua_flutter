part of 'select_item_field.dart';

class SelectableList {
  String title;
  String? subtitle;
  Object value;
  bool state;

  SelectableList(
      {required this.title,
      this.subtitle,
      required this.value,
      this.state = false});
}
