import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples_downloader/main.dart';

void main() {
  group('Testes de Pesquisa do SamplesDownloader', () {
    testWidgets('Barra de pesquisa aparece na tela',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(TextField), findsOneWidget);
      expect(find.widgetWithIcon(TextField, Icons.search), findsOneWidget);
      expect(find.text('Pesquisar amostras'), findsOneWidget);
    });

    testWidgets('Filtro de pesquisa funciona corretamente',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField).first,
          'Planilha de notas Odontologia - 2024-2 - A');
      await tester.pump();

      expect(find.text('Planilha de notas Odontologia - 2024-2 - A'),
          findsWidgets);
      expect(find.textContaining('METODOLOGIA CIENTÍFICA - GERAL - 2023-2'),
          findsNothing);
    });

    testWidgets(
        'Verifica que todos os arquivos são exibidos após limpar a pesquisa',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Digita 'Odontologia' no campo de pesquisa
      await tester.enterText(find.byType(TextField), 'Odontologia');
      await tester.pump();

      // Verifica se apenas os arquivos relacionados a 'Odontologia' estão visíveis
      expect(find.text('Planilha de notas Odontologia - 2024-2 - A'),
          findsOneWidget);
      expect(find.text('Planilha de notas Odontologia - 2024-2 - B'),
          findsOneWidget);
      expect(
          find.text('METODOLOGIA CIENTÍFICA - GERAL - 2023-2'), findsNothing);
      expect(find.text('Planilha de notas Veterinária - 2024-2'), findsNothing);
      expect(
          find.text(
              'Lista de exercício de N1 (Revisão da Prova)- 2024-2 (respostas)'),
          findsNothing);
      expect(find.text('Horário Recursos Humanos 2024-1'), findsNothing);

      // Limpa o campo de pesquisa
      await tester.enterText(find.byType(TextField), '');
      await tester.pump();

      // Verifica se todos os arquivos estão visíveis novamente
      expect(find.text('Planilha de notas Odontologia - 2024-2 - A'),
          findsOneWidget);
      expect(find.text('Planilha de notas Odontologia - 2024-2 - B'),
          findsOneWidget);
      expect(
          find.text('METODOLOGIA CIENTÍFICA - GERAL - 2023-2'), findsOneWidget);
      expect(
          find.text('Planilha de notas Veterinária - 2024-2'), findsOneWidget);
      expect(
          find.text(
              'Lista de exercício de N1 (Revisão da Prova)- 2024-2 (respostas)'),
          findsOneWidget);
      expect(find.text('Horário Recursos Humanos 2024-1'), findsOneWidget);
    });
  });
}
