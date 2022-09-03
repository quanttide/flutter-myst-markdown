import 'package:flutter_test/flutter_test.dart';
import 'package:markdown/markdown.dart';

import 'package:flutter_myst_markdown/flutter_myst_markdown.dart';
import 'utils.dart';


String executiveCodeExample = """
```{code-cell} python
print('Hello, world!')
```
""";


void main(){
  group('ExecutiveCodeSyntax', (){
    test('ExecutiveCodeSyntax.pattern', (){
      RegExp pattern = RegExp('^[ ]{0,3}(`{3,}|~{3,})\{code-cell\}(.*)');
      RegExpMatch? match = pattern.firstMatch(executiveCodeExample);
      String? codeFence = match?.group(1)!;
      String? infoString = match?.group(2);
      expect(codeFence, '```');
      expect(infoString, ' python');
    });
    test('ExecutiveCodeSyntax.canParse', (){
      BlockParser parser = generateBlockParser(executiveCodeExample);
      ExecutiveCodeSyntax syntax = const ExecutiveCodeSyntax();
      bool canParse = syntax.canParse(parser);
      expect(canParse, true);
    });
    test('ExecutiveCodeSyntax.parseChildLines', (){
      BlockParser parser = generateBlockParser(executiveCodeExample);
      ExecutiveCodeSyntax syntax = const ExecutiveCodeSyntax();
      List<String> childLines = syntax.parseChildLines(parser);
      expect(childLines[0], "print('Hello, world!')");
      expect(childLines[1], "```");
    });
    test('ExecutiveCodeSyntax.parse', (){
      BlockParser parser = generateBlockParser(executiveCodeExample);
      ExecutiveCodeSyntax syntax = const ExecutiveCodeSyntax();
      Element element = syntax.parse(parser);
      expect(element.tag, 'pre');
      expect(element.textContent, "print('Hello, world!')\n");
    });
  });
}