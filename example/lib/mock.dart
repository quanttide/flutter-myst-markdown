/// mock模块


import "package:cloud_ide_widgets/cloud_ide_widgets.dart";
import "environment_config.dart";


Future<String> mockCodeExecutingHandler(String input) async {
  return input;
}


Future<String> codeExecutingHandler(String input) async {
  CloudExecutor codeExecutor = CloudExecutor(
      host: EnvironmentConfig.cloudExecutorHost,
      path: EnvironmentConfig.cloudExecutorPath
  );
  return await codeExecutor.execute(input);
}
