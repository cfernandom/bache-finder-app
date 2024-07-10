import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/pothole/domain/use_cases/get_potholes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PotholesController extends GetxController {
  final GetPotholes _getPotholesUseCase;

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
  }) : _getPotholesUseCase = getPotholesUseCase {
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
      (failure) =>  _errorMessage = failure.message,
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
}
