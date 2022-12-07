import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontsList extends StatefulWidget {
  const FontsList({super.key});

  @override
  State<FontsList> createState() => _FontsListState();
}

class _FontsListState extends State<FontsList> {
  final _googleFontsList = GoogleFonts.asMap();
  var _selectedFontIndex = 0;
  String? currentFont;

  @override
  Widget build(BuildContext context) {
    currentFont =
        _googleFontsList.values.elementAt(_selectedFontIndex).call().fontFamily;

    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: _googleFontsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: index == _selectedFontIndex
                      ? Colors.black
                      : Colors.red.shade900.withOpacity(0.7),
                  selected: index == _selectedFontIndex,
                  selectedColor: Colors.white,
                  onTap: () {
                    setState(() {
                      _selectedFontIndex = index;
                    });
                  },
                  hoverColor: Colors.black.withOpacity(1),
                  title: Text('${_googleFontsList.keys.elementAt(index)}'),
                );
              },
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.all(24),
                color: Colors.black.withOpacity(0.5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '${_googleFontsList.keys.elementAt(_selectedFontIndex)}',
                          style: TextStyle(
                              fontFamily: currentFont,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Non occaecat duis in aute magna qui consectetur incididunt magna. Non deserunt nisi anim ut duis minim eu laboris. Officia incididunt exercitation ea aliqua irure elit. Irure laborum aliquip irure aliquip dolor est laboris nisi. Lorem mollit sint consectetur ad laboris deserunt aliqua occaecat occaecat cupidatat cupidatat esse qui pariatur.',
                          style:
                              TextStyle(fontFamily: currentFont, fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
