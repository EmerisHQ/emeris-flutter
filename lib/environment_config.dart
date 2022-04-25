import 'package:alan/alan.dart';
import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:grpc/grpc.dart';

//TODO refactor this to an interface
class EnvironmentConfig {
  factory EnvironmentConfig({
    String? lcdUrl,
    String? grpcUrl,
    String? lcdPort,
    String? grpcPort,
    String? ethUrl,
    String? emerisUrl,
  }) {
    // ignore: do_not_use_environment
    const envLcdPort = String.fromEnvironment('LCD_PORT', defaultValue: '1317');
    // ignore: do_not_use_environment
    const envGrpcPort = String.fromEnvironment('GRPC_PORT', defaultValue: '9091');
    // ignore: do_not_use_environment
    const envLcdUrl = String.fromEnvironment('LCD_URL', defaultValue: 'http://localhost');
    // ignore: do_not_use_environment
    const envGrpcUrl = String.fromEnvironment('GRPC_URL', defaultValue: 'http://localhost');
    // ignore: do_not_use_environment
    const envEthUrl = String.fromEnvironment('ETH_URL', defaultValue: 'HTTP://127.0.0.1:7545');
    // ignore: do_not_use_environment
    const envEmerisUrl = String.fromEnvironment('EMERIS_URL', defaultValue: 'https://dev.demeris.io');
    final grpcPortInt = int.parse(grpcPort ?? envGrpcPort);
    final grpcInfo = GRPCInfo(
      host: grpcUrl ?? envGrpcUrl,
      port: grpcPortInt,
      credentials: grpcPortInt == 443 //
          ? const ChannelCredentials.secure()
          : const ChannelCredentials.insecure(),
    );
    final lcdInfo = LCDInfo(
      host: lcdUrl ?? envLcdUrl,
      port: int.parse(lcdPort ?? envLcdPort),
    );
    final environmentConfig = EnvironmentConfig._(
      networkInfo: NetworkInfo(
        bech32Hrp: 'cosmos',
        lcdInfo: lcdInfo,
        grpcInfo: grpcInfo,
      ),
      baseEthUrl: ethUrl ?? envEthUrl,
      emerisBackendApiUrl: emerisUrl ?? envEmerisUrl,
    );
    debugLog('\n\nGRPC: ${environmentConfig.networkInfo.grpcInfo}');
    debugLog('\n\nLCD: ${environmentConfig.networkInfo.lcdInfo}');
    debugLog('\n\nEMERIS URL: ${environmentConfig.emerisBackendApiUrl}\n\n');
    return environmentConfig;
  }

  EnvironmentConfig._({
    required this.networkInfo,
    required this.baseEthUrl,
    required this.emerisBackendApiUrl,
  });

  final NetworkInfo networkInfo;
  final String baseEthUrl;
  final String emerisBackendApiUrl;
}

abstract class SharedPreferencesKeys {
  static const isWalletCreated = 'IS_APP_INSTALLED';

  static const encryptedMnemonic = 'ENCRYPTED_MNEMONIC';
}
