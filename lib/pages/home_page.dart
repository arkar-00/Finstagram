import 'package:finstagram/pages/feed_page.dart';
import 'package:finstagram/pages/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  final List<Widget> _pages = [FeedPage(), ProfilePage()];

  void _onAddPhoto() {
    // TODO: Implement add photo functionality
  }

  void _onLogout() {
    // TODO: Implement logout functionality
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Finstagram", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo, color: Colors.white),
            onPressed: _onAddPhoto,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _onLogout,
          ),
        ],
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      onTap: _onPageChanged,
      selectedItemColor: Colors.red, // Active color
      unselectedItemColor: Colors.grey, // Inactive color
      items: const [
        BottomNavigationBarItem(label: "Feed", icon: Icon(Icons.feed)),
        BottomNavigationBarItem(
          label: "Profile",
          icon: Icon(Icons.account_box),
        ),
      ],
    );
  }
}
