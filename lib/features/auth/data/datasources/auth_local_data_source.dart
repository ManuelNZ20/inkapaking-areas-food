import '../../../../core/core.dart';

/// Interface for the local authentication data source.
/// Handles operations related to local data storage using Isar.
abstract class AuthLocalDataSource {
  /// Saves the authenticated user locally.
  ///
  /// [user] The user model to be saved.
  ///
  /// Returns a [Future] that completes when the operation is done.
  ///
  /// Throws a [DatabaseException] if there is an error during the save operation.
  Future<void> saveCurrentUser(UserModel user);

  /// Retrieves the locally stored authenticated user.
  ///
  /// Returns a [Future] that completes with the [UserModel] if found, or null if no user is stored.
  ///
  /// Throws a [DatabaseException] if there is an error during the retrieval operation.
  Future<UserModel?> getCurrentUser();

  /// Deletes the locally stored authenticated user data.
  ///
  /// Returns a [Future] that completes when the operation is done.
  ///
  /// Throws a [DatabaseException] if there is an error during the delete operation.
  Future<void> deleteCurrentUser();

  /// Checks if there is a locally stored authenticated user.
  ///
  /// Returns a [Future] that completes with a boolean indicating whether a user is stored.
  ///
  /// Throws a [DatabaseException] if there is an error during the check operation.
  Future<bool> hasUser();

  /// Saves the authentication token locally.
  ///
  /// [token] The authentication token to be saved.
  ///
  /// Returns a [Future] that completes when the operation is done.
  ///
  /// Throws a [DatabaseException] if there is an error during the save operation.
  Future<void> saveAuthToken(String token);

  /// Retrieves the locally stored authentication token.
  ///
  /// Returns a [Future] that completes with the token if found, or null if no token is stored.
  ///
  /// Throws a [DatabaseException] if there is an error during the retrieval operation.
  Future<String?> getAuthToken();

  /// Deletes the locally stored authentication token.
  ///
  /// Returns a [Future] that completes when the operation is done.
  ///
  /// Throws a [DatabaseException] if there is an error during the delete operation.
  Future<void> deleteAuthToken();

  /// Saves a user state locally.
  ///
  /// [key] The key identifying the state.
  /// [value] The value of the state to be saved.
  ///
  /// Returns a [Future] that completes when the operation is done.
  ///
  /// Throws a [DatabaseException] if there is an error during the save operation.
  Future<void> saveUserState(String key, dynamic value);

  /// Retrieves a locally stored user state.
  ///
  /// [key] The key identifying the state.
  ///
  /// Returns a [Future] that completes with the value of the state if found, or null if no state is stored.
  ///
  /// Throws a [DatabaseException] if there is an error during the retrieval operation.
  Future<dynamic> getUserState(String key);
}
