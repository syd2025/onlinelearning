import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:onlinelearning/common/index.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String page;
  final String backgroundColor;
  final String foregroundColor;

  const WebViewPage({
    super.key,
    required this.title,
    required this.page,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool _isLoading = true;

  WebUri get _url {
    final bkColor = widget.backgroundColor;
    final fgColor = widget.foregroundColor;
    final url =
        '${Constants.wpApiBaseUrl}/v1/html/page?key=${widget.page}&bg=$bkColor&fg=$fgColor';
    return WebUri(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: _url),
            onReceivedServerTrustAuthRequest: (controller, challenge) async {
              return ServerTrustAuthResponse(
                  action: ServerTrustAuthResponseAction.PROCEED);
            },
            onLoadStop: (controller, url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            Container(
              color: Theme.of(context).colorScheme.surface,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
