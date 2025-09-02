// ignore_for_file: prefer_final_fields, file_names

import 'package:flutter/material.dart';

class UnitProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
}
