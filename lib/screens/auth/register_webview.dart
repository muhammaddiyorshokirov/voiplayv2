import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:appv/utils/constants.dart';

class RegisterWebView extends StatefulWidget {
  const RegisterWebView({super.key});

  @override
  State<RegisterWebView> createState() => _RegisterWebViewState();
}

class _RegisterWebViewState extends State<RegisterWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            // Handle successful registration redirect
            if (request.url.contains('success')) {
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(AppConstants.signUpUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
