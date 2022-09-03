/// Executive Code Syntax
/// https://jupyterbook.org/en/stable/reference/cheatsheet.html#executable-code

import 'directive_syntax.dart';


/// Executive Code Syntax
/// Following https://jupyterbook.org/en/stable/reference/cheatsheet.html#executable-code
class ExecutiveCodeSyntax extends DirectiveSyntax {
  @override
  String get directiveName => 'code-cell';

  const ExecutiveCodeSyntax();
}