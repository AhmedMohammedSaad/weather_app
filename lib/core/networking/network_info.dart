import 'package:connectivity_plus/connectivity_plus.dart';

/// Contract interface for checking internet connectivity status.
abstract class NetworkInfo {
  /// Returns whether device currently has active network connectivity.
  Future<bool> get isConnected;

  /// Stream emitting connectivity status changes in real-time.
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
}

/// Implementation of [NetworkInfo] using [Connectivity].
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final results = await connectivity.checkConnectivity();
    return _isOnline(results);
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;

  /// Helper evaluating if connectivity results contain active network.
  static bool _isOnline(List<ConnectivityResult> results) {
    return results.any((result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet);
  }
}
