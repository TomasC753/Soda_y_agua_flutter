part of 'select_item_field.dart';

class _SelectItemsMultipleController<T> extends GetxController {
  var isLoading = false.obs;
  late List<SelectableList> items;
  late TextEditingController textController;
  RxList<SelectableList> printedItems = <SelectableList>[].obs;
  RxList<SelectableList> checkedItems = <SelectableList>[].obs;

  void loadItems(Function onChanged) {
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

class _MultipleSelectItemsField<T>
    extends GetView<_SelectItemsMultipleController> {
  InputDecoration? decoration;
  T? defaultValue;
  TextEditingController textController;
  List<SelectableList> items;
  Function(dynamic) onChanged;
  _MultipleSelectItemsField(
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
