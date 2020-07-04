import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebViewScreen extends StatefulWidget {
  static String id = '/HelpScreen';
  final int urlId;

  WebViewScreen(this.urlId);

  @override
  WebViewScreenState createState() {
    return WebViewScreenState();
  }
}

class WebViewScreenState extends State<WebViewScreen> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  @override
  Widget build(BuildContext context) {
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      //print('onUrlChanged: $url');
      if ('https://daangor.com/user/listings' == url) {
        Navigator.pop(context);
      } else if ('https://daangor.com/user/purchase_history' == url) {
        Navigator.pop(context);
      } else if ('https://daangor.com/failed' == url) {
        showToast('Payment Failed');
        Navigator.pop(context);
      }
    });

    _onHttpError = flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
      flutterWebViewPlugin.reload();
    });

    return FutureBuilder<String>(
      future: getUrl(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return WebviewScaffold(
          appBar: AppBar(title: Text(getTitle())),
          url: snapshot.data,
          withJavascript: true,
        );
      },
    );
  }

  Future<String> getUrl() async {
    final prefs = await SharedPreferences.getInstance();
    String url = '';
    if (widget.urlId == 1) {
      url = 'https://daangor.com/user/listing_webform/add?token=${prefs.getString('token')}';
    } else if (widget.urlId == 2) {
      url = 'https://daangor.com/user/package_webview/add?token=${prefs.getString('token')}';
    } else if (widget.urlId == 3) {
      url = 'https://daangor.com/user/purchasehistory_webview/add?token=${prefs.getString('token')}';
    }

    print('url just hit - $url');
    return url;
  }

  String getTitle() {
    String title = '';
    if (widget.urlId == 1) {
      title = 'Add new Listing';
    } else if (widget.urlId == 2) {
      title = 'Packages';
    } else if (widget.urlId == 3) {
      title = 'Purchase History';
    }

    return title;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _onUrlChanged.cancel();
    _onHttpError.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showAlertDialog(String message) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text("My title"),
            content: Text(message),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            // title: Text("My title"),
            content: Text(message),
            actions: [
              CupertinoButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
