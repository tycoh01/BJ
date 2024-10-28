mport 'package:flutter/material.dart';

class JournalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JournalHomePage(),
    );
  }
}

class JournalHomePage extends StatefulWidget {
  @override
  _JournalHomePageState createState() => _JournalHomePageState();
}

class _JournalHomePageState extends State<JournalHomePage> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<JournalPage> pages = [];

  @override
  void initState() {
    super.initState();
    _loadPages();
  }

  void _loadPages() async {
    final loadedPages = await dbHelper.getJournalPages();
    setState(() {
      pages = loadedPages;
    });
  }

  void _addNewPage(String title) async {
    final newPage = JournalPage(id: pages.length + 1, title: title, createdDate: DateTime.now());
    await dbHelper.insertJournalPage(newPage);
    _loadPages();
  }

  void _navigateToPage(JournalPage page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JournalPageDetail(page: page),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bullet Journal')),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pages[index].title),
            onTap: () => _navigateToPage(pages[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPageDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddPageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String pageTitle = '';
        return AlertDialog(
          title: Text('Add New Page'),
          content: TextField(
            onChanged: (value) => pageTitle = value,
            decoration: InputDecoration(labelText: 'Page Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addNewPage(pageTitle);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class JournalPageDetail extends StatelessWidget {
  final JournalPage page;

  JournalPageDetail({required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(page.title)),
      body: Center(
        child: Text('Details for ${page.title}'),
      ),
    );
  }
}

