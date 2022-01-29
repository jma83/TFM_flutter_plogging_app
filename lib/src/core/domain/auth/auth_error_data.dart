final Map<List<String>, String> authErrorList = {
  _emailError: _emailErrorResponse,
  _passwordError: _passwordErrorResponse,
  _userNotFoundError: _userNotFoundErrorResponse,
  _userDisabledError: _userDisabledErrorResponse,
  _tooManyRequestsError: _tooManyRequestsErrorResponse,
  _operationNotAllowedError: _operationNotAllowedErrorResponse,
  _invalidEmailError: _invalidEmailErrorResponse,
  _requiresRecentError: _requiresRecentErrorResponse,
  _networkFailedError: _networkFailedErrorResponse
};
const String genericError = "Operation failed. Please try again.";

// Auth error codes:
const List<String> _emailError = [
  "ERROR_EMAIL_ALREADY_IN_USE",
  "account-exists-with-different-credential",
  "email-already-in-use"
];
const List<String> _passwordError = ["ERROR_WRONG_PASSWORD", "wrong-password"];
const List<String> _userNotFoundError = [
  "ERROR_USER_NOT_FOUND",
  "user-not-found"
];
const List<String> _userDisabledError = [
  "ERROR_USER_DISABLED",
  "user-disabled"
];
const List<String> _tooManyRequestsError = [
  "ERROR_TOO_MANY_REQUESTS",
  "too-many-requests"
];
const List<String> _operationNotAllowedError = [
  "ERROR_OPERATION_NOT_ALLOWED",
  "operation-not-allowed"
];
const List<String> _invalidEmailError = [
  "ERROR_INVALID_EMAIL",
  "invalid-email"
];
const List<String> _requiresRecentError = ["requires-recent-login"];
const List<String> _networkFailedError = ["network-request-failed"];

// Error responses:
const String _emailErrorResponse = "Email already used. Go to login page.";
const String _passwordErrorResponse = "Wrong password combination.";
const String _userNotFoundErrorResponse = "No user found with this email.";
const String _userDisabledErrorResponse = "User disabled.";
const String _tooManyRequestsErrorResponse =
    "Too many requests for this account. Please try again, later.";
const String _operationNotAllowedErrorResponse =
    "Operation not allowed, please try again later.";
const String _invalidEmailErrorResponse = "Email address is invalid.";
const String _requiresRecentErrorResponse =
    "For updating Email, you must introduce your current password";
const String _networkFailedErrorResponse =
    "You are disconnected. Please check your connection and try again";
