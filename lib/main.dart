import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/app_modules.dart';
import 'package:flutter_clean_architecture/app_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'injection/dependencies_injection.dart';

void main() {
  injectDependencies();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
