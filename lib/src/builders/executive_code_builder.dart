/// Ref：
///   - API: https://pub.dev/documentation/flutter_markdown/latest/flutter_markdown/MarkdownElementBuilder/visitElementAfter.html
///   - Example: https://github.com/flutter/packages/blob/main/packages/flutter_markdown/example/lib/demos/subscript_syntax_demo.dart#L147


import "package:flutter/material.dart";
import "package:markdown/markdown.dart" as md;
import "package:flutter_markdown/flutter_markdown.dart";

import "../widgets/executive_code_block.dart";
import "../types.dart";


/// MarkdownElementBuilder for Executive Code
///
/// ```dart
/// Markdown(
///   builders: {
///     'code-cell': ExecutiveCodeBuilder(),
///   }
/// )
/// ```
///
/// where `Markdown` can be replaced by `MarkdownBody` or `MarkdownBuilder`.
///
class ExecutiveCodeBuilder extends MarkdownElementBuilder {
  final CodeExecutingHandler codeExecutingHandler;

  ExecutiveCodeBuilder({
    required this.codeExecutingHandler
  });

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return ExecutiveCodeBlock(
      controller: CodeExecutingController(
        codeExecutingHandler: codeExecutingHandler,
        defaultInput: element.textContent,
      ),
    );
  }
}