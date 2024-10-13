import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples_downloader/main.dart';

void main() {
  group('Testes de DataTable do SamplesDownloader', () {
    testWidgets('DataTable aparece na tela', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(DataTable), findsOneWidget);
    });

    testWidgets('Itens de arquivo são exibidos no DataTable',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(
          find.text('METODOLOGIA CIENTÍFICA - GERAL - 2023-2'), findsOneWidget);
      expect(
          find.text('Planilha de notas Veterinária - 2024-2'), findsOneWidget);
      expect(
          find.text(
              'Lista de exercício de N1 (Revisão da Prova)- 2024-2 (respostas)'),
          findsOneWidget);
      expect(find.text('Planilha de notas Odontologia - 2024-2 - A'),
          findsOneWidget);
      expect(find.text('Planilha de notas Odontologia - 2024-2 - B'),
          findsOneWidget);
      expect(find.text('Horário Recursos Humanos 2024-1'), findsOneWidget);
    });

    testWidgets('Verifica a abreviação dos nomes dos arquivos no DataTable',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Encontra o arquivo com um nome muito longo
      final longFileName =
          'Lista de exercício de N1 (Revisão da Prova)- 2024-2 (respostas)';
      final textWidget = tester.widget<Text>(find.text(longFileName));

      // Verifica se o Text widget está configurado para overflow com reticências
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });
  });
}
