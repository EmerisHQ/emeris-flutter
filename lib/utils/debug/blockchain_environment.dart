import 'package:flutter_app/utils/debug/debug_configurator.dart';

abstract class BlockchainEnvironment implements WithTitle {
  const BlockchainEnvironment({
    required this.title,
    required this.lcdUrl,
    required this.lcdPort,
    required this.grpcUrl,
    required this.grpcPort,
  });

  static const BlockchainEnvironment defaultEnv = LocalhostBlockchainEnvironment();

  static BlockchainEnvironment lcdUrlToBlockchainEnvironment(String? url) {
    if (url == const LocalhostBlockchainEnvironment().lcdUrl) {
      return const LocalhostBlockchainEnvironment();
    } else if (url == const TestnetBlockchainEnvironment().lcdUrl) {
      return const TestnetBlockchainEnvironment();
    } else if (url == const CosmosHubBlockchainEnvironment().lcdUrl) {
      return const CosmosHubBlockchainEnvironment();
    } else {
      return BlockchainEnvironment.defaultEnv;
    }
  }

  @override
  final String title;
  final String lcdUrl;
  final String lcdPort;
  final String grpcUrl;
  final String grpcPort;
}

class LocalhostBlockchainEnvironment extends BlockchainEnvironment {
  const LocalhostBlockchainEnvironment()
      : super(
          title: 'Localhost',
          lcdUrl: 'http://localhost',
          lcdPort: '1317',
          grpcUrl: 'http://localhost',
          grpcPort: '9091',
        );
}

class TestnetBlockchainEnvironment extends BlockchainEnvironment {
  const TestnetBlockchainEnvironment()
      : super(
          title: 'Testnet',
          lcdUrl: 'https://api.testnet.cosmos.network',
          lcdPort: '443',
          grpcUrl: 'https://grpc.testnet.cosmos.network',
          grpcPort: '443',
        );
}

class CosmosHubBlockchainEnvironment extends BlockchainEnvironment {
  const CosmosHubBlockchainEnvironment()
      : super(
          title: 'Cosmos Hub',
          lcdUrl: 'https://api.cosmos.network',
          lcdPort: '443',
          grpcUrl: 'https://grpc.cosmos.network',
          grpcPort: '443',
        );
}
