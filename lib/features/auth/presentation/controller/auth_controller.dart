import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:nuli_app/core/services/auth_service.dart';
import 'package:nuli_app/features/auth/data/repositories/auth_repository.dart';

class AuthController extends ChangeNotifier{
  final AuthService  _authService;
  final AuthRepository _authRepository;


  AuthController(this._authService, this._authRepository);

  User? _user;
  bool _isLoading = false;
  String? _error;
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _user == null;


  void setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }
  void setError(String? mess){
    _error = mess;
    notifyListeners();
  }

  Future<bool> signUpWithEmail(String email, String password, String name) async{
    try{
      setLoading(true);
      setError(null);
      final _userModel = await _authRepository. signUpWithEmail(
          email: email,
          password: password,
          displayName: name,
      );
      if (_userModel != null) {
        _user = FirebaseAuth.instance.currentUser;
      }
      return _userModel != null;

    } on FirebaseAuthException catch (e) {
      setError(e.message);
      return false;
    } catch (e) {
      setError('Đăng ký thất bại');
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> signInWithEmail(String email, String password,) async {
    try {
      setLoading(true);
      setError(null);
      _user = await _authService.signInWithEmail(
        email,
        password,
      );
      return _user != null;
    } on FirebaseAuthException catch (e) {
      setError(e.message);
      return false;
    } catch (e) {
      setError('Đã xảy ra lỗi không xác định');
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      setLoading(true);
      setError(null);
      _user = await _authService.signInWithGoogle();
      return _user != null;
    }
    on FirebaseException catch(e){
      setError(e.message);
      return false;
    } catch (e){
      setError('Lỗi đăng nhập bằng Google');
      return false;
    } finally{
       setLoading(false);
     }
    }

  Future<bool> resetPassword(String email) async {
    try {
      setLoading(true);
      setError(null);
      await _authService.resetPass(email);

      return true;
    }
    on FirebaseException catch(e){
      setError(e.message);
      return false;
    } catch (e){
      setError('Không thể gửi email đặt lại mật khẩu');
      return false;
    } finally{
      setLoading(false);
    }
  }

  Future<void> signOut() async {
    setLoading(true);
    await _authService.signOut();
    _user = null;
    setLoading(false);
   }
  }


