class RepositoryModel {
  final String id;
  final String researchTitle;
  final String category;
  final String accessType;
  final int monthlyFee;
  final String description;
  final String status;
  final String genre;
  final String ownerEmail;
  final String hashSignature;
  final String path;
  final List authors;
  final List comments;
  final String year;
  final dynamic thumbnail;
  final dynamic readPath;
  final int hits;
  final int likes;
  final int dislikes;
  final int rating;
  final int favorited;
  final int reading;
  final int read;
  final int paidSubscriptions;
  final int numberOfPages;

  RepositoryModel(
      {this.researchTitle,
      this.authors,
      this.year,
      this.numberOfPages,
      this.id,
      this.category,
      this.accessType,
      this.monthlyFee,
      this.description,
      this.status,
      this.genre,
      this.ownerEmail,
      this.hashSignature,
      this.path,
      this.comments,
      this.thumbnail,
      this.readPath,
      this.hits,
      this.likes,
      this.dislikes,
      this.rating,
      this.favorited,
      this.reading,
      this.read,
      this.paidSubscriptions});

  factory RepositoryModel.fromJson(Map<String, dynamic> data) {
    return RepositoryModel(
      id: data['_id'] as String,
      status: data['status'] as String,
      accessType: data['accessType'] as String,
      monthlyFee: data['monthlyFee'] as int,
      readPath: data['readPath'],
      ownerEmail: data['ownerEmail'] as String,
      description: data['description'] as String,
      hits: data['hits'] as int,
      likes: data['likes'] as int,
      dislikes: data['dislikes'] as int,
      rating: data['rating'] as int,
      favorited: data['favorited'] as int,
      reading: data['reading'] as int,
      read: data['red'] as int,
      paidSubscriptions: data['paidSubscriptions'] as int,
      hashSignature: data['hashSignature'] as String,
      researchTitle: data['researchTitle'] as String,
      authors: data['authors'] as List,
      comments: data['comments'] as List,
      year: data['year'] as String,
      thumbnail: data['thumbnail'],
      numberOfPages: data['nPages'] as int,
    );
  }
}

class AuthorsModel {}
