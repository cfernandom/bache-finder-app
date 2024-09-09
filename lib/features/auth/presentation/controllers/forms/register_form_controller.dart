import 'package:bache_finder_app/features/auth/infraestructure/inputs/email_input.dart';
import 'package:bache_finder_app/features/auth/infraestructure/inputs/password_input.dart';
import 'package:bache_finder_app/features/shared/infrastructure/inputs/text_input.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

class RegisterFormController extends GetxController {
  RegisterFormController({
    required Future<bool> Function(Map<String, dynamic> registerLike)
        registerCallback,
  }) : _registerCallback = registerCallback;

  final Future<bool> Function(Map<String, dynamic> registerLike)
      _registerCallback;

  final _isPosted = false.obs;
  final _isPosting = false.obs;
  final _isValid = false.obs;
  final _name = const TextInput.pure('').obs;
  final _email = const EmailInput.pure('').obs;
  final _password = const PasswordInput.pure().obs;
  final _confirmPassword = const PasswordInput.pure().obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  bool get isPosted => _isPosted.value;
  bool get isPosting => _isPosting.value;
  TextInput get name => _name.value;
  EmailInput get email => _email.value;
  PasswordInput get password => _password.value;
  PasswordInput get confirmPassword => _confirmPassword.value;

  void onNameChanged(String value) {
    final name = TextInput.dirty(value);
    _name.value = name;
    _isValid.value = Formz.validate([name]);
  }

  void onEmailChanged(String value) {
    final email = EmailInput.dirty(value);
    _email.value = email;
    _isValid.value = Formz.validate([email]);
  }

  void onPasswordChanged(String value) {
    final password = PasswordInput.dirty(value);
    _password.value = password;
    _isValid.value = Formz.validate([password]);
  }

  void onConfirmPasswordChanged(String value) {
    final confirmPassword = PasswordInput.dirty(value);
    _confirmPassword.value = confirmPassword;
    _isValid.value = Formz.validate([confirmPassword]);
  }

  _touchAllFields() {
    final name = TextInput.dirty(_name.value.value);
    final email = EmailInput.dirty(_email.value.value);
    final password = PasswordInput.dirty(_password.value.value);
    final confirmPassword = PasswordInput.dirty(_confirmPassword.value.value);

    _name.value = name;
    _email.value = email;
    _password.value = password;
    _confirmPassword.value = confirmPassword;
    _isValid.value = Formz.validate([name, email, password, confirmPassword]);
  }

  Future<bool> onSubmit() async {
    _touchAllFields();
    _isPosted.value = true;
    if (_isValid.value) {
      _isPosting.value = true;
      final registerLike = {
        'name': _name.value.value,
        'email': _email.value.value,
        'password': _password.value.value,
        'password_confirmation': _confirmPassword.value.value,
      };
      final result = await _registerCallback(registerLike);
      _isPosting.value = false;
      return result;
    }
    return false;
  }
}
