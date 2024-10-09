import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples_downloader/main.dart';

void main() {
  testWidgets('Testa a funcionalidade de renomear um item', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(const MyApp());

    // Verifique se os arquivos iniciais são exibidos.
    expect(find.text('METODOLOGIA CIENTÍFICA - GERAL - 2023-2'), findsOneWidget);
    expect(find.text('Planilha de notas Veterinária - 2024-2'), findsOneWidget);

    // Encontre o botão de mais opções (três pontinhos).
    final moreOptionsFinder = find.byIcon(Icons.more_vert).first;

    // Clica no botão de opções.
    await tester.tap(moreOptionsFinder);
    await tester.pump(); // Atualiza a interface após o clique.

    // Verifica se a opção "Renomear" aparece no menu.
    expect(find.text('Renomear'), findsOneWidget);

    // Clica na opção "Renomear".
    await tester.tap(find.text('Renomear'));
    await tester.pump(); // Atualiza a interface após o clique.

    // Verifica se o diálogo de renomear aparece.
    expect(find.text('Renomear item'), findsOneWidget);
    expect(find.text('Novo nome'), findsOneWidget);

    // Preenche o novo nome no campo de texto.
    await tester.enterText(find.byType(TextField), 'Novo Nome Teste');
    await tester.pump(); // Atualiza a interface.

    // Clica no botão "Renomear" do diálogo.
    await tester.tap(find.text('Renomear'));
    await tester.pump(); // Atualiza a interface.

    // Verifica se o nome foi alterado na lista.
    expect(find.text('Novo Nome Teste'), findsOneWidget);
    expect(find.text('METODOLOGIA CIENTÍFICA - GERAL - 2023-2'), findsNothing);
  });

  testWidgets('Testa a funcionalidade de pesquisa', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(const MyApp());

    // Verifica se o campo de pesquisa está presente.
    expect(find.byType(TextField), findsOneWidget);

    // Digite algo no campo de pesquisa para filtrar.
    await tester.enterText(find.byType(TextField), 'Planilha de notas Veterinária');
    await tester.pump(); // Atualiza a interface após a entrada de texto.

    // Verifique se apenas o item filtrado é exibido.
    expect(find.text('Planilha de notas Veterinária - 2024-2'), findsOneWidget);
    expect(find.text('METODOLOGIA CIENTÍFICA - GERAL - 2023-2'), findsNothing);

    // Limpe a pesquisa.
    await tester.enterText(find.byType(TextField), '');
    await tester.pump(); // Atualiza a interface após limpar o texto.

    // Verifique se todos os itens voltam a aparecer.
    expect(find.text('METODOLOGIA CIENTÍFICA - GERAL - 2023-2'), findsOneWidget);
    expect(find.text('Planilha de notas Veterinária - 2024-2'), findsOneWidget);
  });

  testWidgets('Verifica se o botão de download aparece nas opções', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(const MyApp());

    // Encontre o botão de mais opções (três pontinhos).
    final moreOptionsFinder = find.byIcon(Icons.more_vert).first;

    // Clica no botão de opções.
    await tester.tap(moreOptionsFinder);
    await tester.pump(); // Atualiza a interface após o clique.

    // Verifica se a opção "Baixar" está presente.
    expect(find.text('Baixar'), findsOneWidget);
  });
}