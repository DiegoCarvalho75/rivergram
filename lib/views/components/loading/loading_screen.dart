import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/strings.dart';
import 'loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();

  static final LoadingScreen _shared = LoadingScreen._sharedInstance();

  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void hide() {
    _controller?.close();
    _controller = null;
  }

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  LoadingScreenController? showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final overlayState = Overlay.of(context);
    if (overlayState == null) {
      return null;
    }
    final streamTextController = StreamController<String>();
    streamTextController.add(text);

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    // Same result as renderBox aprouch
    // final mq = MediaQuery.of(context).size;

    final overlayEntry = OverlayEntry(
      builder: (context) {
        var color = Theme.of(context).colorScheme.tertiaryContainer;
        return Material(
          color: color.withOpacity(0.8),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                minWidth: size.width * 0.5,
                maxHeight: size.height * 0.8,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      CircularProgressIndicator(),
                      SizedBox(height: 8),
                      StreamBuilder<String>(
                        stream: streamTextController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.requireData,
                              style: TextStyle(),
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);

    return LoadingScreenController(
      close: () {
        streamTextController.close();
        overlayEntry.remove();
        return true;
      },
      update: (text) {
        streamTextController.add(text);
        return true;
      },
    );
  }
}
