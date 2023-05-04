part of 'select_item_field.dart';

class _SelectItemsSingleController<T> extends GetxController {
  var isLoading = false.obs;
  late List<SelectableList> items;
  // RxList<RadioListTile> radioItems = <RadioListTile>[].obs;
  List<RadioListTile> radioItems = [];
  RxList<RadioListTile> printedRadioItems = <RadioListTile>[].obs;
  Rxn<SelectableList> selectedItem = Rxn<SelectableList>();
  late TextEditingController textController;

  void loadItems(Function onChanged) async {
    isLoading.value = true;
    var mapResult = items
        .map((item) => RadioListTile(
            title: Text(item.title),
            subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
            value: item.value,
            selected: item.value == selectedItem.value?.value,
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
  TextEditingController textController;
  SelectableList? selectedItem;
  List<SelectableList> items;
  Function(T?) onChanged;

  @override
  _SelectItemsSingleController controller =
      Get.put(_SelectItemsSingleController());

  _SelectItemsSingle(
      {Key? key,
      this.decoration,
      this.selectedItem,
      required this.onChanged,
      required this.items,
      required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.items = items;
    if (selectedItem != null) {
      controller.selectedItem.value = selectedItem;
    }
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
