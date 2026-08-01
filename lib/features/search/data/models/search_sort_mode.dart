enum SearchSortMode {
  relevance('Relevance'),
  popularity('Popularity'),
  rating('Rating'),
  releaseDate('Release Date'),
  voteCount('Vote Count');

  final String label;
  const SearchSortMode(this.label);
}
