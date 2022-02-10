import 'package:flutter_app/utils/debug/debug_configurator.dart';

abstract class EmerisApiEnvironment implements WithTitle {
  const EmerisApiEnvironment(this.title, this.url);

  static const EmerisApiEnvironment defaultEnv = DevEmerisApiEnvironment();

  static EmerisApiEnvironment urlToEmerisApiEnvironment(String? url) {
    if (url == const DevEmerisApiEnvironment().url) {
      return const DevEmerisApiEnvironment();
    } else if (url == const StagingEmerisApiEnvironment().url) {
      return const StagingEmerisApiEnvironment();
    } else if (url == const ProductionEmerisApiEnvironment().url) {
      return const ProductionEmerisApiEnvironment();
    } else {
      return EmerisApiEnvironment.defaultEnv;
    }
  }

  @override
  final String title;
  final String url;
}

class DevEmerisApiEnvironment extends EmerisApiEnvironment {
  const DevEmerisApiEnvironment() : super('Dev', 'https://dev.emeris.com');
}

class StagingEmerisApiEnvironment extends EmerisApiEnvironment {
  const StagingEmerisApiEnvironment() : super('Staging', 'https://staging.emeris.com');
}

class ProductionEmerisApiEnvironment extends EmerisApiEnvironment {
  const ProductionEmerisApiEnvironment() : super('Production', 'https://api.emeris.com');
}
