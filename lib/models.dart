class Reviews {
  late String username;
  late bool warningSpoiler;
  late String date;
  late int rate;
  late String helpfull;
  late String title;
  late String desc;

  Reviews.fromJson(Map<String, dynamic> jsonMap) {
    username = jsonMap['username'];
    warningSpoiler = jsonMap['warningSpoilers'];
    date = jsonMap['date'];
    rate = jsonMap['rate'].isEmpty ? 0 : int.parse(jsonMap['rate']);
    helpfull = jsonMap['helpful'];
    title = jsonMap['title'];
    desc = jsonMap['content'];
  }
}

class TopMovies {
  late String id;
  late String rank;
  late String title;
  late String fullTitle;
  late String image;
  late String crew;
  late String rating;
  late String ratingCount;

  TopMovies.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    rank = jsonMap['rank'];
    title = jsonMap['title'];
    fullTitle = jsonMap['fullTitle'];
    image = jsonMap['image'];
    crew = jsonMap['crew'];
    rating = jsonMap['imDbRating'];
    ratingCount = jsonMap['imDbRatingCount'];
  }
}

class SearchMovie {
  late String id;
  late String image;
  late String title;
  late String desc;

  SearchMovie.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    image = jsonMap['image'];
    title = jsonMap['title'];
    desc = jsonMap['description'];
  }
}
