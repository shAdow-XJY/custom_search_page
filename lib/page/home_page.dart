import 'package:custom_search_page/page/custom_search_bar.dart';
import 'package:custom_search_page/page/setting_dialog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SettingDialog();
                      },
                    );
                  },
                ),
              ],
            ),
            CustomSearchBar(),
          ],
        ),
      ),
    );
  }

}
