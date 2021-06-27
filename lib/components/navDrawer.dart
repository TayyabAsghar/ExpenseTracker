import 'package:flutter/material.dart';
import '../components/userData.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key, required this.userData}) : super(key: key);
  final _fontSize = 16.0;
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    final _currentRoute = ModalRoute.of(context)!.settings.name;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 190,
          child: DrawerHeader(
            margin: EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: FadeInImage(
                    image: NetworkImage(
                      'https://source.unsplash.com/300x300/?fire,green,forest',
                    ),
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    placeholder: AssetImage('assets/images/logo.png'),
                    imageErrorBuilder: (_, __, ___) => CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Muhammad Tayyab Asghar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
                Text(
                  'muhammadtayybasghar@gmail.com',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
        ),
        ListTile(
          leading: Icon(Icons.calculate),
          title: Text(
            'Prime or Composite',
            style: TextStyle(
              fontSize: _fontSize,
              color: _currentRoute == '/'
                  ? Theme.of(context).primaryColor
                  : Colors.grey[600],
            ),
          ),
          selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.3),
          selected: _currentRoute == '/',
          onTap: () => Navigator.popUntil(context, ModalRoute.withName('/')),
        ),
        ListTile(
          leading: Icon(Icons.collections),
          title: Text(
            'Image Collection',
            style: TextStyle(
              fontSize: _fontSize,
              color: _currentRoute == '/collection'
                  ? Theme.of(context).primaryColor
                  : Colors.grey[600],
            ),
          ),
          selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.3),
          selected: _currentRoute == '/collection',
          onTap: () {
            Navigator.pop(context);

            if (_currentRoute != '/collection')
              Navigator.pushNamed(context, '/collection');

            //Navigator.pushReplacementNamed(context, '/collection');
          },
        ),
        ListTile(
          leading: Icon(Icons.receipt_long_outlined),
          title: Text(
            'Transaction',
            style: TextStyle(
              fontSize: _fontSize,
              color: _currentRoute == '/transaction'
                  ? Theme.of(context).primaryColor
                  : Colors.grey[600],
            ),
          ),
          selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.3),
          selected: _currentRoute == '/transaction',
          onTap: () {
            Navigator.pop(context);

            if (_currentRoute != '/transaction')
              Navigator.pushNamed(context, '/transaction');
          },
        ),
      ],
    );
  }
}
