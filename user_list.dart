import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_detail.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List users = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        setState(() {
          users = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List'), backgroundColor: Color(0xFF2E7D32)),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(child: Text('Failed to load users'))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    String profileImageUrl = 'https://i.pravatar.cc/150?img=${index + 1}';
                    return ListTile(
                      tileColor: index.isEven ? Color(0xFFA5D6A7) : Color(0xFFF5F5DC),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(profileImageUrl),
                        backgroundColor: Colors.grey[200],
                      ),
                      title: Text(users[index]['name']),
                      subtitle: Text(users[index]['email']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailScreen(user: users[index], profileImageUrl: profileImageUrl),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
