import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Doc   extends StatefulWidget {
  @override
  _State createState() => _State();
}


class _State extends State<Doc> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  String loadUrl = 'https://firebasestorage.googleapis.com/v0/b/bring2book.appspot.com/o/1604474895572-bezkoder-file-sample_1MB.doc?alt=media&token=388e164a-917b-4c34-bf13-685535aa79d2';
  @override
  void initState() {
    _launchURL(loadUrl);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: WebView(
          initialUrl: loadUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
  _launchURL(String urlStr) async {
    if (await canLaunch(urlStr)) {
      Uri.encodeComponent(urlStr);
    } else {
      throw 'Could not launch $urlStr';
    }
  }
}
