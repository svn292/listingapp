class CityModel {
  String id;
  String name;
  String slug;
  String countryId;

  CityModel({this.id, this.name, this.slug, this.countryId});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['country_id'] = this.countryId;
    return data;
  }
}
