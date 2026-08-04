enum SearchSortType {
  none('Default'),
  rating('Top Rated'),
  popularity('Most Popular'),
  newest('Newest First');

  const SearchSortType(this.label);
  final String label;
}
