import 'package:flutter/material.dart';
import 'package:rivergram/views/components/constants/components_strings.dart';
import 'package:rivergram/views/components/dialogs/alert_dialog_model.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  // final String titleOfObjectToDelete;
  const DeleteDialog({
    required String titleOfObjectToDelete,
  }) : super(
          title: '${ComponentsStrings.delete} ${titleOfObjectToDelete}?',
          message:
              '${ComponentsStrings.areYouSureYouWantToDeleteThis} ${titleOfObjectToDelete}?',
          buttons: const {
            'Cancel': false,
            'Delete': true,
          },
        );
}
