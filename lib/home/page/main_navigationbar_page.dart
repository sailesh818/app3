import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/home/page/form_page.dart';
import 'package:flutter_application_3/home/page/home_page.dart';
import 'package:flutter_application_3/home/page/offline_poem.dart';
import 'package:flutter_application_3/home/page/read_poem_page.dart';
import 'package:flutter_application_3/login/pages/login_page.dart';

class MainNavigationbarPage extends StatefulWidget {
  const MainNavigationbarPage({super.key});

  @override
  State<MainNavigationbarPage> createState() => _MainNavigationbarPageState();
}

class _MainNavigationbarPageState extends State<MainNavigationbarPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    OfflinePoem(),
    ReadPoemPage(),
    FormPage()
  ];

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    if(mounted){
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (context) => LoginPage()), 
        (route) => false
        
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  

  
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;


    return Scaffold(
      appBar: AppBar(
        title: Text("Poem App"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Welcome Sailesh"), 
              accountEmail: Text(user?.email ?? "Guest"),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),

            ListTile(
              leading: Icon(Icons.offline_bolt_rounded),
              title: Text("Offline"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),

            ListTile(
              leading: Icon(Icons.menu),
              title: Text("Read"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),

            ListTile(
              leading: Icon(Icons.offline_pin),
              title: Text("Form"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 3;
                });
              },
            ),

            Divider(),

            user == null
            ? ListTile(
              leading: Icon(Icons.login),
              title: Text("Login"),
              onTap: (){
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginPage())
                  
                );
              },
            )
            : ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: logout,
            )


          ],
        ),
      ),

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,

        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.offline_bolt_rounded),
            label: "Offline",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Read",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.offline_pin),
            label: "Form",
          )


        ],
      )
    );
  }
}