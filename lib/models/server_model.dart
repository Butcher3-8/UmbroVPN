class ServerModel {
  final String id;
  final String country;
  final String city;
  final String countryCode;
  final String ip;
  final int ping;
  final int load; // 0-100 percentage
  final bool isPremium;

  const ServerModel({
    required this.id,
    required this.country,
    required this.city,
    required this.countryCode,
    required this.ip,
    required this.ping,
    required this.load,
    this.isPremium = false,
  });

  String get flagEmoji {
    return countryCode.toUpperCase().runes.map((code) {
      return String.fromCharCode(code - 0x41 + 0x1F1E6);
    }).join();
  }

  // Sample server list
  static List<ServerModel> get sampleServers => [
        const ServerModel(
          id: 'us-1',
          country: 'United States',
          city: 'New York',
          countryCode: 'US',
          ip: '198.51.100.1',
          ping: 45,
          load: 35,
        ),
        const ServerModel(
          id: 'us-2',
          country: 'United States',
          city: 'Los Angeles',
          countryCode: 'US',
          ip: '198.51.100.2',
          ping: 62,
          load: 55,
        ),
        const ServerModel(
          id: 'uk-1',
          country: 'United Kingdom',
          city: 'London',
          countryCode: 'GB',
          ip: '203.0.113.1',
          ping: 78,
          load: 42,
        ),
        const ServerModel(
          id: 'de-1',
          country: 'Germany',
          city: 'Frankfurt',
          countryCode: 'DE',
          ip: '203.0.113.2',
          ping: 55,
          load: 28,
        ),
        const ServerModel(
          id: 'nl-1',
          country: 'Netherlands',
          city: 'Amsterdam',
          countryCode: 'NL',
          ip: '203.0.113.3',
          ping: 60,
          load: 38,
        ),
        const ServerModel(
          id: 'jp-1',
          country: 'Japan',
          city: 'Tokyo',
          countryCode: 'JP',
          ip: '203.0.113.4',
          ping: 120,
          load: 65,
          isPremium: true,
        ),
        const ServerModel(
          id: 'sg-1',
          country: 'Singapore',
          city: 'Singapore',
          countryCode: 'SG',
          ip: '203.0.113.5',
          ping: 135,
          load: 48,
          isPremium: true,
        ),
        const ServerModel(
          id: 'ca-1',
          country: 'Canada',
          city: 'Toronto',
          countryCode: 'CA',
          ip: '203.0.113.6',
          ping: 52,
          load: 30,
        ),
        const ServerModel(
          id: 'fr-1',
          country: 'France',
          city: 'Paris',
          countryCode: 'FR',
          ip: '203.0.113.7',
          ping: 70,
          load: 45,
          isPremium: true,
        ),
        const ServerModel(
          id: 'au-1',
          country: 'Australia',
          city: 'Sydney',
          countryCode: 'AU',
          ip: '203.0.113.8',
          ping: 180,
          load: 22,
          isPremium: true,
        ),
        const ServerModel(
          id: 'tr-1',
          country: 'Turkey',
          city: 'Istanbul',
          countryCode: 'TR',
          ip: '203.0.113.9',
          ping: 25,
          load: 50,
        ),
        const ServerModel(
          id: 'br-1',
          country: 'Brazil',
          city: 'São Paulo',
          countryCode: 'BR',
          ip: '203.0.113.10',
          ping: 155,
          load: 60,
          isPremium: true,
        ),
      ];
}
