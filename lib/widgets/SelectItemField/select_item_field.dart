import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

part '_multiple_select_items_field.dart';
part '_single_select_items_field.dart';
part '_input_select_field.dart';

class SelectItemsField {
  static Widget single<T>(
      {required Function<T>(T) onChanged,
      InputDecoration? inputDecoration,
      required TextEditingController controller,
      required ResponseList<T> items}) {
    return _InputSelectField(
      textController: controller,
      decoration: inputDecoration,
      widgetConstructor: _SingleSelectItemsField<T>(
        items: items,
        textController: controller,
        onChanged: onChanged,
      ),
    );
  }

  static Widget multiple<T>(
      {required Function<T>(T) onChanged,
      required TextEditingController controller,
      InputDecoration? inputDecoration,
      required ResponseList<T> items}) {
    return _InputSelectField(
      textController: controller,
      decoration: inputDecoration,
      widgetConstructor: _MultipleSelectItemsField<T>(),
    );
  }
}
