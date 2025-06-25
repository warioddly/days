


import 'dart:developer';

import 'package:in_app_purchase/in_app_purchase.dart';

abstract final class InAppPurchaseService {

  InAppPurchaseService._();

  static final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  final purchaseUpdatedStream = InAppPurchase.instance.purchaseStream;

  static Future<void> init() async {
    final available = await _inAppPurchase.isAvailable();
    if (!available) {
      return;
    }

    log("Store is not available $available");

    const _kIds = <String>{'7BUDU2N726'};
    final response = await _inAppPurchase.queryProductDetails(_kIds);

    if (response.notFoundIDs.isNotEmpty) {
      print('Product not found: ${response.notFoundIDs}');
      return;
    }

    final products = response.productDetails;

    log('products ${products}');
    // Сохрани products для отображения пользователю
  }

}