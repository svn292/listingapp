class CategoryItem {
  String id;
  String parent;
  String iconClass;
  String iconUnicode;
  String name;
  String slug;
  String thumbnail;

  CategoryItem({this.id, this.parent, this.iconClass, this.iconUnicode, this.name, this.slug, this.thumbnail});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    iconClass = json['icon_class'];
    name = json['name'];
    slug = json['slug'];
    thumbnail = json['thumbnail'];
    iconUnicode = json['icon_unicode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent'] = this.parent;
    data['icon_class'] = this.iconClass;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['thumbnail'] = this.thumbnail;
    data['icon_unicode'] = this.iconUnicode;
    return data;
  }
}
