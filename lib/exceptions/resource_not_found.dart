class ResourceNotFound implements Exception {
  String message;

  ResourceNotFound(this.message);

  @override
  String toString() {
    return 'Resource ${this.message} not found ';
  }
}
