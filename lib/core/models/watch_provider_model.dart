import 'package:json_annotation/json_annotation.dart';

part 'watch_provider_model.g.dart';

@JsonSerializable()
class WatchProviderResponse {
  final Map<String, WatchProviderCountry>? results;

  WatchProviderResponse({this.results});

  factory WatchProviderResponse.fromJson(Map<String, dynamic> json) =>
      _$WatchProviderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WatchProviderResponseToJson(this);
}

@JsonSerializable()
class WatchProviderCountry {
  final String? link;
  final List<WatchProvider>? flatrate;
  final List<WatchProvider>? rent;
  final List<WatchProvider>? buy;

  WatchProviderCountry({this.link, this.flatrate, this.rent, this.buy});

  factory WatchProviderCountry.fromJson(Map<String, dynamic> json) =>
      _$WatchProviderCountryFromJson(json);

  Map<String, dynamic> toJson() => _$WatchProviderCountryToJson(this);
}

@JsonSerializable()
class WatchProvider {
  @JsonKey(name: "logo_path")
  final String? logoPath;
  @JsonKey(name: "provider_id")
  final int providerId;
  @JsonKey(name: "provider_name")
  final String providerName;
  @JsonKey(name: "display_priority")
  final int displayPriority;

  WatchProvider({
    this.logoPath,
    required this.providerId,
    required this.providerName,
    required this.displayPriority,
  });

  factory WatchProvider.fromJson(Map<String, dynamic> json) =>
      _$WatchProviderFromJson(json);

  Map<String, dynamic> toJson() => _$WatchProviderToJson(this);
}
