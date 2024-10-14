import 'package:bache_finder_app/features/auth/domain/entities/user.dart';
import 'package:bache_finder_app/features/user/application/use_cases/get_current_user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final GetCurrentUser _getCurrentUser;

  UserController({
    required GetCurrentUser getCurrentUser,
  }) : _getCurrentUser = getCurrentUser;

  // Observables
  final _user = Rxn<User>();
  final _currentUser = Rxn<User>();
  final _isLoading = true.obs;
  var _errorMessage = '';

  // Getters
  Rxn<User> get user => _user;
  Rxn<User> get currentUser => _currentUser;
  Rx<bool> get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    _isLoading.value = true;
    final result = await _getCurrentUser.call();

    result.fold(
      (failure) => _errorMessage = failure.message,
      (user) => {
        _currentUser.value = user,
        _errorMessage = '',
      },
    );

    _isLoading.value = false;
  }

  void resetErrorMessage() => _errorMessage = '';

  @override
  void onClose() {
    _user.close();
    _currentUser.close();
    _isLoading.close();
    super.onClose();
  }
}
