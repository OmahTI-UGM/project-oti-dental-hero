int calculateStar(int score) {
  final int star;
  if (score <= 100 && score > 66) {
    star = 3;
  } else if (score <= 66 && score > 33) {
    star = 2;
  } else if (score <= 33 && score > 0) {
    star = 1;
  } else {
    star = 0;
  }
  return star;
}
