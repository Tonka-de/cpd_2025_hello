import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

/// Hardcoded username
final String hardcodedUsername = "admin";

/// Hardcoded password
final String hardcodedPassword = "password123";

/// A function to write hardcoded credentials to secure storage if they dont exist.
Future<void> writeCredentialsIfNotExists() async {
  String? storedUsername = await storage.read(key: 'username');
  String? storedPassword = await storage.read(key: 'password');

  if (storedUsername == null && storedPassword == null) {
    await storage.write(key: 'username', value: hardcodedUsername);
    await storage.write(key: 'password', value: hardcodedPassword);
  }
}

/// A class representing user credentials.
/// It contains a username and a password.
class Credentials {
  final String username;
  final String password;

  Credentials({required this.username, required this.password});
}

/// A function to read the stored credentials from secure storage.
///
/// This function first checks if the credentials are already stored.
/// If not, it writes the hardcoded credentials to secure storage.
/// It then retrieves the username and password from secure storage.
///
/// Returns a [Credentials] object containing the username and password.
/// If the credentials are not found, it returns an empty string for both username and password.
Future<Credentials> readCredentials() async {
  await writeCredentialsIfNotExists();

  String? username = await storage.read(key: 'username');
  String? password = await storage.read(key: 'password');

  var credentials = Credentials(
    username: username ?? '',
    password: password ?? '',
  );
  return credentials;
}
