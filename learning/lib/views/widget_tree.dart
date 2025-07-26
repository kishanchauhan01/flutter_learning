import 'package:flutter/material.dart';
import 'package:learning/data/constants.dart';
import 'package:learning/data/notifiers.dart';
import 'package:learning/views/pages/home_page.dart';
import 'package:learning/views/pages/profile_page.dart';
import 'package:learning/views/pages/settings_page.dart';
import 'package:learning/views/widgets/navbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Widget> pages = [HomePage(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Appp"),
        centerTitle: true,
        actions: [
          IconButton(
            //dark and light mode
            onPressed: () async {
              isDarkModeNotifier.value = !isDarkModeNotifier.value;
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool(
                KConstants.themeModeKey,
                isDarkModeNotifier.value,
              );
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkModeNotifier,
              builder: (context, isDark, child) {
                return Icon(isDark ? Icons.light_mode : Icons.dark_mode);
              },
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                //pushReplacment can be also use but in that the page is replaced witht the current page in widget tree so we can't go back
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsPage(title: "Settings qwer");
                  },
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
