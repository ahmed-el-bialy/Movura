import '../web_services/tv_web_services.dart';
import '../about_tv_series_model.dart';
import '../episode_details_model.dart';
import '../season_details_model.dart';
import '../../../../core/models/review_model.dart';
import '../../../../core/models/similar_model.dart';
import '../../../../core/models/poster_model.dart';

class TvSeriesRepo {
  final TvWebServices tvWebServices;

  TvSeriesRepo({required this.tvWebServices});

  Future<AboutTvSeriesModel> getTvSeriesMainDetails({required int movieId}) async {
    return await tvWebServices.getTvSeriesMainDetails(id: movieId);
  }

  Future<List<ReviewModel>> getTvSeriesReviews({required int id}) async {
    final response = await tvWebServices.getTvSeriesReviews(id: id);
    return response.reviewsList ?? [];
  }

  Future<SimilarContentResponse> getSimilarTvSeries({required int id}) async {
    return await tvWebServices.getSimilarTvSeries(id: id);
  }

  Future<List<PosterModel>> getSimilarTvSeriesPaginated({
    required int id,
    required int page,
  }) async {
    final response = await tvWebServices.getSimilarTvSeriesPaginated(
      id: id,
      page: page,
    );
    return response.results?.map((e) => e.copyWith(mediaType: 'tv')).toList() ?? [];
  }


  Future<SeasonDetailsModel> getTvSeasonDetails({
    required int id,
    required int seasonNumber,
  }) async {
    return await tvWebServices.getTvSeasonDetails(
      id: id,
      seasonNumber: seasonNumber,
    );
  }

  Future<EpisodeDetailsModel> getTvEpisodeDetails({
    required int id,
    required int seasonNumber,
    required int episodeNumber,
  }) async {
    return await tvWebServices.getTvEpisodeDetails(
      id: id,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
    );
  }
}
