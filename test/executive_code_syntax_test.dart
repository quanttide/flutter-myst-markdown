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
    ExecutiveCodeSyntax syntax = const ExecutiveCodeSyntax();
    test('ExecutiveCodeSyntax.canParse', (){
      BlockParser parser = generateBlockParser(executiveCodeExample);
      bool canParse = syntax.canParse(parser);
      expect(canParse, true);
    });
    test('ExecutiveCodeSyntax.parseChildLines', (){
      BlockParser parser = generateBlockParser(executiveCodeExample);
      List<String> childLines = syntax.parseChildLines(parser);
      expect(childLines.length, 1);
      expect(childLines[0], "print('Hello, world!')");
    });
    test('ExecutiveCodeSyntax.parseArguments', (){
      const String arguments = 'python';
      Map<String, String> attributes = syntax.parseArguments(arguments);
      expect(attributes['class'], 'kernel-python');
    });
    test('ExecutiveCodeSyntax.parse', (){
      BlockParser parser = generateBlockParser(executiveCodeExample);
      Element element = syntax.parse(parser) as Element;
      expect(element.tag, 'pre');
      expect(element.textContent, "print('Hello, world!')\n");
      Element codeCellElement = element.children![0] as Element;
      expect(codeCellElement.attributes['class'], 'kernel-python');
      expect(codeCellElement.textContent, "print('Hello, world!')\n");
    });
  });
}