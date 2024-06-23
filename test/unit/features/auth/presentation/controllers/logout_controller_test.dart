import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/logout.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/logout_controller.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class MockLogout extends Mock implements Logout {}

class MockSessionController extends GetxService
    with Mock
    implements SessionController {}

void main() {
  late MockSessionController mockSessionController;
  late MockLogout mockLogout;
  late LogoutController controller;

  setUp(() {
    mockSessionController = MockSessionController();
    
    Get.put<SessionController>(mockSessionController);

    mockLogout = MockLogout();
    controller = LogoutController(
      logoutUseCase: mockLogout,
    );
  });

  group('LogoutController', () {
    test('initial value are correct', () {
      expect(controller.isLoading.value, isTrue);
    });

    test('logout sets user correctly when succeeds', () async {
      // arrange
      when(() => mockLogout.call()).thenAnswer((_) async => const Right(null));
      when(() => mockSessionController.status)
          .thenReturn(Rx<SessionStatus>(SessionStatus.checking));
      when(() => mockSessionController.session).thenReturn(Rxn<Session>(null));
      // act
      final result = controller.logout();
      expect(controller.isLoading.value, isTrue);
      await result;
      // assert
      expect(controller.isLoading.value, isFalse);
      expect(controller.sessionController.session.value, null);
      expect(controller.sessionController.status.value, SessionStatus.loggedOut);
      verify(() => mockLogout.call()).called(1);
      verifyNoMoreInteractions(mockLogout);
    });
  });

  tearDown(() {
    Get.reset();
  });
}
