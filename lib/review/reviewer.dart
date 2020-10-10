class Reviewer {
  String first_name, last_name, email, formattedName;

  Reviewer(this.first_name, this.last_name, this.email, this.formattedName);


  Reviewer.fromJson(Map<String, dynamic> jsonObject) {
    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.email = jsonObject['email'];
    this.formattedName = jsonObject['formattedName'];
  }
}
