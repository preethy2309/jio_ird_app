class EnvConfig {
  static const String env = String.fromEnvironment('ENV', defaultValue: 'sit');

  static String get baseUrl {
    switch (env) {
      case 'dev':
        return 'https://preprod.jhes.cms.jio.com/jiohotels/';
      case 'prod':
        return 'https://prod.jhes.cms.jio.com/jiohotels/';
      default: // sit
        return 'https://sit.jhes.cms.jio.com/jiohotels/';
    }
  }
}
