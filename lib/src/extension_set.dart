import "package:markdown/markdown.dart" as md;
import "block_syntaxes/executive_code_syntax.dart";


final md.ExtensionSet mystMarkdown = md.ExtensionSet(
  List<md.BlockSyntax>.unmodifiable(
    <md.BlockSyntax>[
      const ExecutiveCodeSyntax(),
      const md.FencedCodeBlockSyntax(),
    ],
  ),
  List<md.InlineSyntax>.unmodifiable(
    <md.InlineSyntax>[
      md.InlineHtmlSyntax()
    ],
  ),
);
