class SessionController{
  static final SessionController _session=SessionController.internal();
  String? userId;

  factory SessionController(){
    return _session;
  }
  
  SessionController.internal() {

  }

}