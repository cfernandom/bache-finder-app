import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole_prediction.dart';
import 'package:bache_finder_app/features/pothole/application/use_cases/get_pothole.dart';
import 'package:bache_finder_app/features/pothole/application/use_cases/predict_pothole.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class PotholeController extends GetxController {
  final Future<Either<Failure, Pothole>> Function(
      String potholeId, Map<String, dynamic> potholeLike) _savePotholeCallback;
  final String _potholeId;
  final GetPothole _getPotholeUseCase;
  final PredictPothole _predictPotholeUseCase;

  PotholeController(
    this._potholeId, {
    required savePotholeCallback,
    required GetPothole getPotholeUseCase,
    required PredictPothole predictPotholeUseCase,
  })  : _savePotholeCallback = savePotholeCallback,
        _getPotholeUseCase = getPotholeUseCase,
        _predictPotholeUseCase = predictPotholeUseCase;

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

    final result = await _savePotholeCallback(_pothole.value?.id ?? 'new', potholeLike);

    result.fold(
      (failure) => _errorMessage = failure.message,
      (pothole) => _pothole.value = pothole,
    );
    _isLoading.value = false;

    return result.isRight();
  }

  Future<Either<Failure, PotholePrediction>> predictPothole() async {
    if (_pothole.value == null) {
      return left(const Failure('No se puede predecir el bache si no hay un bache cargado'));
    }
    return await _predictPotholeUseCase.call(_pothole.value!.id);
  }
}
