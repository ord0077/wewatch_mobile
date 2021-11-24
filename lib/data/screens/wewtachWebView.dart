// import 'dart:io';
// import 'package:flutter/material.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class WewatchWebview extends StatefulWidget {
//   WewatchWebview({Key key,}) : super(key: key);
//
//   @override
//   _WewatchWebview createState() => _WewatchWebview();
// }
//
// class _WewatchWebview extends State<WewatchWebview> {
//   InAppWebViewController _webViewController;
//   double progress = 0;
//   String url = '';
//
//   final GlobalKey webViewKey = GlobalKey();
//   // Future<Directory?>? _externalDocumentsDirectory =
//   //     getExternalStorageDirectory();
//
//   InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
//       crossPlatform: InAppWebViewOptions(
//         javaScriptEnabled: true,
//         useShouldOverrideUrlLoading: true,
//         useOnDownloadStart: true,
//         supportZoom: false,
//       ),
//       android: AndroidInAppWebViewOptions(
//         initialScale: 100,
//         useShouldInterceptRequest: true,
//         useHybridComposition: true,
//       ),
//       ios: IOSInAppWebViewOptions(
//         allowsInlineMediaPlayback: true,
//       ));
//
//   PullToRefreshController pullToRefreshController;
//   final urlController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//
//     pullToRefreshController = PullToRefreshController(
//       options: PullToRefreshOptions(color: Colors.blue),
//       onRefresh: () async {
//         if (Platform.isAndroid) {
//           _webViewController?.reload();
//         } else if (Platform.isIOS) {
//           _webViewController?.loadUrl(
//               urlRequest: URLRequest(url: await _webViewController?.getUrl()));
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  SafeArea(child: Scaffold(
//
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             children: [
//
//               Expanded(
//                 child: InAppWebView(
//                   key: webViewKey,
//
//                   initialUrlRequest: URLRequest(
//                     url: Uri.parse("https://wewatch.ae/"),
//                     // Uri.parse(widget.url),
//                     headers: {},
//                   ), // "https://unsplash.com/photos/odxB5oIG_iA"
//                   initialOptions: options,
//                   pullToRefreshController: pullToRefreshController,
//
//                   onDownloadStart: (controller, url) async {
//                     // downloading a file in a webview application
//                     print("onDownloadStart $url");
//                     await FlutterDownloader.enqueue(
//                       url: url.toString(), // url to download
//                       savedDir: (await getExternalStorageDirectory()).path,
//                       // the directory to store the download
//                       fileName: 'downloads',
//                       headers: {},
//                       showNotification: true,
//                       openFileFromNotification: true,
//                     );
//                   },
//                   onWebViewCreated: (controller) {
//                     _webViewController = controller;
//                   },
//                   onLoadStart: (controller, url) {
//                     setState(() {
//                       this.url = url.toString();
//                       urlController.text = this.url;
//                     });
//                   },
//                   androidOnPermissionRequest:
//                       (controller, origin, resources) async {
//                     return PermissionRequestResponse(
//                         resources: resources,
//                         action: PermissionRequestResponseAction.GRANT);
//                   },
//                   onLoadStop: (controller, url) async {
//                     pullToRefreshController.endRefreshing();
//                     setState(() {
//                       this.url = url.toString();
//                       urlController.text = this.url;
//                     });
//                   },
//                   onLoadHttpError: (controller, url, code, message) async {
//                     pullToRefreshController.endRefreshing();
//                     var tRexHtml = await controller.getTRexRunnerHtml();
//                     var tRexCss = await controller.getTRexRunnerCss();
//
//                     controller.loadData(data: """
// <html>
//   <head>
//     <meta charset="UTF-8">
//     <meta http-equiv="X-UA-Compatible" content="IE=edge">
//     <meta name="viewport" content="width=device-width, initial-scale=1.0">
//     <title>No connection to the internet</title>
//     <style>
//       html,body { margin:0 center; padding:0; }
//       html {
//         background: #191919 -webkit-linear-gradient(top, #FFF 0%, #191919 100%) no-repeat;
//         background: #191919 linear-gradient(to bottom, #FFF 0%, #191919 100%) no-repeat;
//       }
//       body {
//         font-family: sans-serif;
//         color: #000;
//         text-align: center;
//         font-size: 100%;
//       }
//       h1, h2 { font-weight: normal; }
//       h1 { margin: 0 auto; padding: 0.15em; font-size: 5em; text-shadow: 0 2px 2px #000; }
//       h2 { margin-bottom: 1em; }
//     </style>
//   </head>
//   <body>
//   <div style="width:600px;">
//     <h1>⚠</h1>
//     <h2>No connection to the internet</h2>
//   </body>
// </html> """);
//                   },
//
//                   onLoadError: (controller, url, code, message) async {
//                     pullToRefreshController.endRefreshing();
//                     var tRexHtml = await controller.getTRexRunnerHtml();
//                     var tRexCss = await controller.getTRexRunnerCss();
//
//                     controller.loadData(data: """
// <html>
//   <head>
//     <meta charset="UTF-8">
//     <meta http-equiv="X-UA-Compatible" content="IE=edge">
//     <meta name="viewport" content="width=device-width, initial-scale=1.0">
//     <title>No connection to the internet</title>
//     <style>
//       html,body { margin:0 center; padding:0; }
//       html {
//         background: #191919 -webkit-linear-gradient(top, #FFF 0%, #191919 100%) no-repeat;
//         background: #191919 linear-gradient(to bottom, #FFF 0%, #191919 100%) no-repeat;
//       }
//       body {
//         font-family: sans-serif;
//         color: #000;
//         text-align: center;
//         font-size: 100%;
//       }
//       h1, h2 { font-weight: normal; }
//       h1 { margin: 0 auto; padding: 0.15em; font-size: 5em; text-shadow: 0 2px 2px #000; }
//       h2 { margin-bottom: 1em; }
//     </style>
//   </head>
//   <body>
//   <div style="width:600px;">
//     <h1>⚠</h1>
//     <h2>No connection to the internet</h2>
//   </body>
// </html> """);
//                   },
//
//
//                   onProgressChanged: (controller, progress) {
//                     if (progress == 100) {
//                       pullToRefreshController.endRefreshing();
//                     }
//                     setState(() {
//                       this.progress = progress / 100;
//                       urlController.text = this.url;
//                     });
//                   },
//                   onUpdateVisitedHistory: (controller, url, androidIsReload) {
//                     setState(() {
//                       this.url = url.toString();
//                       urlController.text = this.url;
//                     });
//                   },
//                   onConsoleMessage: (controller, consoleMessage) {
//                     print(consoleMessage);
//                   },
//                 ),
//               ),
//               // ButtonBar(
//               //   buttonAlignedDropdown: true,
//               //   buttonPadding: EdgeInsets.all(2),
//               //   alignment: MainAxisAlignment.spaceAround,
//               //   children: <Widget>[
//               //     ElevatedButton(
//               //       child: Icon(Icons.arrow_back),
//               //       onPressed: () {
//               //         _webViewController?.goBack();
//               //       },
//               //     ),
//               //     ElevatedButton(
//               //       child: Icon(Icons.arrow_forward),
//               //       onPressed: () {
//               //         _webViewController?.goForward();
//               //       },
//               //     ),
//               //     ElevatedButton(
//               //       child: Icon(Icons.refresh),
//               //       onPressed: () {
//               //         _webViewController?.reload();
//               //       },
//               //     ),
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//     ));
//
//   }
// }
