class Exceptions implements Exception{


  @override
  String toString() {
    return 'User or Email already exists';
  }
}

class UnProcessEntity implements Exceptions{


  @override
  String toString() {
    return 'Missing Failed';
  }
}

class LoginFailed implements Exception{


  @override
  String toString() {
    return 'Credentials Rejected ! ';
  }
}


class RedirectionFound implements Exception {
  @override
  String toString() {
    return 'Redirection Found to many direct ';
  }
}



class ResourceNotFound implements Exception {
  String message;

  ResourceNotFound(this.message);

  @override
  String toString() {
    return 'Resource ${this.message} not found ';
  }

}

class NoInternetConnection implements Exceptions {


  @override
  String toString() {
    return 'No Internet Connection  . ';
  }
}

class PropertyIsRequired implements Exceptions {
  String property ;

  PropertyIsRequired(this.property);

  @override
  String toString() {
    return 'Property ${{property}} Is Required .. ';
  }
}
