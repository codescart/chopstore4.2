import 'package:flutter/material.dart';
import 'package:chopstore/data/model/response/language_model.dart';
import 'package:chopstore/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext context}) {
    return AppConstants.languages;
  }
}
