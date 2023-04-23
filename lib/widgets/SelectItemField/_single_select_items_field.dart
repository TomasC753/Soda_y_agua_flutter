part of 'select_item_field.dart';

class _SingleSelectItemsController extends GetxController {
  //
  var isLoading = false.obs;
}

class _SingleSelectItemsField<T> extends GetView<_SingleSelectItemsController> {
  ResponseList items;
  TextEditingController textController;
  Function(dynamic) onChanged;
  _SingleSelectItemsField(
      {Key? key,
      required this.items,
      required this.textController,
      required this.onChanged})
      : super(key: key);

  @override
  final controller = Get.put(_SingleSelectItemsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        title: const Text('Selecciona un item'),
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : items.returnContentWhen(
              onLoading: const Center(
                child: CircularProgressIndicator(),
              ),
              onEmpty: const Center(
                child: Text('Esta lista esta vacia'),
              ),
              onError: Center(
                child: Text(items.errorMessage.value),
              ),
              onSuccess: Column(
                children: [],
              ))),
    );
  }
}
