class Item {
  String name, title, description;

  Item(this.name, this.title, this.description);

  Item.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    title = map['title'];
    description = map['description'];
  }
}
