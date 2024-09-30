import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samples_downloader/main.dart';

void main() {
  // Testa se o título da AppBar está correto
  testWidgets('AppBar title is displayed correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Samples Downloader'), findsOneWidget);
  });

  // Testa se o Drawer é aberto ao clicar no ícone de menu
  testWidgets('Drawer opens when menu button is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle(); // Espera a animação do Drawer

    // Verifica se o item 'Pessoal' está visível
    expect(find.text('Pessoal'), findsOneWidget);
    expect(find.text('Atividades'), findsOneWidget);
  });

  // Testa se a lista de arquivos está sendo exibida
  testWidgets('File list is displayed correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verifica a presença dos arquivos/pastas
    expect(find.text('Classroom'), findsOneWidget);
  });

  // Testa se o FloatingActionButton está presente e clicável
  testWidgets('FloatingActionButton can be tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verifica se o botão de ação flutuante está presente
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // Simula um toque no FloatingActionButton
    await tester.tap(find.byType(FloatingActionButton));
    // Adicionar aqui as verificações adicionais para quando o botão for clicado
  });

  // Testa se o ícone de mais opções aparece para cada item na lista de arquivos
  testWidgets('More options icon is present for each file', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verifica se o ícone de mais opções (três pontos) está presente para todos os arquivos
    expect(find.byIcon(Icons.more_vert), findsNWidgets(1)); // Deve haver 1 itens com esse ícone
  });
}
