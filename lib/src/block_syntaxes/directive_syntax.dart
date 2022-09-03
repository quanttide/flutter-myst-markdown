/// Directive Syntax for MyST Markdown
/// https://myst-parser.readthedocs.io/en/latest/syntax/roles-and-directives.html#directives-a-block-level-extension-point
///
/// Originally based on `package:markdown/src/block_syntaxes/fenced_code_block_syntax.dart` (BSD)
/// https://github.com/dart-lang/markdown/blob/master/lib/src/block_syntaxes/fenced_code_block_syntax.dart
/// See https://github.com/dart-lang/markdown/blob/master/LICENSE for original license.

import 'package:markdown/markdown.dart';
import 'package:markdown/src/util.dart';


/// Directive syntax, a block-level extension point
/// https://myst-parsdthedocs.io/en/latest/syntax/roles-and-directives.html#directives-a-block-level-extension-point
abstract class DirectiveSyntax extends BlockSyntax {
  /// Use patterns of fenced code
  // the arguments should be trimmed
  // http://spec.commonmark.org/0.22/#example-100
  @override
  RegExp get pattern => RegExp(r'^[ ]{0,3}(`{3,}|~{3,})\{(.*)\}[ ]+(.*?)[ ]*$');

  RegExp get endBlockPattern => RegExp(r'[ ]{0,3}(`{3,}|~{3,})[ ]*$');

  /// Override by its subclasses to define the directive name
  String get directiveName;

  const DirectiveSyntax();

  @override
  bool canParse(BlockParser parser) {
    final match = pattern.firstMatch(parser.current);
    // not match
    if (match == null) return false;
    // match
    // check the directive name
    return (match.group(2) == directiveName);
  }

  /// parse the lines in the block
  @override
  List<String> parseChildLines(BlockParser parser, [String? endBlock]) {
    // `??=` means if it is `null`, it will be filled as the value.
    endBlock ??= '';
    final childLines = <String>[];

    // parse from the next line of the pattern
    parser.advance();

    while (!parser.isDone) {
      // match the end line
      final match = endBlockPattern.firstMatch(parser.current);
      if (match == null || !match[1]!.startsWith(endBlock)) {
        // not match
        childLines.add(parser.current);
        parser.advance();
      } else {
        parser.advance();
        break;
      }
    }
    return childLines;
  }

  /// parse arguments
  Map<String, String> parseArguments(String? arguments, bool encodeHtml);

  /// parse
  @override
  Node parse(BlockParser parser) {
    // Get the syntax identifier, if there is one.
    final match = pattern.firstMatch(parser.current)!;

    // code fence
    final String codeFence = match.group(1)!;
    // directive name
    final String directiveName = match.group(2)!;
    // arguments
    final String? arguments = match.group(3);

    // parse the child lines
    // begin and end code fence are same.
    List<String> childLines = parseChildLines(parser, codeFence);

    // The Markdown tests expect a trailing newline.
    childLines.add('');

    // merge as `textContent` property
    String text = childLines.join('\n');
    if (parser.document.encodeHtml) {
      text = escapeHtml(text);
    }

    // directive Element
    Element directive = Element.text(directiveName, text);
    // parse arguments
    Map<String, String> attributes = parseArguments(arguments, parser.document.encodeHtml);
    // directive.attributes = attributes;
    attributes.forEach((key, value) => directive.attributes[key]=value);

    // pre Element
    final element = Element('pre', [directive]);
    return element;
  }
}