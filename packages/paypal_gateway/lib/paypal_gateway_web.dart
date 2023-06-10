library paypal_gateway;

import 'package:flutter/widgets.dart';
import 'package:payment_base/payment_base.dart';
import 'widgets/paypal.dart';

class PayPalGatewayWeb implements PaymentBase {
  /// Payment method key
  ///
  static const key = "paypal";

  @override
  String get libraryName => "paypal_gateway";

  @override
  String get logoPath => "assets/images/paypal.png";

  @override
  Future<void> initialized({
    required BuildContext context,
    required RouteTransitionsBuilder slideTransition,
    required Future<dynamic> Function(List<dynamic>) checkout,
    required Function(dynamic data) callback,
    required String amount,
    required String currency,
    required Map<String, dynamic> billing,
    required Map<String, dynamic> settings,
    required Future<dynamic> Function({String? cartKey, required Map<String, dynamic> data}) progressServer,
    required String cartId,
    required Widget Function(String url, BuildContext context, {String Function(String url)? customHandle})
        webViewGateway,
  }) async {
    try {
      dynamic data = await checkout([]);
      await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) => PaypalGateway(
            data: data,
            webViewGateway: webViewGateway,
          ),
          transitionsBuilder: slideTransition,
        ),
      );
      callback(PaymentException(error: "Cancel payment"));
    } catch (e) {
      callback(e);
    }
  }

  @override
  String getErrorMessage(Map<String, dynamic>? error) {
    if (error == null) {
      return 'Something wrong in checkout!';
    }

    if (error['message'] != null) {
      return error['message'];
    }

    return 'Error!';
  }
}
