class ApiUrl {

  static const domain = 'https://api.deriv.com/';
  static const api = 'api-explorer/';
  static const baseUrl = domain + api;

  /// GET
  static const activeSymbols = '#active_symbols';
  static const ticks = '#ticks';
  static const forget = '#forget';

}

/// It has any header which used inside any API
class ApiHeaders {
  // get current language code of app
  // static final languageCode = translator.activeLanguageCode;
  static const cookie = "Cookie";
  static const sourceType = "Mobile";
  static const xLanguage = "x-language";
  static const source = "source";
  static const requiresToken = "requiresToken";
}