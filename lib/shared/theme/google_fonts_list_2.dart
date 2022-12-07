import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rivergram/shared/theme/theme.dart';

class FontsList2 extends StatefulWidget {
  const FontsList2({super.key});

  @override
  State<FontsList2> createState() => _FontsList2State();
}

class _FontsList2State extends State<FontsList2> {
  String? currentFont;

  @override
  Widget build(BuildContext context) {
    var _googleFontsList2 = {...GoogleFonts.asMap()};
    String searchTerm = 'mono';

    if (searchTerm.isNotEmpty) {
      _googleFontsList2.removeWhere((key, value) =>
          !key.toUpperCase().contains(searchTerm.toUpperCase()));
    }

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Search for a Google Font"),
              cursorColor: Colors.white70,
              cursorWidth: 2,
              style: TextStyle(fontSize: 24, fontFamily: buttonFontFamily),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Center(child: Text("Results ${_googleFontsList2.length}")),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _googleFontsList2.length,
              itemBuilder: (context, index) {
                currentFont =
                    _googleFontsList2.values.elementAt(index).call().fontFamily;

                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              '${_googleFontsList2.keys.elementAt(index)}',
                              style: TextStyle(
                                fontFamily: currentFont,
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'In cupidatat duis nulla excepteur cillum dolor proident tempor eu ullamco aliquip. Mollit magna cupidatat minim ad laboris cillum qui officia elit. Ut veniam dolor adipisicing excepteur ullamco anim nostrud proident ad irure. Fugiat do officia quis ad qui ut commodo aliqua in. Deserunt eu ea et non eiusmod adipisicing ullamco adipisicing minim adipisicing deserunt ipsum dolore non.',
                            style: TextStyle(
                              fontFamily: currentFont,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
