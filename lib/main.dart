import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imvision_studio/services/firestore_database.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(Provider(
    create: (context) => FireStoreDatabase(),
    child: const App(),
  ));
}
