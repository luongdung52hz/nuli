import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/services/auth_service.dart';
import '../models/user_model.dart';
import '../models/user_role.dart';
import '../repositories/user_repository.dart';

class AuthRepository {
  final AuthService _authService;
  final UserRepository _userRepository;

  AuthRepository(
      this._authService,
      this._userRepository,
      );

  Future<UserModel?> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    // Firebase Auth
    final firebaseUser = await _authService.signUpWithEmail(
      email,
      password,
      displayName,
    );

    if (firebaseUser == null) return null;

    // Create UserModel
    final userModel = UserModel(
      id: firebaseUser.uid,
      email: email,
      displayName: displayName,
      role: UserRole.user,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
    // Save Firestore
    await _userRepository.createUser(userModel);
    return userModel;
  }

  Future<UserModel?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final firebaseUser =
    await _authService.signInWithEmail(email, password);

    if (firebaseUser == null) return null;

    return await _userRepository.getUserById(firebaseUser.uid);
  }

  Future<UserModel?> signInWithGoogle() async {
    final firebaseUser = await _authService.signInWithGoogle();
    if (firebaseUser == null) return null;

    // Check Firestore
    final existingUser =
    await _userRepository.getUserById(firebaseUser.uid);

    if (existingUser != null) {
      return existingUser;
    }

    // Create new user if not exists
    final newUser = UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName:
      firebaseUser.displayName ?? 'Google User',
      role: UserRole.user,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    await _userRepository.createUser(newUser);
    return newUser;
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
