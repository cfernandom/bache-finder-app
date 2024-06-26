import 'package:bache_finder_app/features/auth/infraestructure/inputs/email_input.dart';
import 'package:bache_finder_app/features/auth/infraestructure/inputs/password_input.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

class LoginFormController extends GetxController {
  final Function(String, String) _login;

  LoginFormController({required dynamic Function(String, String) login}) : _login = login;

  final _isPosted = false.obs;
  final _isPosting = false.obs;
  final _isValid = false.obs;
  final _email = const EmailInput.pure().obs;
  final _password = const PasswordInput.pure().obs;

  bool get isPosted => _isPosted.value;
  bool get isPosting => _isPosting.value;
  EmailInput get email => _email.value;
  PasswordInput get password => _password.value;

  void onEmailChanged(String value) {
    final email = EmailInput.dirty(value);
    _email.value = email;
    _isValid.value = Formz.validate([email, _password.value]);
  }

  void onPasswordChanged(String value) {
    final password = PasswordInput.dirty(value);
    
    _password.value = password;
    _isValid.value = Formz.validate([_email.value, password]);
  }

  _touchAllFields() {
    final email = EmailInput.dirty(_email.value.value);
    final password = PasswordInput.dirty(_password.value.value);
    
    _email.value = email;
    _password.value = password;
    _isValid.value = Formz.validate([email, password]);
    _isPosted.value = true;
  }

  void submit() async {
    _touchAllFields();

    if (_isValid.value) {
      _isPosting.value = true;
      await _login(_email.value.value, _password.value.value);
      _isPosting.value = false;
    }
  }
}
