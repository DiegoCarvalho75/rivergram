import 'package:flutter/material.dart';

class EmptyContentsWithTextAnimationView extends StatelessWidget {
  final String text;

  const EmptyContentsWithTextAnimationView({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FittedBox(
            child: Container(
              padding: const EdgeInsets.all(24),
              width: MediaQuery.of(context).size.width,
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
                softWrap: true,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blueGrey[900],
            child: const Center(
              child: Text(
                'animation...',
                style: TextStyle(),
              ),
            ),
          ), //EmptyContentsAnimationView(),
        ),
      ],
    );
  }
}
