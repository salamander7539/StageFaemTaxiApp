class AddressData {
  // ignore: non_constant_identifier_names
  var uuid,
      point_type,
      unrestricted_value,
      value,
      country,
      region,
      region_type,
      type,
      city,
      category,
      city_type,
      street,
      street_type,
      street_with_type,
      comment,
      house,
      house_type;

  // ignore: non_constant_identifier_names
  var out_of_town;

  // ignore: non_constant_identifier_names
  var accuracy_level, radius, front_door;
  var lat, lon;

  // ignore: non_constant_identifier_names
  AddressData(
      {this.uuid,
        this.point_type,
        this.unrestricted_value,
        this.value,
        this.country,
        this.region,
        this.region_type,
        this.type,
        this.city,
        this.category,
        this.city_type,
        this.street,
        this.street_type,
        this.street_with_type,
        this.house,
        this.front_door,
        this.comment,
        this.out_of_town,
        this.house_type,
        this.accuracy_level,
        this.radius,
        this.lat,
        this.lon});

  factory AddressData.fromJson(Map<String, dynamic> parsedJson) {
    return AddressData(
        uuid: parsedJson['uuid'],
        point_type: parsedJson['point_type'],
        unrestricted_value: parsedJson['unrestricted_value'],
        value: parsedJson['value'],
        country: parsedJson['country'],
        region: parsedJson['region'],
        region_type: parsedJson['region_type'],
        type: parsedJson['type'],
        city: parsedJson['city'],
        category: parsedJson['category'],
        city_type: parsedJson['city_type'],
        street: parsedJson['street'],
        street_type: parsedJson['street_type'],
        street_with_type: parsedJson['street_with_type'],
        house: parsedJson['house'],
        front_door: parsedJson['front_door'],
        comment: parsedJson['comment'],
        out_of_town: parsedJson['out_of_town'],
        house_type: parsedJson['house_type'],
        accuracy_level: parsedJson['accuracy_level'],
        radius: parsedJson['radius'],
        lat: parsedJson['lat'],
        lon: parsedJson['lon']);
  }
}
