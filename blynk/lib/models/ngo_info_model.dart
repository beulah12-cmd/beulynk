class NGOInfo {
  final int id;
  final String name;
  final String fullName;
  final String tagline;
  final String mission;
  final String description;
  final String email;
  final String phone;
  final String address;
  final String? facebookUrl;
  final String? twitterUrl;
  final String? instagramUrl;
  final String? linkedinUrl;
  final int livesImpacted;
  final int activeDonors;
  final int communitiesServed;

  NGOInfo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.tagline,
    required this.mission,
    required this.description,
    required this.email,
    required this.phone,
    required this.address,
    this.facebookUrl,
    this.twitterUrl,
    this.instagramUrl,
    this.linkedinUrl,
    required this.livesImpacted,
    required this.activeDonors,
    required this.communitiesServed,
  });

  factory NGOInfo.fromJson(Map<String, dynamic> json) {
    return NGOInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      tagline: json['tagline'] as String,
      mission: json['mission'] as String,
      description: json['description'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      facebookUrl: json['facebook_url'] as String?,
      twitterUrl: json['twitter_url'] as String?,
      instagramUrl: json['instagram_url'] as String?,
      linkedinUrl: json['linkedin_url'] as String?,
      livesImpacted: json['lives_impacted'] as int,
      activeDonors: json['active_donors'] as int,
      communitiesServed: json['communities_served'] as int,
    );
  }
}
