import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final Map user;
  final String profileImageUrl;

  UserDetailScreen({required this.user, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user['name']), backgroundColor: Color(0xFF2E7D32)),
      backgroundColor: Color(0xFFF5F5DC),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
            ),
            const SizedBox(height: 20),
            Text('Name: ${user['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Text('Email: ${user['email']}', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            Text('Phone: ${user['phone']}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            
          ],
        ),
      ),
    );
  }
}
