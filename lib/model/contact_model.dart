class ContactModel {
  String id;
  String name;
  String email;
  String phone;
  String address;

  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
        id: json['_id']??'',
        name: json['name']??'',
        email: json['email']??'',
        phone: json['phone'].toString(),
        address: json['address']??'');
  }
}
