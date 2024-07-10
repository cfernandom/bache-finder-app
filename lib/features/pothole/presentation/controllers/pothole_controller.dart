import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/pothole/domain/use_cases/get_pothole.dart';
import 'package:bache_finder_app/features/pothole/domain/use_cases/save_pothole.dart';
import 'package:get/get.dart';

class PotholeController extends GetxController {
  final String _potholeId;
  final GetPothole _getPotholeUseCase;
  final SavePothole _savePotholeUseCase;

  PotholeController(
    this._potholeId, {
    required GetPothole getPotholeUseCase,
    required SavePothole savePotholeUseCase,
  })  : _getPotholeUseCase = getPotholeUseCase,
        _savePotholeUseCase = savePotholeUseCase;

  final _pothole = Rxn<Pothole>();
  final _isLoading = true.obs;
  var _errorMessage = '';

  Rxn<Pothole> get pothole => _pothole;
  Rx<bool> get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void resetErrorMessage() => _errorMessage = '';

  @override
  void onInit() {
    super.onInit();
    loadPothole();
  }

  Future<void> loadPothole() async {
    if (_potholeId.isEmpty || _potholeId == 'new') {
      _pothole.value = null;
      _isLoading.value = false;
      return;
    }

    final result = await _getPotholeUseCase.call(_potholeId);

    result.fold(
      (failure) => _errorMessage = failure.message,
      (pothole) => _pothole.value = pothole,
    );
    _isLoading.value = false;
  }

  Future<bool> savePothole(Map<String, dynamic> potholeLike) async {
    _isLoading.value = true;

    final result = await _savePotholeUseCase.call(_potholeId, potholeLike);

    result.fold(
      (failure) => _errorMessage = failure.message,
      (pothole) => _pothole.value = pothole, 
    );

    return result.isRight();
  }
}
