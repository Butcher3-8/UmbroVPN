import 'package:flutter/material.dart';

class AppTranslations {
  AppTranslations._();

  static const List<LocaleInfo> supportedLocales = [
    LocaleInfo(locale: Locale('en'), name: 'English'),
    LocaleInfo(locale: Locale('tr'), name: 'Turkce'),
    LocaleInfo(locale: Locale('de'), name: 'Deutsch'),
    LocaleInfo(locale: Locale('es'), name: 'Espanol'),
  ];

  static const Map<String, Map<String, String>> _translations = {
    'en': _en,
    'tr': _tr,
    'de': _de,
    'es': _es,
  };

  static String translate(String key, String languageCode) {
    return _translations[languageCode]?[key] ??
        _translations['en']?[key] ??
        key;
  }

  // ─── English ───────────────────────────────────────────
  static const Map<String, String> _en = {
    'appName': 'UmbroVPN',
    'tagline': 'Fast & Secure VPN',

    // Connection
    'connect': 'Connect',
    'disconnect': 'Disconnect',
    'connecting': 'Connecting...',
    'connected': 'Connected',
    'disconnected': 'Not Connected',
    'disconnecting': 'Disconnecting...',
    'tapToConnect': 'Tap to connect',
    'tapToDisconnect': 'Tap to disconnect',

    // Stats
    'duration': 'Duration',
    'download': 'Download',
    'upload': 'Upload',

    // Servers
    'servers': 'Servers',
    'searchServers': 'Search servers...',
    'fastestServer': 'Fastest Server',
    'premium': 'Premium',
    'free': 'Free',
    'allServers': 'All Servers',
    'selectedFastest': 'Selected fastest server:',

    // Settings
    'settings': 'Settings',
    'theme': 'Theme',
    'darkMode': 'Dark Mode',
    'lightMode': 'Light Mode',
    'systemMode': 'System',
    'protocol': 'Protocol',
    'killSwitch': 'Kill Switch',
    'killSwitchDesc': 'Block internet if VPN disconnects',
    'autoConnect': 'Auto Connect',
    'autoConnectDesc': 'Connect on app launch',
    'about': 'About',
    'version': 'Version 1.0.0',
    'appearance': 'Appearance',
    'connection': 'Connection',
    'language': 'Language',
    'termsOfService': 'Terms of Service',
    'privacyPolicy': 'Privacy Policy',

    // Premium
    'goPremium': 'Go Premium',
    'premiumFeatures': 'Premium Features',
    'unlimitedSpeed': 'Unlimited Speed',
    'allServersAccess': 'Access All Servers',
    'noAds': 'No Ads',
    'prioritySupport': 'Priority Support',
    'monthly': 'Monthly',
    'yearly': 'Yearly',
    'subscribe': 'Subscribe',
    'bestValue': 'Best Value',
    'perMonth': '/month',
    'unlockFullPower': 'Unlock Full Power',
    'getAccessPremium': 'Get access to all premium features',
    'noBandwidthLimits': 'No bandwidth limits',
    'connect50Countries': 'Connect to 50+ countries',
    'adFreeExperience': 'Enjoy ad-free experience',
    'dedicatedSupport': '24/7 dedicated support',
    'billedYearly': '/month billed yearly',
    'premiumComingSoon': 'Premium coming soon!',
    'cancelAnytime': 'Cancel anytime. No questions asked.',

    // Profile
    'profile': 'Profile',
    'totalUsage': 'Total Usage',
    'dataUsed': 'Data Used',
    'sessionsCount': 'Sessions',
    'currentPlan': 'Current Plan',
    'freeUser': 'Free User',
    'premiumUser': 'Premium User',
    'upgradeToPremium': 'Upgrade to Premium',
    'freePlan': 'Free Plan',
    'unlockAllServers': 'Unlock all servers & features',

    // Navigation
    'home': 'Home',
  };

  // ─── Turkish ───────────────────────────────────────────
  static const Map<String, String> _tr = {
    'appName': 'UmbroVPN',
    'tagline': 'Hızlı & Güvenli VPN',

    // Connection
    'connect': 'Bağlan',
    'disconnect': 'Bağlantıyı Kes',
    'connecting': 'Bağlanıyor...',
    'connected': 'Bağlandı',
    'disconnected': 'Bağlı Değil',
    'disconnecting': 'Bağlantı kesiliyor...',
    'tapToConnect': 'Bağlanmak için dokun',
    'tapToDisconnect': 'Bağlantıyı kesmek için dokun',

    // Stats
    'duration': 'Süre',
    'download': 'İndirme',
    'upload': 'Yükleme',

    // Servers
    'servers': 'Sunucular',
    'searchServers': 'Sunucu ara...',
    'fastestServer': 'En Hızlı Sunucu',
    'premium': 'Premium',
    'free': 'Ücretsiz',
    'allServers': 'Tüm Sunucular',
    'selectedFastest': 'En hızlı sunucu seçildi:',

    // Settings
    'settings': 'Ayarlar',
    'theme': 'Tema',
    'darkMode': 'Koyu Mod',
    'lightMode': 'Açık Mod',
    'systemMode': 'Sistem',
    'protocol': 'Protokol',
    'killSwitch': 'Kill Switch',
    'killSwitchDesc': 'VPN kesilirse interneti engelle',
    'autoConnect': 'Otomatik Bağlan',
    'autoConnectDesc': 'Uygulama açılışında bağlan',
    'about': 'Hakkında',
    'version': 'Sürüm 1.0.0',
    'appearance': 'Görünüm',
    'connection': 'Bağlantı',
    'language': 'Dil',
    'termsOfService': 'Kullanım Koşulları',
    'privacyPolicy': 'Gizlilik Politikası',

    // Premium
    'goPremium': 'Premium\'a Geç',
    'premiumFeatures': 'Premium Özellikler',
    'unlimitedSpeed': 'Sınırsız Hız',
    'allServersAccess': 'Tüm Sunuculara Erişim',
    'noAds': 'Reklamsız',
    'prioritySupport': 'Öncelikli Destek',
    'monthly': 'Aylık',
    'yearly': 'Yıllık',
    'subscribe': 'Abone Ol',
    'bestValue': 'En Avantajlı',
    'perMonth': '/ay',
    'unlockFullPower': 'Tam Gücü Aç',
    'getAccessPremium': 'Tüm premium özelliklere eriş',
    'noBandwidthLimits': 'Bant genişliği limiti yok',
    'connect50Countries': '50+ ülkeye bağlan',
    'adFreeExperience': 'Reklamsız deneyimin tadını çıkar',
    'dedicatedSupport': '7/24 özel destek',
    'billedYearly': '/ay yıllık faturalandırma',
    'premiumComingSoon': 'Premium yakında!',
    'cancelAnytime': 'İstediğin zaman iptal et.',

    // Profile
    'profile': 'Profil',
    'totalUsage': 'Toplam Kullanım',
    'dataUsed': 'Kullanılan Veri',
    'sessionsCount': 'Oturum',
    'currentPlan': 'Mevcut Plan',
    'freeUser': 'Ücretsiz Kullanıcı',
    'premiumUser': 'Premium Kullanıcı',
    'upgradeToPremium': 'Premium\'a Yükselt',
    'freePlan': 'Ücretsiz Plan',
    'unlockAllServers': 'Tüm sunucu ve özellikleri aç',

    // Navigation
    'home': 'Ana Sayfa',
  };

  // ─── German ────────────────────────────────────────────
  static const Map<String, String> _de = {
    'appName': 'UmbroVPN',
    'tagline': 'Schnell & Sicher VPN',

    // Connection
    'connect': 'Verbinden',
    'disconnect': 'Trennen',
    'connecting': 'Verbinde...',
    'connected': 'Verbunden',
    'disconnected': 'Nicht verbunden',
    'disconnecting': 'Trenne...',
    'tapToConnect': 'Tippen zum Verbinden',
    'tapToDisconnect': 'Tippen zum Trennen',

    // Stats
    'duration': 'Dauer',
    'download': 'Download',
    'upload': 'Upload',

    // Servers
    'servers': 'Server',
    'searchServers': 'Server suchen...',
    'fastestServer': 'Schnellster Server',
    'premium': 'Premium',
    'free': 'Kostenlos',
    'allServers': 'Alle Server',
    'selectedFastest': 'Schnellster Server ausgewählt:',

    // Settings
    'settings': 'Einstellungen',
    'theme': 'Design',
    'darkMode': 'Dunkel',
    'lightMode': 'Hell',
    'systemMode': 'System',
    'protocol': 'Protokoll',
    'killSwitch': 'Kill Switch',
    'killSwitchDesc': 'Internet sperren wenn VPN trennt',
    'autoConnect': 'Auto-Verbindung',
    'autoConnectDesc': 'Beim App-Start verbinden',
    'about': 'Über',
    'version': 'Version 1.0.0',
    'appearance': 'Aussehen',
    'connection': 'Verbindung',
    'language': 'Sprache',
    'termsOfService': 'Nutzungsbedingungen',
    'privacyPolicy': 'Datenschutzrichtlinie',

    // Premium
    'goPremium': 'Premium holen',
    'premiumFeatures': 'Premium Funktionen',
    'unlimitedSpeed': 'Unbegrenzte Geschwindigkeit',
    'allServersAccess': 'Zugang zu allen Servern',
    'noAds': 'Keine Werbung',
    'prioritySupport': 'Prioritäts-Support',
    'monthly': 'Monatlich',
    'yearly': 'Jährlich',
    'subscribe': 'Abonnieren',
    'bestValue': 'Bestes Angebot',
    'perMonth': '/Monat',
    'unlockFullPower': 'Volle Power freischalten',
    'getAccessPremium': 'Zugang zu allen Premium-Funktionen',
    'noBandwidthLimits': 'Keine Bandbreitenbegrenzung',
    'connect50Countries': 'Verbindung zu 50+ Ländern',
    'adFreeExperience': 'Werbefreies Erlebnis',
    'dedicatedSupport': '24/7 Support',
    'billedYearly': '/Monat jährlich abgerechnet',
    'premiumComingSoon': 'Premium kommt bald!',
    'cancelAnytime': 'Jederzeit kündbar.',

    // Profile
    'profile': 'Profil',
    'totalUsage': 'Gesamtnutzung',
    'dataUsed': 'Datenverbrauch',
    'sessionsCount': 'Sitzungen',
    'currentPlan': 'Aktueller Plan',
    'freeUser': 'Kostenloser Nutzer',
    'premiumUser': 'Premium Nutzer',
    'upgradeToPremium': 'Auf Premium upgraden',
    'freePlan': 'Kostenloser Plan',
    'unlockAllServers': 'Alle Server & Funktionen freischalten',

    // Navigation
    'home': 'Startseite',
  };

  // ─── Spanish ───────────────────────────────────────────
  static const Map<String, String> _es = {
    'appName': 'UmbroVPN',
    'tagline': 'VPN Rápido y Seguro',

    // Connection
    'connect': 'Conectar',
    'disconnect': 'Desconectar',
    'connecting': 'Conectando...',
    'connected': 'Conectado',
    'disconnected': 'No Conectado',
    'disconnecting': 'Desconectando...',
    'tapToConnect': 'Toca para conectar',
    'tapToDisconnect': 'Toca para desconectar',

    // Stats
    'duration': 'Duración',
    'download': 'Descarga',
    'upload': 'Subida',

    // Servers
    'servers': 'Servidores',
    'searchServers': 'Buscar servidores...',
    'fastestServer': 'Servidor más rápido',
    'premium': 'Premium',
    'free': 'Gratis',
    'allServers': 'Todos los servidores',
    'selectedFastest': 'Servidor más rápido seleccionado:',

    // Settings
    'settings': 'Ajustes',
    'theme': 'Tema',
    'darkMode': 'Oscuro',
    'lightMode': 'Claro',
    'systemMode': 'Sistema',
    'protocol': 'Protocolo',
    'killSwitch': 'Kill Switch',
    'killSwitchDesc': 'Bloquear internet si VPN se desconecta',
    'autoConnect': 'Auto Conectar',
    'autoConnectDesc': 'Conectar al abrir la app',
    'about': 'Acerca de',
    'version': 'Versión 1.0.0',
    'appearance': 'Apariencia',
    'connection': 'Conexión',
    'language': 'Idioma',
    'termsOfService': 'Términos de Servicio',
    'privacyPolicy': 'Política de Privacidad',

    // Premium
    'goPremium': 'Hazte Premium',
    'premiumFeatures': 'Funciones Premium',
    'unlimitedSpeed': 'Velocidad ilimitada',
    'allServersAccess': 'Acceso a todos los servidores',
    'noAds': 'Sin anuncios',
    'prioritySupport': 'Soporte prioritario',
    'monthly': 'Mensual',
    'yearly': 'Anual',
    'subscribe': 'Suscribirse',
    'bestValue': 'Mejor oferta',
    'perMonth': '/mes',
    'unlockFullPower': 'Desbloquea todo el poder',
    'getAccessPremium': 'Accede a todas las funciones premium',
    'noBandwidthLimits': 'Sin límites de ancho de banda',
    'connect50Countries': 'Conéctate a 50+ países',
    'adFreeExperience': 'Experiencia sin anuncios',
    'dedicatedSupport': 'Soporte 24/7',
    'billedYearly': '/mes facturado anualmente',
    'premiumComingSoon': '¡Premium próximamente!',
    'cancelAnytime': 'Cancela cuando quieras.',

    // Profile
    'profile': 'Perfil',
    'totalUsage': 'Uso total',
    'dataUsed': 'Datos usados',
    'sessionsCount': 'Sesiones',
    'currentPlan': 'Plan actual',
    'freeUser': 'Usuario gratuito',
    'premiumUser': 'Usuario Premium',
    'upgradeToPremium': 'Mejorar a Premium',
    'freePlan': 'Plan gratuito',
    'unlockAllServers': 'Desbloquea todos los servidores',

    // Navigation
    'home': 'Inicio',
  };
}

class LocaleInfo {
  final Locale locale;
  final String name;

  const LocaleInfo({
    required this.locale,
    required this.name,
  });
}
