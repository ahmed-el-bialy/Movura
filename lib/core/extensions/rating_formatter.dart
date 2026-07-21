extension RatingFormatterExt on num {
  double toFiveStarRating() {
    if (this <= 0) return 0.0;
    if (this >= 10) return 5.0;
    return this * 0.5;
  }
}
