import 'package:flutter/foundation.dart';

import '../constants/components_strings.dart';
import 'alert_dialog_model.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
          title: ComponentsStrings.logOut,
          message: ComponentsStrings.areYouSureThatYouWantToLogOutOfTheApp,
          buttons: const {
            ComponentsStrings.cancel: false,
            ComponentsStrings.logOut: true,
          },
        );
}
