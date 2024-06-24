import 'package:bache_finder_app/features/auth/infraestructure/inputs/email_input.dart';
import 'package:bache_finder_app/features/auth/infraestructure/inputs/password_input.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

class LoginFormController extends GetxController {
  final Function(String, String) login;

  LoginFormController({required this.login});

  final isPosted = false.obs;
  final isPosting = false.obs;
  final isValid = false.obs;
  final email = const EmailInput.pure().obs;
  final password = const PasswordInput.pure().obs;

  void onEmailChanged(String value) {
    final email = EmailInput.dirty(value);
    this.email.value = email;
    isValid.value = Formz.validate([email, password.value]);
  }

  void onPasswordChanged(String value) {
    final password = PasswordInput.dirty(value);
    
    this.password.value = password;
    isValid.value = Formz.validate([email.value, password]);
  }

  _touchAllFields() {
    final email = EmailInput.dirty(this.email.value.value);
    final password = PasswordInput.dirty(this.password.value.value);
    
    this.email.value = email;
    this.password.value = password;
    isValid.value = Formz.validate([email, password]);
    isPosted.value = true;
  }

  void submit() async {
    _touchAllFields();

    if (isValid.value) {
      isPosting.value = true;
      await login(email.value.value, password.value.value);
      isPosting.value = false;
    }
  }
}
