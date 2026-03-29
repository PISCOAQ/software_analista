import 'dart:html' as html;

void downloadFile(List<int> bytes, String filename) {

  print("DOWNLOAD WEB CHIAMATO");
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  html.AnchorElement(href: url)
    ..setAttribute("download", filename)
    ..click();

  html.Url.revokeObjectUrl(url);
}