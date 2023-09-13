// import 'dart:developer';

// import 'package:favicon/favicon.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:women/colors.dart';

class ExternalView extends StatefulWidget {
  final List<String> item;
  const ExternalView({super.key, required this.item});

  @override
  State<ExternalView> createState() => _ExternalViewState();
}

class _ExternalViewState extends State<ExternalView> {
  late final WebViewController _controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(widget.item[2]))
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (_) => setState(() => loading = false),
        onNavigationRequest: (_) => NavigationDecision.prevent,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            widget.item[0],
            softWrap: false,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          isThreeLine: false,
          visualDensity: VisualDensity.comfortable,
          subtitle: Text(
            widget.item[1],
            softWrap: false,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Expanded(
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
            if (loading) const Center(
              child: CircularProgressIndicator(),
            )
          ],
        )
      ),
    );
  }
}