import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_tutor/views/loginscreen.dart';
import '../models/user.dart';
import '../constants.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentSelected = 0;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    index == 5
    ? _drawerKey.currentState?.openDrawer()
    : setState((){
        _currentSelected = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    
     return Scaffold(
      appBar: AppBar(
        title: const Text('My Dashboard'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _currentSelected,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.lightBlue,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('images/icons/subject.png'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/icons/tutor.png'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/icons/favourite.png'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/icons/subscribe.png'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/icons/profile.png'),
          ),
        ]
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.name.toString()),
              accountEmail: Text(widget.user.email.toString()),
              currentAccountPicture:  SingleChildScrollView(
                child: SizedBox(                 
                  child: CachedNetworkImage(
                                        imageUrl: CONSTANTS.server +
                                            "/my_tutor/mobile/assets/user/" +
                                            widget.user.phoneNum.toString() +
                                            '.png', 
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const LinearProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                ),
              ),
            ),

            
            
            _createDrawerItem(
              icon: Icons.tv,
              text: 'My Dashboard',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(
                              user: widget.user,
                            )));
              },
            ),
            _createDrawerItem(
              icon: Icons.list_alt,
              text: 'My Profile',
              onTap: () {
              },
            ),
            _createDrawerItem(
              icon: Icons.verified_user,
              text: 'My Tutor',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Logout',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to My Tutor'),
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
    
  }
  
}
