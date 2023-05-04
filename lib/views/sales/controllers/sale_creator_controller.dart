import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/Client.dart';
import 'package:soda_y_agua_flutter/models/Product.dart';
import 'package:soda_y_agua_flutter/models/Sale.dart';
import 'package:soda_y_agua_flutter/models/Service.dart';
import 'package:soda_y_agua_flutter/services/user_service.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class SaleCreateController extends GetxController {
  //
  UserService userSevice = Get.find<UserService>();

  ResponseList<Client> clients = ResponseList<Client>(
      data: <Client>[],
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await Client.crudFunctionalities.getAll());

  ResponseGeneric<Client> selectedClient = ResponseGeneric<Client>(
      data: Rxn<Client>(),
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await Client.crudFunctionalities.getById(id!));

  ResponseList<Product> products = ResponseList<Product>(
      data: <Product>[],
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await Product.crudFunctionalities.getAll());

  ResponseList<Service> services = ResponseList<Service>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await Service.crudFunctionalities.getAll(),
      data: <Service>[]);

  late Function onFinish;
  Sale? sale;

  RxMap<int, RxMap<String, dynamic>> productSelection =
      RxMap<int, RxMap<String, dynamic>>();

  var isLoading = false.obs;

  var clientController = TextEditingController();

  var total = (0.0).obs;
  var totalDiscount = (0.0).obs;
  var selectedDate = DateTime.now().obs;
  var dateController = TextEditingController();
  // var moneyDeliveredController = TextEditingController();
  var moneyDelivered = (0.0).obs;
  var moneyDeliveredController = TextEditingController();

  var clientError = ''.obs;
  var productSelectionError = ''.obs;

  var productsLimitWarning = <String>[].obs;

  double get debt {
    return total.value - moneyDelivered.value;
  }

  void checkConsumptions(Client client) {
    productsLimitWarning.clear();
    client.limitsAndConsumptions?['consumptions']?.forEach((key, value) {
      if (value < (client.limitsAndConsumptions?['limits']?[key] ?? 0)) {
        productsLimitWarning.add(
            "- ${client.lastName} ${client.name} todavia no realizó todos los consumos disponibles para (${products.data.firstWhereOrNull((product) => product.id == int.parse(key))?.name})");
      }
    });
  }

  void setMoneyDelivered(String value) {
    moneyDelivered.value = double.tryParse(value) ?? 0;
  }

  // void selectDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate.value,
  //     firstDate: DateTime(DateTime.now().year - 1),
  //     lastDate: DateTime(DateTime.now().year + 1),
  //   );
  //   if (pickedDate != null && pickedDate != selectedDate.value) {
  //     selectedDate.value = pickedDate;
  //     dateController.text = pickedDate.toString();
  //   }
  // }

  void changeStateProduct(Product product, bool value) {
    // TODO: changeStateProduct
    if (value) {
      int? productService = selectedClient.data.value?.productPrices
          ?.firstWhereOrNull(
              (loopProduct) => loopProduct.productId == product.id)
          ?.serviceId;
      double productPrice = selectedClient.data.value?.productPrices
              ?.firstWhereOrNull(
                  (loopProduct) => loopProduct.productId == product.id)
              ?.price ??
          product.price;
      productSelection.addAll({
        product.id: {
          'originalPrice': productPrice,
          'priceSold': TextEditingController(text: '$productPrice'),
          'quantity': TextEditingController(text: '0'),
          'discount': TextEditingController(text: '0'),
          'serviceId': productService,
          'total': 0,
          'realTotal': 0,
        }.obs
      }.obs);
    } else {
      productSelection.remove(product.id);
    }
    sumatoryTotal();
  }

  double _getRealTotal(Product product) {
    return (double.tryParse(productSelection[product.id]!['quantity'].text) ??
            0) *
        _realPrice(product);
  }

  double _realPrice(Product product) {
    return productSelection[product.id]!['originalPrice'];
  }

  void discountAction(String value, Product product) {
    // TODO: dicountAction
    double realTotal = _getRealTotal(product);
    double realPrice = _realPrice(product);

    double total =
        realTotal - ((realTotal * (double.tryParse(value) ?? 0)) / 100);

    double priceSold =
        realPrice - ((realPrice * (double.tryParse(value) ?? 0)) / 100);

    productSelection[product.id]!['realTotal'] = realTotal;
    productSelection[product.id]!['total'] = total;
    productSelection[product.id]!['priceSold'].text = '$priceSold';
    sumatoryTotal();
  }

  void priceSoldAction(String value, Product product) {
    double realTotal = _getRealTotal(product);
    double realPrice = _realPrice(product);

    double discount = 100 - ((double.tryParse(value) ?? 0) * 100) / realPrice;
    double total = realTotal - ((realTotal * discount) / 100);

    // discountAction('$discount', product);
    productSelection[product.id]!['realTotal'] = realTotal;
    productSelection[product.id]!['total'] = total;
    productSelection[product.id]!['discount'].text = '$discount';
    sumatoryTotal();
  }

  void quantityAction(String value, Product product) {
    double realTotal = _getRealTotal(product);
    double realPrice = _realPrice(product);

    double total = realTotal -
        (realTotal *
            (double.tryParse(productSelection[product.id]!['discount'].text) ??
                0) /
            100);

    productSelection[product.id]!['realTotal'] = realTotal;
    productSelection[product.id]!['total'] = total;
    sumatoryTotal();
  }

  void sumatoryTotal() {
    // TODO: sumatoryTotal
    double tempTotal = 0;
    double tempRealTotal = 0;
    double tempTotalDiscount = 0;
    productSelection.forEach((key, product) {
      tempRealTotal += product['realTotal'];
      tempTotal += product['total'];
    });
    tempTotalDiscount = 100 - ((tempTotal * 100) / tempRealTotal);

    total.value = tempTotal;
    totalDiscount.value = tempTotalDiscount;
  }

  void editMode(Sale sale) {
    // TODO: editMode
    selectedClient.data.value = sale.client;
    selectedDate.value = DateTime.parse(sale.date);
    dateController.text = sale.date;
    moneyDelivered.value = sale.moneyDelivered;
    moneyDeliveredController.text = '${sale.moneyDelivered}';
    clientController.text = '${sale.client!.lastName} ${sale.client!.name}';

    sale.products?.forEach((product) {
      double realTotal =
          (product.pivot!['original_price'] * product.pivot!['quantity'])
              .toDouble();
      productSelection.addAll({
        product.id: {
          "originalPrice": product.pivot!['original_price'].toDouble(),
          "quantity":
              TextEditingController(text: '${product.pivot!['quantity']}'),
          "priceSold": TextEditingController(
              text: '${product.pivot!['price_sold'].toDouble()}'),
          "discount": TextEditingController(
              text: '${product.pivot!['discount'].toDouble()}'),
          "serviceId": product.pivot!['service_id'],
          "total": realTotal - ((realTotal * product.pivot!['discount']) / 100),
          "realTotal": realTotal,
        }.obs
      }.obs);
    });

    sumatoryTotal();
  }

  bool validate() {
    int errors = 0;
    if (selectedClient.data.value == null) {
      errors++;
      clientError.value = 'Debe seleccionar un cliente';
    }
    if (productSelection.value.length < 1) {
      errors++;
      productSelectionError.value = 'Debe comprar por los menos un producto';
    }
    return errors < 1;
  }

  void store() async {
    if (!validate()) {
      return;
    }

    Sale.create(
        // date: selectedDate.value,
        date: DateTime.now(),
        clientId: selectedClient.data.value!.id,
        userId: userSevice.user!.id,
        total: total.value,
        totalDiscount: totalDiscount.value,
        moneyDelivered: moneyDelivered.value,
        products: productSelection);

    Get.back();
    onFinish();
  }

  void edit() async {
    if (!(validate() || sale != null)) {
      return;
    }
    sale?.edit(
        // date: selectedDate.value,
        date: DateTime.now(),
        clientId: selectedClient.data.value!.id,
        userId: userSevice.user!.id,
        total: total.value,
        totalDiscount: totalDiscount.value,
        moneyDelivered: moneyDelivered.value,
        products: productSelection);

    Get.back();
    onFinish();
  }

  @override
  onInit() {
    super.onInit();
    clients.getData();
    services.getData();
    products.getData();
  }
}
