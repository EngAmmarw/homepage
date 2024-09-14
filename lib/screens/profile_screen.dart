import 'package:flutter/material.dart';

import '../widgets/profile_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/profile_picture.jpg'), // Replace with your image asset
            ),
            const SizedBox(height: 20),
            const ProfileField(label: 'Full Name', value: 'Tiana Saris'),
            const ProfileField(
                label: 'Email', value: 'Brooklynsimmons@gmail.com'),
            const ProfileField(label: 'Phone Number', value: '+1 3712 3789'),
            const ProfileField(
                label: 'Address',
                value: '711 Leavenworth Apt. # 47 San Francisco, CA 94109'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    // Implement Change Password functionality
                  },
                  child: const Text('Change Password'),
                ),
                TextButton(
                  onPressed: () {
                    // Implement Log Out functionality
                  },
                  child: const Text('Log Out'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
