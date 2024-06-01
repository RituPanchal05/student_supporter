import 'package:flutter/material.dart';
import 'package:student_supporter/subjects/screens/subjects.dart';
import 'package:student_supporter/user/screens/homeScreen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 3;

  List<Widget> pages = [
    HomeScreen(
      startDate: '',
      endDate: '',
      subjectName: '',
      totalLects: '',
    ),
    SubjectScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the BottomNavigationBar
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12, // Shadow color
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3), // Offset for the shadow (horizontal, vertical)
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: Colors.purple, // Set selected icon color to purple
          unselectedItemColor: Colors.grey, // Set unselected icon color to grey
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconSize: 28,
          onTap: updatePage,
          items: [
            _buildBottomNavigationBarItem(
              image: 'Asset/homee.png',
              label: 'Home',
              index: 0,
            ),
            _buildBottomNavigationBarItem(
              image: 'Asset/list_subjects.png',
              label: 'Subjects',
              index: 1,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({IconData? icon, String? image, required String label, required int index}) {
    return BottomNavigationBarItem(
      icon: InkResponse(
        onTap: () {
          updatePage(index);
        },
        child: AnimatedScale(
          scale: _page == index ? 1.2 : 1.0,
          duration: Duration(milliseconds: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_page == index)
                Center(
                  child: icon != null
                      ? Icon(icon, color: _page == index ? Colors.pink : Colors.grey)
                      : Image.asset(
                          image!,
                          height: 22,
                          width: 22,
                          color: _page == index ? Colors.pink : Colors.grey,
                        ),
                )
              else
                icon != null
                    ? Icon(icon, color: _page == index ? Colors.pink : Colors.grey)
                    : Image.asset(
                        image!,
                        height: 22,
                        width: 22,
                        color: _page == index ? Colors.pink : Colors.grey,
                      ),
              SizedBox(height: 4), // Space between icon and text
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: _page == index ? Colors.pink : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      label: '',
    );
  }
}
