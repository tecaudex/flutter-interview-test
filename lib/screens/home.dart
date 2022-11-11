import 'package:flutter/material.dart';
import 'package:interview/data/user.dart';
import 'package:interview/data/mock_data.dart';
import 'package:interview/widgets/avatar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
    users = User.fromJsonToList(allData());
    // searchController.addListener(_filterList);
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    searchController.dispose();
  }

  _filterList(String query) {
    if (query.isEmpty) {
      setState(() {
        users = User.fromJsonToList(allData());
      });
    }
    final suggestions = users.where((user) {
      final fName = user.firstName.toLowerCase();
      final lName = user.lastName.toLowerCase();
      final role = user.role.toLowerCase();
      final email = user.email.toLowerCase();

      final input = query.toLowerCase();
      return fName.contains(input) ||
          lName.contains(input) ||
          role.contains(input) ||
          email.contains(input);
    }).toList();
    setState(() {
      users = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                focusNode: focusNode,
                autofocus: true,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
                onChanged: (query) {
                  _filterList(query);
                },
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final item = users[index];
                return ListTile(
                  leading: CircleAvatar(
                      child: Center(child: getUserAvatar(item.avatar))),
                  title: Text('${item.firstName}, ${item.lastName}'),
                  subtitle: Text(item.role),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var newUser = User(
              id: "b32ec56c-21bb-4b7b-a3a0-635b8bca1f9d",
              avatar: null,
              firstName: "James",
              lastName: "May",
              email: "ssaull1c@tripod.com",
              role: "Developer");
          users.add(newUser);
          setState(() {});
        },
        tooltip: 'Add new',
        child: Icon(Icons.add),
      ),
    );
  }
}
