import 'package:markdown/markdown.dart';


BlockParser generateParser(String markdown){
  Document document = Document();
  // Ref: https://github.com/dart-lang/markdown/blob/master/lib/src/html_renderer.dart#L40
  List<String> lines = markdown.replaceAll('\r\n', '\n').split('\n');
  return BlockParser(lines, document);
}