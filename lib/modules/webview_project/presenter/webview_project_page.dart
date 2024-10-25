import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewProjectPage extends StatefulWidget {
  final String userName;
  final String projectName;
  const WebViewProjectPage(
      {super.key, required this.userName, required this.projectName});

  @override
  State<WebViewProjectPage> createState() => _WebViewProjectPageState();
}

class _WebViewProjectPageState extends State<WebViewProjectPage> {
  late WebViewController _controller;

  bool loading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://github.com/${widget.userName}/${widget.projectName}'))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            setState(() {
              loading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loading = false;
            });
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectName),
        automaticallyImplyLeading: false,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  if (await _controller.canGoBack()) {
                    _controller.goBack();
                  } else {
                    // ignore: use_build_context_synchronously
                    context.pop();
                  }
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              IconButton(
                onPressed: () async {
                  final mensseger = ScaffoldMessenger.of(context);
                  if (await _controller.canGoForward()) {
                    _controller.goForward();
                  } else {
                    mensseger.showSnackBar(
                      const SnackBar(
                        content: Text('Não existe histórico de avanço na web'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
              if (loading)
                const CircularProgressIndicator()
              else
                IconButton(
                    onPressed: () {
                      _controller.reload();
                    },
                    icon: const Icon(Icons.replay))
            ],
          )
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
