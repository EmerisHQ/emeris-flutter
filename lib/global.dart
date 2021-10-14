import 'package:alan/alan.dart';

//TODO refactor this to an interface
class BaseEnv {
  late NetworkInfo _networkInfo;
  late String _baseApiUrl;
  late String _baseEthUrl;
  late String _emerisBackendApiUrl;

  void setEnv({
    required String lcdUrl,
    required String grpcUrl,
    required String lcdPort,
    required String grpcPort,
    required String ethUrl,
    required String emerisUrl,
  }) {
    _networkInfo = NetworkInfo(
      bech32Hrp: 'cosmos',
      lcdInfo: LCDInfo(host: lcdUrl, port: int.parse(lcdPort)),
      grpcInfo: GRPCInfo(host: grpcUrl, port: int.parse(grpcPort)),
    );
    _baseApiUrl = "$lcdUrl:$lcdPort";
    _baseEthUrl = ethUrl;
    _emerisBackendApiUrl = emerisUrl;
  }

  NetworkInfo get networkInfo => _networkInfo;

  String get baseApiUrl => _baseApiUrl;

  String get baseEthUrl => _baseEthUrl;

  String get emerisBackendApiUrl => _emerisBackendApiUrl;
}

abstract class SharedPreferencesKeys {
  static const isWalletCreated = 'IS_APP_INSTALLED';

  static const encryptedMnemonic = 'ENCRYPTED_MNEMONIC';
}
