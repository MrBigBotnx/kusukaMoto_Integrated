class AuthService {
  Future<bool> login(String email, String password) async {
    return email == 'daiwenxuam78@gmail.com' && password == '123456';
  }
}
