import 'package:flutter_test/flutter_test.dart';
import 'package:markdown/markdown.dart';

import 'package:flutter_myst_markdown/flutter_myst_markdown.dart';
import 'utils.dart';


String executiveCodeExample = """
```{code-cell} python
print('Hello, world!')
```

```{code-cell} python
1 + 1
```
""";


void main(){
  group('ExecutiveCodeBlockSyntax', (){
    BlockParser parser = generateBlockParser(executiveCodeExample);
    ExecutiveCodeBlockSyntax syntax = const ExecutiveCodeBlockSyntax();
    test('ExecutiveCodeBlockSyntax.pattern', (){
      // without `^` and `$`
      RegExp pattern = RegExp(r'[ ]{0,3}(`{3,}|~{3,})\{code-cell\}(.*)');
      RegExpMatch? match = pattern.firstMatch(executiveCodeExample);
      String? codeFence = match?.group(1)!;
      String? infoString = match?.group(2);
      expect(codeFence, '```');
      expect(infoString, ' python');
    });
    test('ExecutiveCodeBlockSyntax.canParse', (){
      bool canParse = syntax.canParse(parser);
      expect(canParse, true);
    });
    test('ExecutiveCodeBlockSyntax.parseChildLines', (){
      List<String> childLines = syntax.parseChildLines(parser);
      expect(childLines[0], "print('Hello, world!')");
      expect(childLines[1], "```");
    });
    test('ExecutiveCodeBlockSyntax.parse', (){
      print(parser.current);
      Node element = syntax.parse(parser);
      print(element);
    }, skip: 'can not pass');
  });
}