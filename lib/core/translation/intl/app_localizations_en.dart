import 'app_localizations.dart';

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get pageNotFound => '404 - Page not found!';

  @override
  String get goHome => 'Go Home';

  @override
  String get home => 'Home';

  @override
  String get chat => 'Chat';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get logout => 'Logout';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get youDontHaveAnAccount => 'You don\'t have an account?';

  @override
  String get enterEmailAndPasswordToLogin => 'Enter email and password to login';

  @override
  String get enterEmailAndPasswordToRegister => 'Enter email and password to register';

  @override
  String get userNotFound => 'User not found';

  @override
  String get wrongPassword => 'Wrong password';

  @override
  String get errorOccured => 'An error occured. Please try again later';

  @override
  String get emailAddressIsAlreadyInUse => 'Email address is already in use';

  @override
  String get invalidEmail => 'Email address is not valid';

  @override
  String get weakPassword => 'Password is not strong enough';

  @override
  String get emailOrPasswordWrong => 'Email or password is incorrect';
}
