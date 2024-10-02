import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Drive Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DriveCloneScreen(),
    );
  }
}

class DriveCloneScreen extends StatefulWidget {
  @override
  _DriveCloneScreenState createState() => _DriveCloneScreenState();
}

class _DriveCloneScreenState extends State<DriveCloneScreen> {
  String filter = 'Tipo';
  String searchQuery = '';
  bool isHovered = false;

  List<FileItem> files = [
    FileItem(name: 'Colab Notebooks - Algoritmos', owner: 'eu', date: '7 de mar. de 2024', size: '—'),
    FileItem(name: 'Roteiro Simplificado - Coerência', owner: 'eu', date: '25 de mai. de 2024', size: '3 KB'),
    FileItem(name: 'INTELIGÊNCIA ARTIFICIAL NA GAMIFI...', owner: 'eu', date: '6 de jun. de 2024', size: '370 KB'),
    // Adicione mais arquivos conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Icon(Icons.menu, color: Colors.black),
        title: Container(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Pesquisar no Drive',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[200],
              filled: true,
              prefixIcon: Icon(Icons.search, color: Colors.black),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          NavigationDrawer(),
          // Main content
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: filter,
                        items: <String>['Tipo', 'Pessoas', 'Modificação']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            filter = newValue!;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.sort),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey),
                Expanded(
                  child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      return FileItemWidget(file: files[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.grey[100],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.folder, color: Colors.blue),
            title: Text('Meu Drive', style: TextStyle(fontSize: 16)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.access_time, color: Colors.blue),
            title: Text('Recentes', style: TextStyle(fontSize: 16)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.blue),
            title: Text('Com estrela', style: TextStyle(fontSize: 16)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.blue),
            title: Text('Lixeira', style: TextStyle(fontSize: 16)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class FileItem {
  final String name;
  final String owner;
  final String date;
  final String size;

  FileItem({
    required this.name,
    required this.owner,
    required this.date,
    required this.size,
  });
}

class FileItemWidget extends StatefulWidget {
  final FileItem file;

  const FileItemWidget({Key? key, required this.file}) : super(key: key);

  @override
  _FileItemWidgetState createState() => _FileItemWidgetState();
}

class _FileItemWidgetState extends State<FileItemWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(widget.file.name, style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(
          'Proprietário: ${widget.file.owner}   Modificação: ${widget.file.date}',
          style: TextStyle(fontSize: 14),
        ),
        trailing: isHovered
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.download),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        )
            : Text(widget.file.size, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
