import 'package:final_project/data/local/local_pref.dart';
import 'package:final_project/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedHelper sharedHelper = SharedHelper();
  sharedHelper.init();
  runApp(const MyApp());
}
