import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReproduccionScreen extends StatefulWidget {
  final String megaUrl; //URL DEL TRAILER EN MEGA
  const ReproduccionScreen({Key? key, required this.megaUrl}) : super(key: key);

  @override
  _ReproduccionScreenState createState() => _ReproduccionScreenState();
}

class _ReproduccionScreenState extends State<ReproduccionScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.megaUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reproducción del trailer'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
