class Contact {
  late int id;
  late String name;
  late String contact;
  late String email;
  late String img;

  Contact({required this.id,required this.name, required this.contact, required this.email,required this.img});

  factory Contact.fromJson(Map<String, dynamic> parsedJson) {
    return new Contact(
        id: parsedJson['id'] ?? "",
        name: parsedJson['name'] ?? "",
        contact: parsedJson['contact'] ?? "",
        email: parsedJson['email'] ?? "",
        img: parsedJson['img'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "contact": this.contact,
      "email": this.email,
      "img": this.img,
    };
  }
}
