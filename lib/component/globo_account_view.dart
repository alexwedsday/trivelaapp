import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GloboAccountView extends StatefulWidget {
  @override
  _GloboAccountViewState createState() => _GloboAccountViewState();
}

class _GloboAccountViewState extends State<GloboAccountView> {
  Completer<WebViewController> _completer = Completer<WebViewController>();
  WebViewController _controller;

  CookieManager _cookieManager;
  @override
  void initState() {
    super.initState();
    _cookieManager = CookieManager();
    _clearCache();
  }

  @override
  Widget build(BuildContext context) {
    _completer.future.then((controller) {
      _controller = controller;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Globo.com'),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://login.globo.com/login/438',
        onWebViewCreated: (WebViewController controller) {
          _completer.complete(controller);
        },
        javascriptChannels: <JavascriptChannel>{_toasterMessage(context)},
        onPageFinished: (String url) {
          print('Terminated Load: ${url}');
          getResponse();
        },
        gestureNavigationEnabled: true,
      ),
    );
  }

  void getResponse() async {
    final String cookies =
        await _controller.evaluateJavascript("document.cookie");

    final String body = await _controller.evaluateJavascript("document.body");

    print('document body: ${body}');
    _setCookie(cookies);
  }

  void _clearCache() async {
    final bool boolCookies = await _cookieManager.clearCookies();
  }

  void _setCookie(String cookies) {
    print('setCookie: $cookies');
    List<String> cookieList = cookies?.split(';');
    final String xGblToken =
        cookieList.firstWhere((element) => element.contains('GLBID'));
    _saveXGblToken(xGblToken?.split('=')[1]);
  }

  void _saveXGblToken(String value) async {
    print('saveXGblToken: $value');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('X-GLB-Token');
    await preferences.reload();
    if (value?.isNotEmpty) {
      preferences.setString('X-GLB-Token', value);
    }
  }

  JavascriptChannel _toasterMessage(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
