extension TvSeriesStatusExtension on String {
  String get statusDisplay {
    switch (this.toLowerCase()) {
      case 'returning series':
        return 'Ongoing';
      case 'ended':
        return 'Finished';
      case 'canceled':
        return 'Canceled';
      case 'in production':
        return 'In Production';
      case 'planned':
        return 'Planned';
      default:
        return this;
    }
  }
}
