import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/post.dart';
import 'package:distribution_frontend/screens/Auth/actu_commentaire_screen.dart';
import 'package:distribution_frontend/services/poste_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/user_service.dart';
import '../login_screen.dart';

class ActualiteScreen extends StatefulWidget {
  const ActualiteScreen({super.key});

  @override
  State<ActualiteScreen> createState() => _ActualiteScreenState();
}

class _ActualiteScreenState extends State<ActualiteScreen> {
  bool _loading = false;
  bool _noCnx = false;

  PostService postService = PostService();

  List<Post> _posts = [];

  Future<void> postes() async {
    ApiResponse response = await postService.findAll();
    if (response.error == null) {
      setState(() {
        _posts = response.data as List<Post>;
        _loading = true;
        _noCnx = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      print(response.error);
    }
  }

  @override
  void initState() {
    super.initState();
    postes();
  }

  @override
  Widget build(BuildContext context) {
    return !_noCnx
        ? Scaffold(
            backgroundColor: colorfond,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.9,
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
                title: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/actu_daymond_2.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Actualités',
                      style: TextStyle(color: colorblack),
                    ),
                  ],
                ),
                actions: const [],
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () {
                setState(() {
                  _loading = false;
                });
                return postes();
              },
              child: Container(
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                  right: 3,
                ),
                child: _loading
                    ? _posts.isNotEmpty
                        ? ListView.builder(
                            itemCount: _posts.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  92,
                                              height: 2,
                                              color: colorwhite,
                                            ),
                                            Container(
                                              width: 85,
                                              padding: const EdgeInsets.only(
                                                  left: 4),
                                              child: Text(
                                                _posts[index].createdAtFr,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          bottom: 12,
                                        ),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(18),
                                          ),
                                          color: colorwhite,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0, top: 5),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                        _posts[index].title,
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              _posts[index].description != null
                                                  ? Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        _posts[index]
                                                                .description ??
                                                            '',
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Image.network(
                                                    _posts[index].picturePath),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  kLikeEtComment(
                                                      _posts[index].likesCount,
                                                      _posts[index].liked == 1
                                                          ? Icons.thumb_up
                                                          : Icons
                                                              .thumb_up_outlined,
                                                      _posts[index].liked == 1
                                                          ? Colors.blue
                                                          : Colors.black38, () {
                                                    _handlePostLikeNo(
                                                        _posts[index].id);
                                                  }),
                                                  Container(
                                                    width: 1,
                                                    height: 20,
                                                    color: colorBlue100,
                                                  ),
                                                  kLikeEtComment(
                                                      _posts[index]
                                                          .commentsCount,
                                                      Icons.sms_outlined,
                                                      Colors.black54, () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ActuCommentaireScreen(
                                                          postId:
                                                              _posts[index].id,
                                                          image: _posts[index]
                                                              .picturePath,
                                                          body: _posts[index]
                                                              .title,
                                                          description: _posts[
                                                                      index]
                                                                  .description ??
                                                              '',
                                                          heure: _posts[index]
                                                              .createdAtFr,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                            })
                        : const Center(
                            child: Text('Pas d\'actualité!'),
                          )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
          )
        : kRessayer(context, () {
            postes();
          });
  }

  Container kChargement() => Container(
        padding: const EdgeInsets.all(10),
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 255, 255, 255),
          highlightColor: const Color.fromARGB(255, 252, 242, 242),
          child: Container(
            height: 240,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: colorwhite,
            ),
          ),
        ),
      );

  Expanded kLikeEtComment(
      int value, IconData icon, Color color, Function onTap) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text('$value'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handlePostLikeNo(int postId) async {
    ApiResponse response = await postService.likeNo(postId);

    if (response.error == null) {
      postes();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }
}
