import 'package:flutter/material.dart';

@immutable
class AlertDialogModel<T> {
  final String title;
  final String message;
  final Map<String, T> buttons;
  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.buttons,
  });
}

extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle()),
          content: Text(message, style: const TextStyle()),
          actions: buttons.entries.map((button) {
            return TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                  button.value,
                );
              },
              child: Text(
                button.key,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
