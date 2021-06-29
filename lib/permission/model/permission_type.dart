/// 앱 권한 종류
enum PermissionType {
  /// Android: Calendar
  /// iOS: Calendar (Events)
  CALENDAR,

  /// Android: Camera
  /// iOS: Photos (Camera Roll and Camera)
  CAMERA,

  /// Android: Contacts
  /// iOS: AddressBook
  CONTACTS,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation (Always and WhenInUse)
  LOCATION,

  /// Android: None
  /// iOS: MPMediaLibrary
  MEDIA_LIBRARY,

  /// Android: Microphone
  /// iOS: Microphone
  MICROPHONE,

  /// Android: Phone
  /// iOS: Nothing
  PHONE,

  /// Android: Nothing
  /// iOS: Photos
  /// iOS 14+ read & write access level
  PHOTOS,

  /// Android: Nothing
  /// iOS: Reminders
  REMINDERS,

  /// Android: Body Sensors
  /// iOS: CoreMotion
  BODY_SENSORS,

  /// Android: Sms
  /// iOS: Nothing
  SMS,

  /// Android: Microphone
  /// iOS: Speech
  SPEECH,

  /// Android: External Storage
  /// iOS: Access to folders like `Documents` or `Downloads`.
  STORAGE,

  /// Android: Notification
  /// iOS: Notification
  NOTIFICATION,

  /// Android: Allows an application to access any geographic locations
  /// persisted in the user's shared collection.
  ACCESS_MEDIA_LOCATION,

  /// When running on Android Q and above: Activity Recognition
  /// When running on Android < Q: Nothing
  /// iOS: Nothing
  ACTIVITY_RECOGNITION,

  /// iOS 13 and above: The authorization state of Core Bluetooth manager.
  /// When running < iOS 13 or Android this is always allowed.
  BLUETOOTH,

  /// Android: Allow Drawing Top-Level View
  /// iOS: Nothing
  SYSTEM_ALERT_WINDOW,

  /// The unknown permission only used for return type, never requested
  UNKNOWN
}
