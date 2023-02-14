import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

class FontsList2 extends StatefulWidget {
  const FontsList2({super.key});

  @override
  State<FontsList2> createState() => _FontsList2State();
}

class _FontsList2State extends State<FontsList2> {
  String? currentFont;

  @override
  Widget build(BuildContext context) {
    var googleFontsList2 = {...GoogleFonts.asMap()};
    String searchTerm = 'mono';

    if (searchTerm.isNotEmpty) {
      googleFontsList2.removeWhere((key, value) =>
          !key.toUpperCase().contains(searchTerm.toUpperCase()));
    }

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Search for a Google Font"),
              cursorColor: Colors.white70,
              cursorWidth: 2,
              style: TextStyle(fontSize: 24, fontFamily: buttonFontFamily),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Results ${googleFontsList2.length}")),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: googleFontsList2.length,
              itemBuilder: (context, index) {
                currentFont =
                    googleFontsList2.values.elementAt(index).call().fontFamily;

                return Row(
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
                            '${googleFontsList2.keys.elementAt(index)}',
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
                    const Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
