import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'about_page.dart'; // Import AboutPage
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFB89B72), // Sepia theme color
        scaffoldBackgroundColor: Color(0xFFF8F3E7),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: 18.0,
            color: Color(0xFF4B3F30),
            fontFamily: 'Noto', // Custom font
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFB89B72),
          foregroundColor: Colors.white,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> data = [];
  int currentIndex = 0;
  double fontSize = 20.0; // Start at medium size (20)
  double minFontSize = 10.0; // Minimum size
  double maxFontSize = 30.0; // Maximum size
  String currentFont = 'Noto';

  final List<String> fontOptions = ['Noto', 'Noor', 'Amiri'];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    setState(() {
      data = json.decode(jsonString);
    });
  }

  void increaseFontSize() {
    setState(() {
      if (fontSize < maxFontSize) fontSize += 2.0;
    });
  }

  void decreaseFontSize() {
    setState(() {
      if (fontSize > minFontSize) fontSize -= 2.0;
    });
  }

  void changeFont(String font) {
    setState(() {
      currentFont = font;
    });
  }

  void nextPage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void previousPage() {
    if (currentIndex < data.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void navigateToPage(int index) {
    setState(() {
      currentIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("شرح قطرالندى"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color:
                    Color(0xFFB89B72), // Base color in case image fails to load
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 1, // Adjust opacity for the tint effect
                      child: Image.asset(
                        'assets/img/head_drawer.png', // Replace with your image path
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Privacy Policy'),
              onTap: () async {
                const url =
                    'https://quranichub.blogspot.com/p/qatar-al-nada-apps-policy.html'; // Replace with your URL
                if (await canLaunch(url)) {
                  await launch(
                      url); // This opens the browser with the privacy policy URL
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            Divider(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Change Font",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4B3F30),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: currentFont, // Current selected font
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    style: TextStyle(color: Color(0xFF4B3F30)),
                    underline: Container(
                      height: 2,
                      color: Color(0xFFB89B72),
                    ),
                    onChanged: (String? newFont) {
                      if (newFont != null) {
                        changeFont(newFont);
                        Navigator.pop(context); // Close the drawer
                      }
                    },
                    items: fontOptions
                        .map<DropdownMenuItem<String>>((String font) {
                      return DropdownMenuItem<String>(
                        value: font,
                        child: Text(
                          font,
                          style: TextStyle(fontFamily: font),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: decreaseFontSize,
                    icon: Icon(Icons.text_decrease, color: Colors.white),
                    label: Text(
                      "Decrease",
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB89B72), // Sepia color
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: increaseFontSize,
                    icon: Icon(Icons.text_increase, color: Colors.white),
                    label: Text(
                      "Increase",
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB89B72), // Sepia color
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFB89B72),
              ),
              child: Text(
                'Chapters',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Noto',
                ),
              ),
            ),
            ...data.asMap().entries.map((entry) {
              int index = entry.key;
              var item = entry.value;
              return ListTile(
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    item['title'],
                    style: TextStyle(fontSize: 18, fontFamily: 'Noto'),
                  ),
                ),
                onTap: () => navigateToPage(index),
              );
            }).toList(),
          ],
        ),
      ),
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx < 0) {
                  nextPage();
                } else if (details.velocity.pixelsPerSecond.dx > 0) {
                  previousPage();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 4,
                  color: Color(0xFFFDF8E4),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data[currentIndex]['title'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB89B72),
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl, // For Arabic
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                data[currentIndex]['content'],
                                style: TextStyle(
                                    fontSize: fontSize,
                                    color: Color(0xFF4B3F30),
                                    height: 2,
                                    fontFamily: currentFont),

                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl, // For Arabic
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: previousPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: currentIndex < data.length - 1
                    ? Color(0xFFB89B72)
                    : Colors.grey[400],
              ),
              child: Text(
                "‹", // Arrow for Arabic (Next)
                style: TextStyle(fontSize: 18),
              ),
            ),
            ElevatedButton(
              onPressed: nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    currentIndex > 0 ? Color(0xFFB89B72) : Colors.grey[400],
              ),
              child: Text(
                "›", // Arrow for Arabic (Previous)
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
