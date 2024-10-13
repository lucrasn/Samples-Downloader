import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples_downloader/main.dart';

void main() {
  group('Testes de renderização', () {
    testWidgets('App renderiza corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      expect(find.byType(DriveCloneScreen), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(DataTable), findsOneWidget);
    });
  });
}
