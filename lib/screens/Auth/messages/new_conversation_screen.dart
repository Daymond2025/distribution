import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/conversation.dart';
import 'package:distribution_frontend/models/seller.dart';
import 'package:distribution_frontend/models/user.dart';
import 'package:distribution_frontend/screens/Auth/messages/add_new_conversation_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/profile_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shimmer/shimmer.dart';

class NewConversationScreen extends StatefulWidget {
  const NewConversationScreen({super.key, required this.profiles});
  final List<Profile> profiles;
  @override
  State<NewConversationScreen> createState() => _NewConversationScreenState();
}

class _NewConversationScreenState extends State<NewConversationScreen> {
  bool _loading = true;

  late Seller seller;
  List<Profile> _profiles = [];
  ProfileService profileService = ProfileService();
  UserService userService = UserService();

  Future<void> getSeller() async {
    ApiResponse response = await userService.getUserDetail();
    if (response.error == null) {
      setState(() {
        seller = response.data as Seller;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    _profiles = widget.profiles;
    _loading = !_loading;
    getSeller();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 0,
        backgroundColor: colorwhite,
        iconTheme: const IconThemeData(
          color: colorblack,
        ),
        title: const Text(
          'Messages',
          style: TextStyle(
            color: colorblack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              child: const Text(
                "Bienvenue sur votre messagerie daymond sélectionnez un assistant \net commencez une conversation",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 65, 65, 65).withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 6), // changes position of shadow
                  ),
                ],
                color: Colors.white,
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 135,
                ),
                itemCount: !_loading ? _profiles.length : 3,
                itemBuilder: (_, index) {
                  Profile profile = _profiles[index];
                  return !_loading
                      ? Container(
                          padding: EdgeInsets.zero,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return kDialogProfile(
                                    profile,
                                  );
                                },
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        profile.picturePath ?? imgUserDefault,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  profile.name,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 255, 255, 255),
                            highlightColor:
                                const Color.fromARGB(255, 236, 235, 235),
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: colorwhite,
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: _loading
                  ? _profiles.map((e) {
                      return kCardProfile(
                        e,
                      );
                    }).toList()
                  : [],
            ),
          ],
        ),
      ),
    );
  }

  Dialog kDialogProfile(Profile profile) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              height: 340,
              padding: const EdgeInsets.only(
                  left: 20, top: 65, right: 20, bottom: 20),
              margin: const EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 3),
                      blurRadius: 3,
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Bonjour ${seller.firstName} ${seller.lastName}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Je suis ${profile.name} votre assistant(e) disponible ${profile.role} et vos activités sur l\'application daymond distribution.',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewConversationScreen(
                                profile: profile,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Je commence une conversation',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(profile.picturePath ?? imgUserDefault),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  InkWell kCardProfile(
    Profile profile,
  ) =>
      InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return kDialogProfile(
                profile,
              );
            },
          );
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 10, top: 7, bottom: 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.zero,
                  child: Stack(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        margin: const EdgeInsets.only(right: 23),
                        decoration: BoxDecoration(
                          color: colorwhite,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              profile.picturePath ?? imgUserDefault,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 23,
                        child: Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: profile.status == 'active'
                                ? Colors.green
                                : colorannule,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: 7,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                              text: profile.name,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        profile.role,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const Divider()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
