// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_provider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchProviderResponse _$WatchProviderResponseFromJson(
  Map<String, dynamic> json,
) => WatchProviderResponse(
  results: (json['results'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(k, WatchProviderCountry.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$WatchProviderResponseToJson(
  WatchProviderResponse instance,
) => <String, dynamic>{'results': instance.results};

WatchProviderCountry _$WatchProviderCountryFromJson(
  Map<String, dynamic> json,
) => WatchProviderCountry(
  link: json['link'] as String?,
  flatrate: (json['flatrate'] as List<dynamic>?)
      ?.map((e) => WatchProvider.fromJson(e as Map<String, dynamic>))
      .toList(),
  rent: (json['rent'] as List<dynamic>?)
      ?.map((e) => WatchProvider.fromJson(e as Map<String, dynamic>))
      .toList(),
  buy: (json['buy'] as List<dynamic>?)
      ?.map((e) => WatchProvider.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WatchProviderCountryToJson(
  WatchProviderCountry instance,
) => <String, dynamic>{
  'link': instance.link,
  'flatrate': instance.flatrate,
  'rent': instance.rent,
  'buy': instance.buy,
};

WatchProvider _$WatchProviderFromJson(Map<String, dynamic> json) =>
    WatchProvider(
      logoPath: json['logo_path'] as String?,
      providerId: (json['provider_id'] as num).toInt(),
      providerName: json['provider_name'] as String,
      displayPriority: (json['display_priority'] as num).toInt(),
    );

Map<String, dynamic> _$WatchProviderToJson(WatchProvider instance) =>
    <String, dynamic>{
      'logo_path': instance.logoPath,
      'provider_id': instance.providerId,
      'provider_name': instance.providerName,
      'display_priority': instance.displayPriority,
    };
