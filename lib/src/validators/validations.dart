class Validations {
  static bool isValidUser(String user) {
    return user != null && user.length > 4;
  }

  static bool isValidPass(String pass) {
    return pass != null && pass.length > 6;
  }
}