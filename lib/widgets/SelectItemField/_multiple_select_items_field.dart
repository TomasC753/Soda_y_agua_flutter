part of 'select_item_field.dart';

class _MultipleSelectItemsController extends GetxController {
  //
}

class _MultipleSelectItemsField<T>
    extends GetView<_MultipleSelectItemsController> {
  _MultipleSelectItemsField({Key? key}) : super(key: key);

  @override
  final controller = Get.put(_MultipleSelectItemsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        title: const Text('Seleccionar items'),
      ),
    );
  }
}
