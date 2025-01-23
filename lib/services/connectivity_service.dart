import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService._privateConstructor();
  static final ConnectivityService instance = ConnectivityService._privateConstructor();

  final Connectivity _connectivity = Connectivity();
  final StreamController<List<ConnectivityResult>> _connectivityStreamController =
  StreamController<List<ConnectivityResult>>.broadcast();

  List<ConnectivityResult> _currentStatus = [];

  Stream<List<ConnectivityResult>> get connectivityStream => _connectivityStreamController.stream;

  void initialize() {
    print("[ConnectivityService] Initializing connectivity service...");
    _checkInitialConnectivity();
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      print("[ConnectivityService] Connectivity changed: $result");
      _updateConnectivityStatus(result);
    });
  }

  Future<void> _checkInitialConnectivity() async {
    print("[ConnectivityService] Checking initial connectivity...");
    try {
      final List<ConnectivityResult> results = await _connectivity.checkConnectivity();
      print("[ConnectivityService] Initial connectivity status: $results");
      _updateConnectivityStatus(results);
    } catch (e) {
      print("[ConnectivityService] Error checking initial connectivity: $e");
      _updateConnectivityStatus([ConnectivityResult.none]);
    }
  }

  void _updateConnectivityStatus(List<ConnectivityResult> results) {
    print("[ConnectivityService] Updating connectivity status: $results");
    _currentStatus = results;
    _connectivityStreamController.add(_currentStatus);
  }

  List<ConnectivityResult> get currentStatus {
    print("[ConnectivityService] Current connectivity status: $_currentStatus");
    return _currentStatus;
  }

  bool get isWifiConnected {
    final wifiConnected = _currentStatus.contains(ConnectivityResult.wifi);
    print("[ConnectivityService] Is WiFi connected? $wifiConnected");
    return wifiConnected;
  }

  bool get isMobileConnected {
    final mobileConnected = _currentStatus.contains(ConnectivityResult.mobile);
    print("[ConnectivityService] Is mobile connected? $mobileConnected");
    return mobileConnected;
  }

  bool get isOffline {
    final offline = _currentStatus.contains(ConnectivityResult.none);
    print("[ConnectivityService] Is offline? $offline");
    return offline;
  }

  void dispose() {
    print("[ConnectivityService] Disposing connectivity stream controller...");
    _connectivityStreamController.close();
  }
}
