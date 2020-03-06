import 'dart:io';

import 'package:flutter/material.dart';

class Comment {
  AssetImage profileImage;
  String username;
  String comment;
  Comment(this.profileImage,this.username,this.comment);
  Comment.fromMap(Map<dynamic, dynamic> data){
    username = data['Made by'];
    comment = data['Comment'];
  }
}
