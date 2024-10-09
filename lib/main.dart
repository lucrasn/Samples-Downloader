import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samples Downloader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DriveCloneScreen(),
    );
  }
}

class DriveCloneScreen extends StatefulWidget {
  const DriveCloneScreen({super.key});

  @override
  _DriveCloneScreenState createState() => _DriveCloneScreenState();
}

class _DriveCloneScreenState extends State<DriveCloneScreen> {
  String searchQuery = '';

  List<int> selectedIndices = [];
  List<FileItem> files = [
    FileItem(
      name: 'METODOLOGIA CIENTÍFICA - GERAL - 2023-2',
      icon: Icons.insert_drive_file,
      modifiedDate: '07/10/2024',
      owner: 'eu',
    ),
    FileItem(
      name: 'Planilha de notas Veterinária - 2024-2',
      icon: Icons.insert_drive_file,
      modifiedDate: '06/10/2024',
      owner: 'eu',
    ),
    FileItem(
      name: 'Lista de exercício de N1 (Revisão da Prova)- 2024-2 (respostas)',
      icon: Icons.insert_drive_file,
      modifiedDate: '05/10/2024',
      owner: 'eu',
    ),
    FileItem(
      name: 'Planilha de notas Odontologia - 2024-2 - A',
      icon: Icons.insert_drive_file,
      modifiedDate: '04/10/2024',
      owner: 'eu',
    ),
    FileItem(
      name: 'Planilha de notas Odontologia - 2024-2 - B',
      icon: Icons.insert_drive_file,
      modifiedDate: '04/10/2024',
      owner: 'eu',
    ),
    FileItem(
      name: 'Horário Recursos Humanos 2024-1',
      icon: Icons.insert_drive_file,
      modifiedDate: '01/10/2024',
      owner: 'eu',
    ),
  ];

  // Filtra os arquivos com base na consulta de pesquisa
  List<FileItem> get filteredFiles {
    if (searchQuery.isEmpty) {
      return files;
    } else {
      return files
          .where((file) =>
          file.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  void _handleClickOutside() {
    setState(() {
      selectedIndices.clear(); // Limpa a seleção ao clicar fora da lista
    });
  }

  void _handleItemClick(int index, bool? selected) {
    setState(() {
      if (selected == true) {
        selectedIndices.add(index); // Adiciona item à seleção
      } else {
        selectedIndices.remove(index); // Remove item da seleção
      }
    });
  }

  // Função para renomear um arquivo
  void _renameItem(int index) {
    TextEditingController renameController = TextEditingController();
    renameController.text = files[index].name;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Renomear item'),
          content: TextField(
            controller: renameController,
            decoration: const InputDecoration(hintText: 'Novo nome'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Renomear'),
              onPressed: () {
                setState(() {
                  files[index].name = renameController.text; // Atualiza o nome do item
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(50), // Deixa o campo arredondado
            ),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Pesquisar amostras',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.black),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _handleClickOutside, // Limpa a seleção ao clicar fora da lista
        child: Column(
          children: [
            const Divider(height: 1, color: Colors.grey),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      width: constraints.maxWidth, // Força a tabela a ocupar toda a largura
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Nome')),
                          DataColumn(label: Text('Criado em')),
                          DataColumn(label: Text('Proprietário')),
                          DataColumn(label: Text('Opções')),
                        ],
                        rows: List<DataRow>.generate(
                          filteredFiles.length,
                              (index) => DataRow(
                            selected: selectedIndices.contains(index),
                            onSelectChanged: (selected) {
                              _handleItemClick(index, selected); // Seleciona ou desmarca o item clicado
                            },
                            cells: [
                              DataCell(Row(
                                children: [
                                  Icon(filteredFiles[index].icon, color: Colors.green),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      filteredFiles[index].name,
                                      overflow: TextOverflow.ellipsis, // Abreviação do nome do arquivo
                                    ),
                                  ),
                                ],
                              )),
                              DataCell(Text(filteredFiles[index].modifiedDate)),
                              DataCell(Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.grey[300],
                                    child: const Icon(Icons.person, color: Colors.white, size: 16),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(filteredFiles[index].owner),
                                ],
                              )),
                              DataCell(PopupMenuButton<String>(
                                icon: const Icon(Icons.more_vert), // Três pontinhos verticais
                                onSelected: (value) {
                                  if (value == 'Renomear') {
                                    _renameItem(index); // Chama a função de renomear
                                  }
                                  // Outras opções podem ser tratadas aqui
                                },
                                itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'Baixar',
                                    child: ListTile(
                                      leading: Icon(Icons.download),
                                      title: Text('Baixar'),
                                    ),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'Renomear',
                                    child: ListTile(
                                      leading: Icon(Icons.drive_file_rename_outline),
                                      title: Text('Renomear'),
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileItem {
  String name;
  final IconData icon;
  final String modifiedDate;
  final String owner;

  FileItem({
    required this.name,
    required this.icon,
    required this.modifiedDate,
    required this.owner,
  });
}