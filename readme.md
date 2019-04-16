# flutter_biopass

Store a password behind biometric authentication.

This is a microlibrary for storing a password in the keychain, instructing the keychain to only give it back if the user first authenticates with TouchID or FaceID.

**note:** Android is currently unsupported, I hope to implement this soon.

**note:** On iOS, in order for your user not to receive a prompt that your app does not yet support Face ID, you must set a value for the Privacy - Face ID Usage Description (NSFaceIDUsageDescription) key in your app’s Info.plist.

## Usage

```dart
import 'package:flutter_biopass/flutter_biopass.dart' show BioPass;

final bioPass = BioPass();

// When the user signs up or logs in for the first time, store the password in the keychain:
await bioPass.store('P@ssw0rd');

// When asking the user to log in, first try retreiving the saved password which will, if a password is stored, trigger a biometric authentication prompt:
// If `result` is `null`, then either the user cancelled the authenticaiton, or there was no password saved.
final result = await bioPass.retreive(withPrompt: 'Example prompt text...');

// When the user manually logs out, delete the stored password from the keychain:
await bioPass.delete();
```
