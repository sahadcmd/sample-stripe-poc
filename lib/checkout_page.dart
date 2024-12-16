import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutPage extends StatefulWidget {
  final String checkoutUrl;

  const CheckoutPage({super.key, required this.checkoutUrl});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print("Page started loading: $url");
          },
          onPageFinished: (String url) {
            print("Page finished loading: $url");
          },
          onNavigationRequest: (NavigationRequest request) {
            print("Navigation request to: ${request.url}");
            return NavigationDecision.navigate;
          },
        ),
      );
    _redirectToStripe(widget.checkoutUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }

  void _redirectToStripe(String fullCheckoutUrl) {
    print("Redirecting to: $fullCheckoutUrl");
    _controller.loadRequest(Uri.parse(fullCheckoutUrl));
  }

  // void _redirectToStripe() {
  //   const checkoutUrl =
  //       "https://checkout.stripe.com/c/pay/cs_test_a1GQOBwHleqwfmhu7vJqu002wwL17IpqPZuKVXSJCAb3tm11TIJ00B7RcY#fidkdWxOYHwnPyd1blpxYHZxWjA0VFNQUGBEQDc0dWNIb0hmTk82b2JAX09vNW1TQlxicWF3MldsczBgTzNmRDFAfGpoZlNCNUlWMlAzb3VzQTNIcn9HRDVBMW1BNFJOd10zPVZzfEBAVWNMNTVvS2tibFZARycpJ2N3amhWYHdzYHcnP3F3cGApJ2lkfGpwcVF8dWAnPyd2bGtiaWBabHFgaCcpJ2BrZGdpYFVpZGZgbWppYWB3dic%2FcXdwYHgl";
  //   print("Redirecting to: $checkoutUrl");
  //   _controller.loadRequest(Uri.parse(checkoutUrl));
  // }

//   String get initialUrl =>
//       'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(kStripeHtmlPage))}';

//   void _redirectToStripe() {
//     final redirectToCheckoutJs = '''
// var stripe = Stripe('$apiKey');
// stripe.redirectToCheckout({
//   sessionId: '${widget.sessionId}'
// }).then(function(result) {
//   if (result.error) {
//     console.error('Error during checkout: ' + result.error.message);
//   }
// }).catch(function(error) {
//   console.error('Stripe.js initialization failed: ' + error.message);
// });
// ''';
//     print('Session URL: https://checkout.stripe.com/pay/${widget.sessionId}');

//     _controller.runJavaScript(redirectToCheckoutJs);
//   }
}

const kStripeHtmlPage = '''
<!DOCTYPE html>
<html>
  <script src="https://js.stripe.com/v3/"></script>
  <head><title>Stripe Checkout</title></head>
  <body>Loading Stripe Checkout...</body>
</html>
''';
