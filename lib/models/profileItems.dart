
class profileItem {
  String id;
  String name;
  String lastname;
  String company;

  profileItem({required this.id, required this.name, required this.lastname, required this.company});

  factory profileItem.fromMap(Map<String, dynamic> map, String id) {
    return profileItem(
      id: id,
      name: map['name'] as String,
      lastname: map['lastname'] as String,
      company: map['company'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastname': lastname,
      'company': company,
    };
  }
}