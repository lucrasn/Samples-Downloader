import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples_downloader/main.dart';

void main() {
  group('Testes de Pesquisa do SamplesDownloader', () {
    testWidgets('Barra de pesquisa aparece na tela', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(TextField), findsOneWidget);
      expect(find.widgetWithIcon(TextField, Icons.search), findsOneWidget);
    });

    testWidgets('Filtro de pesquisa funciona corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField).first, 'Planilha de notas Odontologia - 2024-2 - A');
      await tester.pump();

      expect(find.text('Planilha de notas Odontologia - 2024-2 - A'), findsWidgets);
      expect(find.textContaining('METODOLOGIA CIENTÍFICA - GERAL - 2023-2'), findsNothing);
    });
  });
}