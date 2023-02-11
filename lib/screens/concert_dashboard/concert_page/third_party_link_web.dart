import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ThirdPartyWebView extends StatefulWidget {
  const ThirdPartyWebView({Key? key}) : super(key: key);

  @override
  State<ThirdPartyWebView> createState() => _ThirdPartyWebViewState();
}

class _ThirdPartyWebViewState extends State<ThirdPartyWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.google.com/'));
    // #enddocregion webview_controller
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: controller))
    );
  }
}
