import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CustomTextField.dart';

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

class SelectItemsField {
  static single<T>(
      {T? defaultValue,
      required TextEditingController textController,
      required Function(T?) onChanged,
      InputDecoration? decoration,
      required List<SelectableList> items}) {
    return InputSelectField<_SelectItemsSingle>(
      widgetConstructor: _SelectItemsSingle<T>(
        defaultValue: defaultValue,
        onChanged: onChanged,
        items: items,
        textController: textController,
      ),
      decoration: decoration,
      textController: textController,
    );
  }

  static multiple<T>(
      {T? defaultValue,
      required TextEditingController textController,
      required Function(dynamic) onChanged,
      InputDecoration? decoration,
      required List<SelectableList> items}) {
    // TODO: multi select
    return InputSelectField(
      widgetConstructor: _SelectItemsMultiple<T>(
        items: items,
        onChanged: onChanged,
        textController: textController,
      ),
      textController: textController,
      decoration: decoration,
    );
  }
}

class InputSelectField<S> extends StatelessWidget {
  S widgetConstructor;
  TextEditingController textController;
  InputDecoration? decoration;
  InputSelectField(
      {Key? key,
      required this.widgetConstructor,
      this.decoration,
      required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: textController,
      decoration: decoration,
      onTap: () => Get.to(() => widgetConstructor,
          fullscreenDialog: true,
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 250)),
    );
  }
}

class _SelectItemsSingleController<T> extends GetxController {
  var isLoading = false.obs;
  late List<SelectableList> items;
  // RxList<RadioListTile> radioItems = <RadioListTile>[].obs;
  List<RadioListTile> radioItems = [];
  RxList<RadioListTile> printedRadioItems = <RadioListTile>[].obs;
  late TextEditingController textController;

  void loadItems(Function onChanged) async {
    isLoading.value = true;
    var mapResult = items
        .map((item) => RadioListTile(
            title: Text(item.title),
            subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
            value: item.value,
            groupValue: 'items',
            onChanged: (value) => change(value, onChanged)))
        .toList();
    radioItems = mapResult;
    printedRadioItems.value = mapResult;
    isLoading.value = false;
  }

  void change(value, Function externalChangeFunction) {
    textController.text = items.firstWhere((item) => item.value == value).title;
    externalChangeFunction(value);
    Get.back();
  }

  void search(String query) {
    if (query.isEmpty) {
      printedRadioItems.value = radioItems;
    }
    query = query.toLowerCase();

    printedRadioItems.value = radioItems
        .where((item) => item.title.toString().toLowerCase().contains(query))
        .toList();
  }
}

class _SelectItemsSingle<T> extends GetView<_SelectItemsSingleController> {
  InputDecoration? decoration;
  T? defaultValue;
  TextEditingController textController;
  List<SelectableList> items;
  Function(T?) onChanged;

  @override
  _SelectItemsSingleController controller =
      Get.put(_SelectItemsSingleController());

  _SelectItemsSingle(
      {Key? key,
      this.decoration,
      this.defaultValue,
      required this.onChanged,
      required this.items,
      required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.items = items;
    controller.loadItems(onChanged);
    controller.textController = textController;
    return Obx(
      () => Scaffold(
        body: !controller.isLoading.value
            ? CustomScrollView(
                slivers: [
                  const SliverAppBar(
                    title: Text('Selecciona un item'),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CustomTextField(
                        hintText: 'Buscar item',
                        onChanged: (value) => controller.search(value),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(children: controller.printedRadioItems),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

// TODO: _SelectItemsMultiple
class _SelectItemsMultipleController<T> extends GetxController {
  var isLoading = false.obs;
  late List<SelectableList> items;
  late TextEditingController textController;
  RxList<SelectableList> printedItems = <SelectableList>[].obs;
  // List<CheckboxListTile> checkboxes = [];
  // RxList<CheckboxListTile> printedCheckboxes = <CheckboxListTile>[].obs;
  RxList<SelectableList> checkedItems = <SelectableList>[].obs;

  void loadItems(Function onChanged) {
    //   isLoading.value = true;
    //   var mapResult = items
    //       .map((item) => CheckboxListTile(
    //           title: Text(item.title),
    //           subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
    //           value: checkedItems.contains(item),
    //           onChanged: (value) => change(value ?? false, item, onChanged)))
    //       .toList();
    //   checkboxes = mapResult;
    //   printedCheckboxes.value = mapResult;
    //   isLoading.value = false;
    printedItems.value = items;
  }

  void change(
      bool state, SelectableList item, Function(List<dynamic>) onChanged) {
    //
    if (!checkedItems.contains(item)) {
      checkedItems.add(item);
    } else {
      checkedItems.remove(item);
    }

    textController.text = checkedItems.map((item) => item.title).toString();
    onChanged(checkedItems.map((item) => item.value).toList());
  }

  void search(String query) {
    if (query.isEmpty) {
      printedItems.value = items;
    }
    query = query.toLowerCase();

    printedItems.value = items
        .where((item) => item.title.toString().toLowerCase().contains(query))
        .toList();
  }
}

class _SelectItemsMultiple<T> extends GetView<_SelectItemsMultipleController> {
  InputDecoration? decoration;
  T? defaultValue;
  TextEditingController textController;
  List<SelectableList> items;
  Function(dynamic) onChanged;
  _SelectItemsMultiple(
      {Key? key,
      this.decoration,
      this.defaultValue,
      required this.items,
      required this.onChanged,
      required this.textController})
      : super(key: key);

  @override
  var controller = Get.put(_SelectItemsMultipleController());

  @override
  Widget build(BuildContext context) {
    controller.items = items;
    controller.loadItems(onChanged);
    controller.textController = textController;
    return Obx(
      () => Scaffold(
        body: !controller.isLoading.value
            ? CustomScrollView(slivers: [
                const SliverAppBar(
                  title: Text(
                    'Seleccionar items',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CustomTextField(
                      hintText: 'Buscar item',
                      onChanged: (value) => controller.search(value),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                      children: controller.printedItems
                          .map((item) => CheckboxListTile(
                              title: Text(item.title),
                              subtitle: Text(item.subtitle ?? ''),
                              value: controller.checkedItems.contains(item),
                              onChanged: (state) => controller.change(
                                  state!,
                                  item,
                                  (checkedItems) => onChanged(checkedItems))))
                          .toList()),
                ),
              ])
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
