import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/pothole/domain/use_cases/get_potholes.dart';
import 'package:bache_finder_app/features/pothole/domain/use_cases/save_pothole.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class PotholesController extends GetxController {
  final GetPotholes _getPotholesUseCase;
  final SavePothole _savePotholeUseCase;

  final _scrollController = ScrollController();
  final _potholes = Rx<List<Pothole>>([]);
  final _isLoading = false.obs;
  var _errorMessage = '';
  var _page = 1;
  var _isLastPage = false;

  Rx<bool> get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Rx<List<Pothole>> get potholes => _potholes;
  ScrollController get scrollController => _scrollController;

  PotholesController({
    required getPotholesUseCase,
    required savePotholeUseCase,
  })  : _getPotholesUseCase = getPotholesUseCase,
        _savePotholeUseCase = savePotholeUseCase {
    _scrollController.addListener(() async {
      final scrollPosition = _scrollController.position;

      if (scrollPosition.pixels + 600 >= scrollPosition.maxScrollExtent) {
        await loadPotholes();
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    loadPotholes();
  }

  @override
  void onClose() {
    _scrollController.dispose();
    super.onClose();
  }

  Future<void> loadPotholes() async {
    if (_isLoading.value || _isLastPage) return;

    _isLoading.value = true;

    final result = await _getPotholesUseCase.call(_page);

    result.fold(
      (failure) => _errorMessage = failure.message,
      (potholes) {
        _page += 1;
        if (potholes.isEmpty) {
          _isLastPage = true;
          return;
        }
        _potholes.value = [..._potholes.value, ...potholes];
      },
    );
    _isLoading.value = false;
  }

  void resetErrorMessage() => _errorMessage = '';

  Future<Either<Failure, Pothole>> savePothole(
      String potholeId, Map<String, dynamic> potholeLike) async {
    final isPotholeInList =
        _potholes.value.any((element) => element.id == potholeId);

    final result = await _savePotholeUseCase.call(potholeId, potholeLike);

    result.fold((failure) => _errorMessage = failure.message, (pothole) {
      if (isPotholeInList) {
        _potholes.value = _potholes.value
            .map((element) => element.id == potholeId ? pothole : element)
            .toList();
        return;
      }
      _potholes.value = [..._potholes.value, pothole];
    });
    return result;
  }
}
