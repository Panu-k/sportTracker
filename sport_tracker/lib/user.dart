class User {
  String username;
  String email;
  String name;
  int idUser;

  User(this.idUser, this.name, this.email, this.username);

  void clearUserInfo() {
    User(-1, "", "", "");
  }

  User getUserInfo() {
    return User(idUser, name, email, username);
  }

  int getUserID() {
    return idUser;
  }
}
