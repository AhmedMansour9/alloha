import 'package:alloha/data/model/response/language_model.dart';
import 'package:flutter/material.dart';

import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'Alloha';
  static const String APP_NAMEAR = 'الوها';

  static const String BASE_URL = 'https://jazarweb.com/api/';
  static const String LOGIN_URI = 'login';
  static const String REGISTER_URI = 'signupCustomer';
  static const String BANNER_URI = '/api/v1/banners';

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'notify';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Imagess.logo,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Imagess.logo,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];
}
