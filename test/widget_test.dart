import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:umbro_vpn/app.dart';
import 'package:umbro_vpn/providers/theme_provider.dart';
import 'package:umbro_vpn/providers/vpn_provider.dart';
import 'package:umbro_vpn/providers/server_provider.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => VpnProvider()),
          ChangeNotifierProvider(create: (_) => ServerProvider()),
        ],
        child: const UmbroVPNApp(),
      ),
    );

    expect(find.text('UmbroVPN'), findsOneWidget);
  });
}
