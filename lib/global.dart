import 'package:sacco/network_info.dart';

//TODO refactor this to an interface
class BaseEnv {
  late NetworkInfo _networkInfo;
  String? _apiProtocol;
  late String _baseApiUrl;
  late String _baseEthUrl;

  void setEnv(String lcdUrl, String port, String ethUrl) {
    final isLocal = lcdUrl == 'localhost';
    _apiProtocol = isLocal ? 'http' : 'https';
    final fullLcdUrl = '$_apiProtocol://$lcdUrl:$port';
    _networkInfo = NetworkInfo(
      bech32Hrp: 'cosmos',
      lcdUrl: Uri.parse(fullLcdUrl),
    );
    _baseApiUrl = fullLcdUrl;
    _baseEthUrl = ethUrl;
  }

  NetworkInfo get networkInfo => _networkInfo;

  String get baseApiUrl => _baseApiUrl;

  String get baseEthUrl => _baseEthUrl;
}

abstract class SharedPreferencesKeys {
  static const isWalletCreated = 'IS_APP_INSTALLED';

  static const encryptedMnemonic = 'ENCRYPTED_MNEMONIC';
}
