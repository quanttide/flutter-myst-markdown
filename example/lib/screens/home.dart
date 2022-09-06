import "package:flutter/material.dart";
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:flutter_myst_markdown/flutter_myst_markdown.dart';


const markdownText = """
This is a fenced code block:

```python
print("Hello, world!")
```

This is an executive code block:

```{code-cell} python
1 + 2
```
""";


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Markdown(
        key: const Key("notebook-example"),
        data: markdownText,
        selectable: true,
        builders: {
          'code-cell': ExecutiveCodeBuilder(
              codeExecutingHandler: (input) async {
                return input;
              }
          ),
        },
        extensionSet: mystMarkdown
      )
    );
  }
}

