import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';

import 'http_client_builder.dart';

/// A default implementation of the [HttpClientBuilder] abstract class.
///
/// This class provides a concrete implementation of the [create] method,
/// which simply returns a new instance of [Dio] with default settings.
/// It can be used wherever a basic HTTP client is needed without any custom configuration.
///
/// Example usage:
/// ```dart
/// final clientBuilder = HttpClientDefault();
/// final httpClient = clientBuilder.create();
/// ```
class HttpClientDefault extends HttpClientBuilder {
  /// Creates and returns a new [HttpClient] instance with default configuration.
  ///
  /// This method overrides the abstract [create] method from [HttpClientBuilder].
  /// The returned [Dio] can be used to perform HTTP requests.
  @override
  Dio create() {
    final dio = Dio();
    try {
      dio.httpClientAdapter = NativeAdapter(
        createFallbackAdapter: (_, __) => IOHttpClientAdapter(),
      );
    } catch (_) {
      // Keep the default Dart IO adapter when the native adapter cannot be
      // loaded, for example on an unsupported simulator/runtime.
    }
    return dio;
  }
}
