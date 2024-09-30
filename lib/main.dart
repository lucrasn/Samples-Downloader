import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samples Downloader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DriveHomePage(),
    );
  }
}

class DriveHomePage extends StatelessWidget {
  final List<Map<String, dynamic>> files = [
    {'name': 'Classroom', 'type': 'folder'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Samples Downloader'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.view_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Google Drive Clone',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: Text('Pessoal'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('Atividades'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Com estrela'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Lixeira'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: DriveFileList(files: files),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class DriveFileList extends StatelessWidget {
  final List<Map<String, dynamic>> files;

  DriveFileList({required this.files});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemCount: files.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final file = files[index];
        return ListTile(
          leading: file['type'] == 'folder'
              ? Icon(Icons.folder, color: Colors.blue)
              : Icon(Icons.insert_drive_file, color: Colors.grey),
          title: Text(file['name']),
          subtitle: file['type'] == 'file' ? Text(file['size']) : null,
          trailing: Icon(Icons.more_vert),
          onTap: () {},
        );
      },
    );
  }
}
