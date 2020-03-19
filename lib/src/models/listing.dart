class ListingItem {
  ListingItem(
      this.code,
      this.name,
      this.type,
      this.imgUrl,
      this.description,
      this.category,
      this.address,
      this.phone,
      this.facility,
      this.lat,
      this.long,
      this.email,
      this.time);
  String name;
  String type;
  String code;
  String imgUrl;
  String description;
  String category;
  String address;
  String phone;
  List facility;
  String lat;
  String long;
  String email;
  Map time;
}
