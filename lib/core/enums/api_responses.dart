enum ApiResponse {
  /// It occurs when url is timeout in case of (connect/send/receive).
  deadlineExceeded,

  /// It occurs when response status code 400.
  badRequest,

  /// It occurs when response status code 401.
  invalidCredentials,

  /// It occurs when response status code 403.
  unAuthorized,

  /// It occurs when response status code 404.
  requestNotFound,

  /// It occurs when response status code 405.
  methodNotAllowed,

  /// It occurs when response status code 409.
  conflict,

  /// It occurs when response status code 417.
  expectationFailed,

  /// It occurs when Token not founded in shared prefs.
  tokenNotFound,

  /// It occurs when response status code 500.
  internalServerError,

  /// It occurs when internet is disconnected.
  noInternetConnection,
}
