const KEY_TOKEN = "token";

const BASE_URL = 'https://api.github.com/';

class APIError {
  static const ERROR_AUTHORIZE = 401;
  static const ERROR_FORBIDDEN = 403;
  static const ERROR_NOT_FOUND = 404;
  static const ERROR_INTERNAL_SERVER = 500;
  static const ERROR_UPDATING_SERVER = 503;
}