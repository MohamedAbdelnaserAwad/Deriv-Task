import 'package:flutter/material.dart';

import 'app.dart';
import 'bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/core/dependency_injection/service_locator.dart'
as di show initialize;
void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  di.initialize();
  runApp(const MyApp());
}



