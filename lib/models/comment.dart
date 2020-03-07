import 'package:firebase_storage/firebase_storage.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class Comment with PropertyChangeNotifier<String> {
  String profileImage = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.iconfinder.com%2Ficons%2F3273769%2Fempty_image_picture_placeholder_icon&psig=AOvVaw2uSARERdJv82tA4y2fZjjp&ust=1583538146682000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMifqbnBhOgCFQAAAAAdAAAAABAD';
  String username;
  String comment;
  String madeIn;
  Future<void> loadImageFromStorage(String name) async {
    String link = "user_profile_pictures/$name.jpg";
    await FirebaseStorage.instance.ref().child(link).getDownloadURL().then((value){
      print('the link is $link');
      print('got profile picture');
      profileImage = value.toString();
      notifyListeners('profile image arrived');
    });
  }
  String _emoji(String country) {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;


    int firstChar = country.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = country.codeUnitAt(1) - asciiOffset + flagOffset;

    String emoji =
        String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
    return emoji;
  }
  Comment(this.profileImage,this.username,this.comment);
  Comment.fromMap(Map<dynamic, dynamic> data){
    username = data['Made by'];
    comment = data['Comment'];
    madeIn = _emoji(data['Made in']);
    loadImageFromStorage(username);
  }
}
