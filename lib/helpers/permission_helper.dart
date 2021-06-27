import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestPermission() async {
    bool granted = true;
    final Map<Permission, PermissionStatus> statuses = await <Permission>[
      Permission.location,
      Permission.sms,
      Permission.contacts,
      Permission.storage,
      Permission.phone,

      //add more permission to request here.
    ].request();

    if (statuses[Permission.location]!.isDenied) {
      //check each permission status after.
      granted = false;
      print('Location permission is denied.');
    }

    if (statuses[Permission.sms]!.isDenied) {
      //check each permission status after.
      granted = false;
      print('SMS permission is denied.');
    }

    if (statuses[Permission.contacts]!.isDenied) {
      //check each permission status after.
      granted = false;
      print('Contact permission is denied.');
    }
    if (statuses[Permission.storage]!.isDenied) {
      //check each permission status after.
      granted = false;
      print('Storage permission is denied.');
    }

    if (statuses[Permission.phone]!.isDenied) {
      //check each permission status after.
      granted = false;
      print('Phone permission is denied.');
    }
    return granted;
  }
}
