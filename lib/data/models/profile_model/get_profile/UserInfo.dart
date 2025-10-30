class UserInfo {
  UserInfo({
      this.userId, 
      this.birthDate, 
      this.gender, 
      this.residenceAddress, 
      this.nid, 
      this.picture, 
      this.mediaId, 
      this.fullPictureUrl,});

  UserInfo.fromJson(dynamic json) {
    userId = json['userId'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    residenceAddress = json['residenceAddress'];
    nid = json['nid'];
    picture = json['picture'];
    mediaId = json['mediaId'];
    fullPictureUrl = json['fullPictureUrl'];
  }
  num? userId;
  String? birthDate;
  String? gender;
  String? residenceAddress;
  String? nid;
  String? picture;
  num? mediaId;
  String? fullPictureUrl;
UserInfo copyWith({  num? userId,
  String? birthDate,
  String? gender,
  String? residenceAddress,
  String? nid,
  String? picture,
  num? mediaId,
  String? fullPictureUrl,
}) => UserInfo(  userId: userId ?? this.userId,
  birthDate: birthDate ?? this.birthDate,
  gender: gender ?? this.gender,
  residenceAddress: residenceAddress ?? this.residenceAddress,
  nid: nid ?? this.nid,
  picture: picture ?? this.picture,
  mediaId: mediaId ?? this.mediaId,
  fullPictureUrl: fullPictureUrl ?? this.fullPictureUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['birthDate'] = birthDate;
    map['gender'] = gender;
    map['residenceAddress'] = residenceAddress;
    map['nid'] = nid;
    map['picture'] = picture;
    map['mediaId'] = mediaId;
    map['fullPictureUrl'] = fullPictureUrl;
    return map;
  }

}