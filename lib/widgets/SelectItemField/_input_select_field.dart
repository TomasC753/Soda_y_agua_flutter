part of 'select_item_field.dart';

class _InputSelectField extends StatelessWidget {
  Widget widgetConstructor;
  TextEditingController textController;
  InputDecoration? decoration;
  _InputSelectField(
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
