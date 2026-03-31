import 'dart:convert';

MyIpdetailsModel myIpdetailsModelFromJson(String str) =>
    MyIpdetailsModel.fromJson(json.decode(str));

String myIpdetailsModelToJson(MyIpdetailsModel data) =>
    json.encode(data.toJson());

class MyIpdetailsModel {
  final String? status;
  final Map<String, IpDetails>? ipData;
  final int? queryTime;

  MyIpdetailsModel({this.status, this.ipData, this.queryTime});

  factory MyIpdetailsModel.fromJson(Map<String, dynamic> json) {
    final Map<String, IpDetails> ipMap = {};

    json.forEach((key, value) {
      if (key != "status" && key != "query_time") {
        ipMap[key] = IpDetails.fromJson(value);
      }
    });

    return MyIpdetailsModel(
      status: json["status"],
      ipData: ipMap,
      queryTime: json["query_time"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data["status"] = status;
    data["query_time"] = queryTime;

    ipData?.forEach((key, value) {
      data[key] = value.toJson();
    });

    return data;
  }
}

class IpDetails {
  final Network? network;
  final Location? location;
  final DeviceEstimate? deviceEstimate;
  final Detections? detections;
  final dynamic detectionHistory;
  final dynamic attackHistory;
  final dynamic operatorField;
  final DateTime? lastUpdated;

  IpDetails({
    this.network,
    this.location,
    this.deviceEstimate,
    this.detections,
    this.detectionHistory,
    this.attackHistory,
    this.operatorField,
    this.lastUpdated,
  });

  factory IpDetails.fromJson(Map<String, dynamic> json) => IpDetails(
    network: json["network"] != null ? Network.fromJson(json["network"]) : null,
    location: json["location"] != null
        ? Location.fromJson(json["location"])
        : null,
    deviceEstimate: json["device_estimate"] != null
        ? DeviceEstimate.fromJson(json["device_estimate"])
        : null,
    detections: json["detections"] != null
        ? Detections.fromJson(json["detections"])
        : null,
    detectionHistory: json["detection_history"],
    attackHistory: json["attack_history"],
    operatorField: json["operator"],
    lastUpdated: json["last_updated"] != null
        ? DateTime.parse(json["last_updated"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "network": network?.toJson(),
    "location": location?.toJson(),
    "device_estimate": deviceEstimate?.toJson(),
    "detections": detections?.toJson(),
    "detection_history": detectionHistory,
    "attack_history": attackHistory,
    "operator": operatorField,
    "last_updated": lastUpdated?.toIso8601String(),
  };
}

class Network {
  final dynamic asn;
  final dynamic range;
  final String? hostname;
  final dynamic provider;
  final String? organisation;
  final String? type;

  Network({
    this.asn,
    this.range,
    this.hostname,
    this.provider,
    this.organisation,
    this.type,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    asn: json["asn"],
    range: json["range"],
    hostname: json["hostname"],
    provider: json["provider"],
    organisation: json["organisation"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "asn": asn,
    "range": range,
    "hostname": hostname,
    "provider": provider,
    "organisation": organisation,
    "type": type,
  };
}

class Location {
  final String? continentName;
  final String? continentCode;
  final String? countryName;
  final String? countryCode;
  final String? regionName;
  final String? regionCode;
  final String? cityName;
  final dynamic postalCode;
  final double? latitude;
  final double? longitude;
  final String? timezone;
  final Currency? currency;

  Location({
    this.continentName,
    this.continentCode,
    this.countryName,
    this.countryCode,
    this.regionName,
    this.regionCode,
    this.cityName,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.timezone,
    this.currency,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    continentName: json["continent_name"],
    continentCode: json["continent_code"],
    countryName: json["country_name"],
    countryCode: json["country_code"],
    regionName: json["region_name"],
    regionCode: json["region_code"],
    cityName: json["city_name"],
    postalCode: json["postal_code"],
    latitude: (json["latitude"] != null)
        ? (json["latitude"] as num).toDouble()
        : null,
    longitude: (json["longitude"] != null)
        ? (json["longitude"] as num).toDouble()
        : null,
    timezone: json["timezone"],
    currency: json["currency"] != null
        ? Currency.fromJson(json["currency"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "continent_name": continentName,
    "continent_code": continentCode,
    "country_name": countryName,
    "country_code": countryCode,
    "region_name": regionName,
    "region_code": regionCode,
    "city_name": cityName,
    "postal_code": postalCode,
    "latitude": latitude,
    "longitude": longitude,
    "timezone": timezone,
    "currency": currency?.toJson(),
  };
}

class Currency {
  final String? name;
  final String? code;
  final String? symbol;

  Currency({this.name, this.code, this.symbol});

  factory Currency.fromJson(Map<String, dynamic> json) =>
      Currency(name: json["name"], code: json["code"], symbol: json["symbol"]);

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "symbol": symbol,
  };
}

class DeviceEstimate {
  final int? address;
  final int? subnet;

  DeviceEstimate({this.address, this.subnet});

  factory DeviceEstimate.fromJson(Map<String, dynamic> json) =>
      DeviceEstimate(address: json["address"], subnet: json["subnet"]);

  Map<String, dynamic> toJson() => {"address": address, "subnet": subnet};
}

class Detections {
  final bool? proxy;
  final bool? vpn;
  final bool? compromised;
  final bool? scraper;
  final bool? tor;
  final bool? hosting;
  final bool? anonymous;
  final int? risk;
  final int? confidence;
  final dynamic firstSeen;
  final dynamic lastSeen;

  Detections({
    this.proxy,
    this.vpn,
    this.compromised,
    this.scraper,
    this.tor,
    this.hosting,
    this.anonymous,
    this.risk,
    this.confidence,
    this.firstSeen,
    this.lastSeen,
  });

  factory Detections.fromJson(Map<String, dynamic> json) => Detections(
    proxy: json["proxy"],
    vpn: json["vpn"],
    compromised: json["compromised"],
    scraper: json["scraper"],
    tor: json["tor"],
    hosting: json["hosting"],
    anonymous: json["anonymous"],
    risk: json["risk"],
    confidence: json["confidence"],
    firstSeen: json["first_seen"],
    lastSeen: json["last_seen"],
  );

  Map<String, dynamic> toJson() => {
    "proxy": proxy,
    "vpn": vpn,
    "compromised": compromised,
    "scraper": scraper,
    "tor": tor,
    "hosting": hosting,
    "anonymous": anonymous,
    "risk": risk,
    "confidence": confidence,
    "first_seen": firstSeen,
    "last_seen": lastSeen,
  };
}
