import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
/* import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
import 'package:flutter_ui_challenges/src/pages/invitation/inlanding.dart';
 */
class Profils extends StatelessWidget {
  static final String path = "lib/src/pages/settings/settings2.dart";
  final TextStyle whiteText = TextStyle(
    color: Colors.white,
  );
  final TextStyle greyText = TextStyle(
    color: Colors.grey.shade400,
  );
  @override
  Widget build(BuildContext context) {
    //var avatars;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.dark,
          primaryColor: Colors.orangeAccent,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
          ),
                  child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                       decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        /* image: DecorationImage(
                          image: CachedNetworkImageProvider(avatars[1]),
                          fit: BoxFit.cover,
                        ), */
                        border: Border.all(color: Colors.white,width: 2.0,),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("User", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),),
                          Text("Benin",style: TextStyle(
                            color: Colors.grey.shade400,
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20.0),
                ListTile(
                  title: Text("Languages"),
                  subtitle: Text("English US",style: greyText,),
                  trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey.shade400,),
                  onTap: (){},
                ),
                ListTile(
                  title: Text("Profile Settings"),
                  subtitle: Text("User",style: greyText,),
                  trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey.shade400,),
                  onTap: (){},
                ),
                SwitchListTile(
                  title: Text("Email Notifications"),
                  subtitle: Text("On",style: greyText,),
                  value: true,
                  onChanged: (val){},
                ),
                SwitchListTile(
                  title: Text("Push Notifications"),
                  subtitle: Text("Off",style: greyText,),
                  value: false,
                  onChanged: (val){},
                ),
                ListTile(
                  title: Text("Logout"),
                  onTap: (){},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}