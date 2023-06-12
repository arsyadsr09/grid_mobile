import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String name;
  const WebViewPage({Key? key, required this.url, required this.name})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: WebviewScaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        url: widget.url,
        userAgent: 'random',
      ),
    );
  }
}
