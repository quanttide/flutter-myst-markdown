/// Syntax for Executive Code Block
/// Following https://jupyterbook.org/en/stable/reference/cheatsheet.html#executable-code
///
/// Originally based on `package:markdown/src/block_syntaxes/fenced_code_block_syntax.dart` (BSD)
/// https://github.com/dart-lang/markdown/blob/master/lib/src/block_syntaxes/fenced_code_block_syntax.dart
/// See https://github.com/dart-lang/markdown/blob/master/LICENSE for original license.


import 'package:markdown/markdown.dart';
import 'package:markdown/src/charcode.dart';
import 'package:markdown/src/util.dart';


/// Syntax for Executive Code Block
/// Following https://jupyterbook.org/en/stable/reference/cheatsheet.html#executable-code
class ExecutiveCodeBlockSyntax extends BlockSyntax {
  @override
  RegExp get pattern => RegExp(r'^[ ]{0,3}(`{3,}|~{3,})\{code-cell\}(.*)$');

  const ExecutiveCodeBlockSyntax();

  @override
  bool canParse(BlockParser parser) {
    final match = pattern.firstMatch(parser.current);
    if (match == null) return false;
    final codeFence = match.group(1)!;
    final infoString = match.group(2);
    // From the CommonMark spec:
    //
    // > If the info string comes after a backtick fence, it may not contain
    // > any backtick characters.
    return (codeFence.codeUnitAt(0) != $backquote ||
        !infoString!.codeUnits.contains($backquote));
  }

  @override
  List<String> parseChildLines(BlockParser parser, [String? endBlock]) {
    endBlock ??= '';

    final childLines = <String>[];
    parser.advance();

    while (!parser.isDone) {
      final match = pattern.firstMatch(parser.current);
      if (match == null || !match[1]!.startsWith(endBlock)) {
        childLines.add(parser.current);
        parser.advance();
      } else {
        parser.advance();
        break;
      }
    }
    return childLines;
  }

  @override
  Node parse(BlockParser parser) {
    // Get the syntax identifier, if there is one.
    final match = pattern.firstMatch(parser.current)!;
    final endBlock = match.group(1);
    var infoString = match.group(2)!;

    final childLines = parseChildLines(parser, endBlock);

    // The Markdown tests expect a trailing newline.
    childLines.add('');

    var text = childLines.join('\n');
    if (parser.document.encodeHtml) {
      text = escapeHtml(text);
    }
    final code = Element.text('code', text);

    // the info-string should be trimmed
    // http://spec.commonmark.org/0.22/#example-100
    infoString = infoString.trim();
    if (infoString.isNotEmpty) {
      // only use the first word in the syntax
      // http://spec.commonmark.org/0.22/#example-100
      final firstSpace = infoString.indexOf(' ');
      if (firstSpace >= 0) {
        infoString = infoString.substring(0, firstSpace);
      }
      if (parser.document.encodeHtml) {
        infoString = escapeHtmlAttribute(infoString);
      }
      code.attributes['class'] = 'language-$infoString';
    }

    final element = Element('pre', [code]);

    return element;
  }
}