class User {
  final String name;
  final String lastName;
  final String province;
  List<String>? phoneNumbers;

  List<String>? documentFiles;
  String id ;

  User(this.name, this.lastName, this.province, this.phoneNumbers,
      this.documentFiles,this.id);
}
