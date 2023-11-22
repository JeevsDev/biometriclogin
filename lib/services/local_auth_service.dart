import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> canAuthenticate() async => 
    await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try {
      if(!await canAuthenticate()) return false;

      return await _auth.authenticate(
        localizedReason: 'Authentication required for logging in.',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Biometric authentication required!',
            cancelButton: 'Cancel'
          ),
          IOSAuthMessages(
            cancelButton: 'Cancel'
          )
        ],
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        )
        
        
        );
    } catch(e) {
        debugPrint('Error $e');
        return false;
    }
  }
}