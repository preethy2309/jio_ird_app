class EnvConfig {
  static const String env = String.fromEnvironment('ENV', defaultValue: 'sit');

  static String get baseUrl {
    switch (env) {
      case 'dev':
        return 'https://preprod.jhes.cms.jio.com/jiohotels/';
      case 'prod':
        return 'https://prod.jhes.cms.jio.com/jiohotels/';
      default: // sit
        return 'https://devices.cms.jio.com/jiohotels/';
    }
  }

  static String getIv() => "5b5bc6c117391111";
  static String getKey() => "4db779e269dc587dd171516a86a62913";
}
