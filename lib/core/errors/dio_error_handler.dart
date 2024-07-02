import 'package:dio/dio.dart';

class DioErrorHandler {
  static String getErrorMessage(DioException error) {
    // Mensaje de error por defecto
    const defaultMessage = 'Ocurrió un error inesperado. Por favor, intenta nuevamente.';
    
    // Mensajes de error comunes
    const connectionErrorMessage = 'No se pudo establecer conexión. Verifica tu conexión a internet e intenta nuevamente.';
    const retryMessage = 'Por favor, intenta nuevamente.'; // Mensaje corto para intentar nuevamente
    
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return connectionErrorMessage;
      
      case DioExceptionType.cancel:
        return 'La solicitud fue cancelada. $retryMessage';
      
      case DioExceptionType.unknown:
        return 'Algo salió mal. $connectionErrorMessage';
      
      case DioExceptionType.badCertificate:
        return 'Error de certificado del servidor. $retryMessage';
      
      case DioExceptionType.connectionError:
        return connectionErrorMessage;
      
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null) {
          switch (statusCode) {
            case 401:
              return 'Credenciales incorrectas. Verifica tus credenciales e intenta nuevamente.';
            case 404:
              return 'No se encontró el recurso solicitado. $retryMessage';
            case 500:
              return 'Ocurrió un error en el servidor. $retryMessage';
            default:
              return 'Ocurrió un error con el código de estado $statusCode. $retryMessage';
          }
        }
        return 'Ocurrió un error con la respuesta del servidor. $retryMessage';
      
      default:
        return defaultMessage;
    }
  }
}