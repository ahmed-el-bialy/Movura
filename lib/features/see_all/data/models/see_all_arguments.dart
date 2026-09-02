import '../../../../core/models/poster_model.dart';

class SeeAllArguments {
  final String title;
  final Future<List<PosterModel>> Function(int page) fetchData;
  final List<PosterModel>? initialItems;

  SeeAllArguments({
    required this.title,
    required this.fetchData,
    this.initialItems,
  });
}
