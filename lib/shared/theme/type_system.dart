import 'package:flutter/material.dart';

class TypeSystem extends StatelessWidget {
  const TypeSystem({Key? key}) : super(key: key);
  static const padding = 8.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 1,
              child: FittedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Text("headline 1",
                          style: Theme.of(context).textTheme.headline1),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Text("headline 2",
                          style: Theme.of(context).textTheme.headline2),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Text("headline 3",
                          style: Theme.of(context).textTheme.headline3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Text("headline 4",
                          style: Theme.of(context).textTheme.headline4),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Text("headline 5",
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Text("headline 6",
                          style: Theme.of(context).textTheme.headline6),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Text("titleLarge",
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Text("titleMedium",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Text("titleSmall",
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Text("subtitle1",
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Text("subtitle2",
                        style: Theme.of(context).textTheme.subtitle2),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Text(
                        " bodyLarge Nostrud laborum ipsum enim esse aute consequat magna nisi officia culpa. Eiusmod qui occaecat consectetur aliqua in id magna nulla",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Text(
                        "bodyMedium Nostrud laborum ipsum enim esse aute consequat magna nisi officia culpa. Eiusmod qui occaecat consectetur aliqua in id magna nulla",
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Text(
                        "bodySmall Nostrud laborum ipsum enim esse aute consequat magna nisi officia culpa. Eiusmod qui occaecat consectetur aliqua in id magna nulla",
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Text("button ",
                        style: Theme.of(context).textTheme.button),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Text("caption",
                        style: Theme.of(context).textTheme.caption),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Text("overline",
                        style: Theme.of(context).textTheme.overline),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: FittedBox(
                      child: Row(
                        // mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 110,
                            // constraints:
                            //     BoxConstraints(maxWidth: 110, minWidth: 110),
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text("CANCEL"),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Container(
                            width: 110,
                            // constraints:
                            //     BoxConstraints(maxWidth: 110, minWidth: 110),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("OK !!!"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
