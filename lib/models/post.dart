class Post {
  final int id;
  final String title;
  final String? description;
  final String? url;
  final int views;
  final String picturePath;
  final int commentsCount;
  final int likesCount;
  final int? liked;
  final List<PostComment>? comments;
  final String createdAt;
  final String updatedAt;
  final String createdAtFr;
  final String updatedAtFr;

  Post({
    required this.id,
    required this.title,
    this.description,
    this.url,
    required this.views,
    required this.picturePath,
    required this.commentsCount,
    required this.likesCount,
    this.liked,
    this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      url: json['url'] ,
      views: json['views'],
      picturePath: json['picture_path'],
      commentsCount: json['comments_count'],
      likesCount: json['likes_count'],
      liked: json['liked'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }

  factory Post.fromJsonByComments(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      views: json['views'],
      picturePath: json['picture_path'],
      commentsCount: json['comments_count'],
      likesCount: json['likes_count'],
      
      comments: (json['comments'] as List)
          .map((comment) => PostComment.fromJson(comment))
          .toList(),
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAtFr: json['created_at_fr'] ?? '',
      updatedAtFr: json['updated_at_fr'] ?? '',
    );
  }
}

class PostComment {
  final int id;
  final String? pictureUrl;
  final String fullName;
  final String? actor;
  final int? actorId;
  final String comment;
  final String createdAt;
  final String updatedAt;
  final String createdAtFr;
  final String updatedAtFr;

  PostComment({
    required this.id,
    this.pictureUrl,
    required this.fullName,
    this.actor,
    this.actorId,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory PostComment.fromJson(Map<String, dynamic> json) {
    return PostComment(
      id: json['id'],
      pictureUrl: json['picture_url'],
      fullName: json['full_name'],
      actor: json['actor'],
      actorId: json['actor_id'],
      comment: json['comment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }
}
