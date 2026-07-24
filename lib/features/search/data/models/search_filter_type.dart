enum SearchFilterType {
  all('All', null),
  movies('Movies', 'movie'),
  tv('TV Shows', 'tv'),
  people('People', 'person');

  const SearchFilterType(this.label, this.mediaType);

  final String label;
  final String? mediaType;
}
