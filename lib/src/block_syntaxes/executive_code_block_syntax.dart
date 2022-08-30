/// Syntax for Executive Code Block
///
/// Ref:
///   - https://github.com/dart-lang/markdown/blob/master/lib/src/block_syntaxes/fenced_code_block_syntax.dart
///   - https://jupyterbook.org/en/stable/reference/cheatsheet.html#executable-code


import 'package:markdown/markdown.dart';

/// Syntax for Executive Code Block
/// https://jupyterbook.org/en/stable/reference/cheatsheet.html#executable-code
class ExecutiveCodeBlockSyntax extends BlockSyntax {
  @override
  RegExp get pattern => RegExp(r'^[ ]{0,3}(`{3,}|~{3,})(.*)$');

  const ExecutiveCodeBlockSyntax();

  @override
  Node? parse(BlockParser parser) {
    // TODO: implement parse
    throw UnimplementedError();
  }
}