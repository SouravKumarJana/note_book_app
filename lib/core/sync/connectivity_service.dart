import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  final StreamController<bool> _controller =
      StreamController<bool>.broadcast();

  bool _isConnected = false;

  ConnectivityService() {
    _init();
  }

  bool get isConnected => _isConnected;  

  Stream<bool> get connectionStream => _controller.stream;

  Future<void> _init() async {
    final result = await _connectivity.checkConnectivity();
    _updateStatus(result);

    _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(ConnectivityResult result) {
    final connected = result != ConnectivityResult.none;
    _isConnected = connected; 
    _controller.add(connected);
  }
}
