class User{
  late String displayName;
  late String email;
  late String password;
  late String serverName; //server where user info is stored

  User({
    required this.displayName,
    required this.email,
    required this.password,
    required this.serverName,
  });

  String getDisplayName(){
    return displayName;
  }

  void setDisplayName(String displayName){
    this.displayName = displayName;
  }

  String getEmail(){
    return email;
  }
  
  void setEmail(String email){
    this.email = email;
  }

  String getPassword(){
    return password;
  }

  void setPassword(String password){
    this.password = password;
  }

  String getServerName(){
    return serverName;
  }

  void setServerName(String serverName){
    this.serverName = serverName;
  }

  

}