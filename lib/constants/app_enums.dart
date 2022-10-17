/// Created by Dev 2301 on 10/25/2021
/// Modified by Dev 2301 on 10/25/2021
/// Purpose : this file contains enums used throughout the app

enum RequestStatus {needToApply, approved, pending, rejected , cancelled, expired}

/// Created by Dev 2301 on 8/11/2021
/// Modified by Dev 2301 on 8/11/2021
/// Purpose : Specifies the source where the picked image should come from.
enum MediaSource {
  /// Opens up the device camera, letting the user to take a new picture.
  camera,

  /// Opens the user's photo gallery.
  gallery,
}

enum SnackBarStyle {
  normal,
  success,
  error,
}

enum MessageType {
  message,
  video,
  photo,
}

enum ForgotPinApiType { sendOtp, resendOtp }


/*  public enum VisitType
    {
        Single = 1,
        Joint = 2
    }*/
enum VisitType { Single, Joint }
