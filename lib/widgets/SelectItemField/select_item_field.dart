import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/widgets/CustomTextField.dart';

part '_multiple_select_items_field.dart';
part '_single_select_items_field.dart';
part '_input_select_field.dart';
part '_selectable_list.dart';

class SelectItemsField {
  static single<T>(
      {T? defaultValue,
      SelectableList? selectedItem,
      required TextEditingController textController,
      required Function(T?) onChanged,
      InputDecoration? decoration,
      required List<SelectableList> items}) {
    return _InputSelectField(
      widgetConstructor: _SelectItemsSingle<T>(
        selectedItem: selectedItem,
        onChanged: onChanged,
        items: items,
        textController: textController,
      ),
      decoration: decoration,
      textController: textController,
    );
  }

  static multiple<T>(
      {required TextEditingController textController,
      required Function(List<T>) onChanged,
      InputDecoration? decoration,
      List<SelectableList>? checkedItems,
      required List<SelectableList> items}) {
    return _InputSelectField(
      widgetConstructor: _MultipleSelectItemsField<T>(
        items: items,
        onChanged: onChanged,
        textController: textController,
        checkedItems: checkedItems,
      ),
      textController: textController,
      decoration: decoration,
    );
  }
}
