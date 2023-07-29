import 'dart:async';
import 'dart:io';

import 'package:beseated/src/shared/internet/connectivity_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_connected.g.dart';

@Riverpod(keepAlive: true)
class IsConnected extends _$IsConnected {
  final _connectivity = Connectivity();

  @override
  Future<ConnectivityState> build() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    var state = await _checkState(result);
    _connectivity.onConnectivityChanged.listen((result) async {
      // After change of connection some time to establish potential new connection
      await Future.delayed(const Duration(seconds: 3));
      this.state = await AsyncValue.guard(() => _checkState(result));
    });
    return state;
  }

  Future<ConnectivityState> _checkState(ConnectivityResult result) async {
    bool isOnline = await _checkInternetAccess();
    return ConnectivityState(connectivityResult: result, hasNetwork: isOnline);
  }

  @override
  bool updateShouldNotify(AsyncValue<ConnectivityState> previous, AsyncValue<ConnectivityState> next) {
    return previous.value?.hasNetwork != next.value?.hasNetwork;
  }

  /// If any of the pings returns true then you have internet (for sure). If none do, you probably don't.
  Future<bool> _checkInternetAccess() {
    /// We use a mix of IPV4 and IPV6 here in case some networks only accept one of the types.
    /// Only tested with an IPV4 only network so far (I don't have access to an IPV6 network).
    final List<InternetAddress> dnss = [
      InternetAddress('8.8.8.8', type: InternetAddressType.IPv4), // Google
      InternetAddress('2001:4860:4860::8888', type: InternetAddressType.IPv6), // Google
      InternetAddress('1.1.1.1', type: InternetAddressType.IPv4), // CloudFlare
      InternetAddress('2606:4700:4700::1111', type: InternetAddressType.IPv6), // CloudFlare
      InternetAddress('208.67.222.222', type: InternetAddressType.IPv4), // OpenDNS
      InternetAddress('2620:0:ccc::2', type: InternetAddressType.IPv6), // OpenDNS
      InternetAddress('180.76.76.76', type: InternetAddressType.IPv4), // Baidu
      InternetAddress('2400:da00::6666', type: InternetAddressType.IPv6), // Baidu
    ];

    final Completer<bool> completer = Completer<bool>();

    int callsReturned = 0;
    void onCallReturned(bool isAlive) {
      if (completer.isCompleted) return;

      if (isAlive) {
        completer.complete(true);
      } else {
        callsReturned++;
        if (callsReturned >= dnss.length) {
          completer.complete(false);
        }
      }
    }

    for (var dns in dnss) {
      _pingDns(dns).then(onCallReturned);
    }

    return completer.future;
  }

  Future<bool> _pingDns(InternetAddress dnsAddress) async {
    const int dnsPort = 53;
    const Duration timeout = Duration(seconds: 3);

    Socket? socket;
    try {
      socket = await Socket.connect(dnsAddress, dnsPort, timeout: timeout);
      socket.destroy();
      return true;
    } on SocketException {
      socket?.destroy();
    }
    return false;
  }
}