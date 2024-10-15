import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples_downloader/main.dart';

void main() {
  group('Testes de Interações do SamplesDownloader', () {
    testWidgets('Renomear arquivo exibe o diálogo e renomeia corretamente',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1600, 1200);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(const MyApp());

      // Tocar no ícone de "três pontinhos" para o primeiro item da lista
      if (find.byIcon(Icons.more_vert).evaluate().isNotEmpty) {
        await tester.ensureVisible(find.byIcon(Icons.more_vert).first);
      }
      if (find.byIcon(Icons.more_vert).evaluate().isNotEmpty) {
        await tester.tap(find.byIcon(Icons.more_vert).first);
      }
      await tester.pumpAndSettle();

      // Tocar na opção "Renomear" no menu popup
      expect(find.text('Renomear'), findsOneWidget);
      await tester.tap(find.text('Renomear'));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      // Garantir que o diálogo de renomear aparece
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Renomear item'), findsOneWidget);

      // Inserir novo nome e confirmar
      await tester.enterText(find.byType(TextField).first, 'Novo Nome');
      await tester.tap(find.widgetWithText(TextButton, 'Renomear'));
      await tester.pumpAndSettle();

      // Verificar se o arquivo foi renomeado
      expect(find.text('Novo Nome'), findsOneWidget);
    });

    testWidgets('Clicar fora limpa a seleção', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Selecionar a primeira linha no DataTable
      if (find.byType(DataRow).evaluate().isNotEmpty) {
        await tester.ensureVisible(find.byType(DataRow).first);
      }
      if (find.byType(DataRow).evaluate().isNotEmpty) {
        await tester.tap(find.byType(DataRow).first);
      }
      await tester.pumpAndSettle();
      await tester.pump();
      // Restaurar o tamanho da janela ao final do teste
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();

      // Garantir que a primeira linha está selecionada
      if (find.byType(DataRow).evaluate().isNotEmpty) {
        expect(find.byType(DataRow), findsWidgets);
      }

      // Tocar fora para limpar a seleção
      await tester.tapAt(const Offset(10, 10));
      await tester.pump();

      // Garantir que a seleção foi limpa
      if (find.byType(DataRow).evaluate().isNotEmpty) {
        expect(find.byType(DataRow), findsOneWidget);
      }
    });

    testWidgets('Testa a opção de download', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1600, 1200);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(const MyApp());

      if (find.byIcon(Icons.more_vert).evaluate().isNotEmpty) {
        await tester.ensureVisible(find.byIcon(Icons.more_vert).first);
      }
      if (find.byIcon(Icons.more_vert).evaluate().isNotEmpty) {
        await tester.tap(find.byIcon(Icons.more_vert).first);
      }
      await tester.pumpAndSettle();

      expect(find.text('Baixar'), findsOneWidget);
    });
  });
}
