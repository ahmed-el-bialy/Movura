import 'package:movura/features/details/data/models/tv_models/about_tv_series_model.dart';

class ArgumentsModel {
  final String mediaType;
  final int mediaId;

  ArgumentsModel({required this.mediaType, required this.mediaId});
}

class SeasonArgumentsModel {
  final int tvId;
  final int seasonNumber;
  final String tvTitle;
  final String seasonName;

  SeasonArgumentsModel({
    required this.tvId,
    required this.seasonNumber,
    required this.tvTitle,
    required this.seasonName,
  });
}

class AllSeasonsArgumentsModel {
  final int tvId;
  final String tvTitle;
  final List<TvSeasonModel> seasons;

  AllSeasonsArgumentsModel({
    required this.tvId,
    required this.tvTitle,
    required this.seasons,
  });
}