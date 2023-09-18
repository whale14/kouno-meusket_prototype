
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';

class PostWebView extends StatefulWidget {
  const PostWebView({Key? key}) : super(key: key);

  @override
  State<PostWebView> createState() => _PostWebViewState();
}

class _PostWebViewState extends State<PostWebView> {
  late InAppWebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주소 검색'),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white),
      ),
      body: InAppWebView(
        onWebViewCreated: (controller) {
          _controller = controller;
          _controller.addJavaScriptHandler(
            handlerName: 'jsHandler',
            callback: (arguments) {
              Map<String, dynamic> fromMap = arguments.first;
              Logger().d("_fromMap : $fromMap");
              Navigator.of(context).pop(fromMap);
            },
          );
        },
        initialUrlRequest:
            URLRequest(url: Uri.parse('http://203.229.171.79:85/post')),
      ),
    );
    // return WebView(initialUrl:
    // 'http://192.168.100.42:3000', //5층 ip
    // 'http://192.168.101.2:3000/post', // 3층 ip
    // 'http://203.229.171.79.2:3000/post', // 5층 소셜캠퍼스 ip
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(Platform.isAndroid) WebView.platform = AndroidWebView();
  }
}
