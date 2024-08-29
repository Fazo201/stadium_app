import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:stadium_project/firebase_options.dart';

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
