import 'package:flutter_test/flutter_test.dart';
import 'package:warranty_wallet/main.dart';

void main() {
  testWidgets('wallet dashboard renders', (tester) async {
    await tester.pumpWidget(const WarrantyWalletApp());
    expect(find.text('Warranty Wallet'), findsOneWidget);
    expect(find.text('Your items'), findsOneWidget);
    expect(find.text('AirPods Pro'), findsOneWidget);
  });
}
