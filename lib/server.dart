import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sample_demo/constants.dart';

class Server {
  Future<String> createCheckout() async {
    const auth = 'Bearer $secretKey';

    // Manually encode data to URL-encoded format
    final body = {
      'payment_method_types[]': 'card',
      'line_items[0][price]': nikesPriceId,
      'line_items[0][quantity]': '1',
      'mode': 'payment',
      'success_url': 'https://example.com/success',
      'cancel_url': 'https://example.com/cancel',
    };

    print("Request Body: $body");
    print("Authorization Header: $auth");

    try {
      final result = await Dio().post(
        "https://api.stripe.com/v1/checkout/sessions",
        data: body.entries
            .map((e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
            .join('&'),
        options: Options(
          headers: {HttpHeaders.authorizationHeader: auth},
          contentType: "application/x-www-form-urlencoded",
        ),
      );
      return result.data['url'];
    } on DioError catch (e) {
      print(e.response?.data);
      throw e;
    }
  }
}
