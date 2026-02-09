class AppAssets {
  AppAssets._();

  static const String _svgPath = 'assets/svg';
  static const String _flagsPath = '$_svgPath/flags';

  // General
  static const String logo = '$_svgPath/logo.svg';
  static const String shield = '$_svgPath/shield.svg';
  static const String crown = '$_svgPath/crown.svg';

  // Flags
  static String flag(String countryCode) =>
      '$_flagsPath/${countryCode.toLowerCase()}.svg';
}
