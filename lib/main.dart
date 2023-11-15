import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getx_mvvm_boilerplate/di/config.dart';
import 'package:getx_mvvm_boilerplate/firebase_options.dart';
import 'package:getx_mvvm_boilerplate/ui/main_application.dart';

import 'application/env.dart';
import 'di/container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
} catch (e) {
  print('Error initializing Firebase: $e');
}

  var env = DevApiEnvironment();
  var container = DiContainer().withDefaultDependencies();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  runApp(MainApplication(
    env: env,
    container: container,
  ));
}
