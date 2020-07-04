class FavsData {
  String id;
  String code;
  String name;
  String description;
  String categories;
  String amenities;
  String photos;
  String videoUrl;
  String videoProvider;
  String tags;
  String address;
  String email;
  String phone;
  String website;
  String social;
  String userId;
  String latitude;
  String longitude;
  String countryId;
  dynamic cityId;
  String status;
  String listingType;
  String listingThumbnail;
  String listingCover;
  String seoMetaTags;
  String dateAdded;
  String dateModified;
  String isFeatured;
  String googleAnalyticsId;

  FavsData(
      {this.id,
      this.code,
      this.name,
      this.description,
      this.categories,
      this.amenities,
      this.photos,
      this.videoUrl,
      this.videoProvider,
      this.tags,
      this.address,
      this.email,
      this.phone,
      this.website,
      this.social,
      this.userId,
      this.latitude,
      this.longitude,
      this.countryId,
      this.cityId,
      this.status,
      this.listingType,
      this.listingThumbnail,
      this.listingCover,
      this.seoMetaTags,
      this.dateAdded,
      this.dateModified,
      this.isFeatured,
      this.googleAnalyticsId});

  FavsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    categories = json['categories'];
    amenities = json['amenities'];
    photos = json['photos'];
    videoUrl = json['video_url'];
    videoProvider = json['video_provider'];
    tags = json['tags'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    website = json['website'];
    social = json['social'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    status = json['status'];
    listingType = json['listing_type'];
    listingThumbnail = json['listing_thumbnail'];
    listingCover = json['listing_cover'];
    seoMetaTags = json['seo_meta_tags'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    isFeatured = json['is_featured'];
    googleAnalyticsId = json['google_analytics_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['categories'] = this.categories;
    data['amenities'] = this.amenities;
    data['photos'] = this.photos;
    data['video_url'] = this.videoUrl;
    data['video_provider'] = this.videoProvider;
    data['tags'] = this.tags;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['website'] = this.website;
    data['social'] = this.social;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['status'] = this.status;
    data['listing_type'] = this.listingType;
    data['listing_thumbnail'] = this.listingThumbnail;
    data['listing_cover'] = this.listingCover;
    data['seo_meta_tags'] = this.seoMetaTags;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['is_featured'] = this.isFeatured;
    data['google_analytics_id'] = this.googleAnalyticsId;
    return data;
  }
}
