/// Executive Code Syntax
/// https://jupyterbook.org/en/stable/reference/cheatsheet.html#executable-code

import 'package:markdown/src/util.dart';

import 'directive_syntax.dart';


/// Executive Code Syntax
/// Following https://jupyterbook.org/en/stable/reference/cheatsheet.html#executable-code
class ExecutiveCodeSyntax extends DirectiveSyntax {
  @override
  String get directiveName => 'code-cell';

  const ExecutiveCodeSyntax();

  @override
  Map<String, String> parseArguments(String? arguments, bool encodeHtml){
    Map<String, String> attributes = {};
    if (arguments!=null) {
      // only use the first word in the syntax
      // http://spec.commonmark.org/0.22/#example-100
      final firstSpace = arguments.indexOf(' ');
      if (firstSpace >= 0) {
        arguments = arguments.substring(0, firstSpace);
      }
      if (encodeHtml) {
        arguments = escapeHtmlAttribute(arguments);
      }
      // use kernel instead of language
      attributes['class'] = 'kernel-$arguments';
    }
    return attributes;
  }
}