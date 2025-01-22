import 'package:distribution_frontend/constante.dart';
import 'package:flutter/material.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/models/post.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/poste_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:shimmer/shimmer.dart';

class ActuCommentaireScreen extends StatefulWidget {
  const ActuCommentaireScreen({
    super.key,
    required this.postId,
    required this.image,
    required this.body,
    required this.description,
    required this.heure,
  });

  final int postId;
  final String image;
  final String body;
  final String description;
  final String heure;

  @override
  State<ActuCommentaireScreen> createState() => _ActuCommentaireScreenState();
}

class _ActuCommentaireScreenState extends State<ActuCommentaireScreen> {
  bool _loading = false;
  late Post _post;
  String comment = '';
  int sellerId = 0;

  final PostService postService = PostService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  Future<void> _loadPost() async {
    sellerId = await getVendeurId();
    EasyLoading.show(status: 'Chargement...');
    ApiResponse response = await postService.find(widget.postId);

    EasyLoading.dismiss();
    if (response.error == null) {
      setState(() {
        _post = response.data as Post;
        _loading = true;
      });
    } else {
      _handleError(response.error);
    }
  }

  Future<void> _storeComment() async {
    if (commentController.text.isEmpty) return;

    setState(() {
      comment = commentController.text;
    });
    commentController.clear();

    EasyLoading.show(status: 'Envoi du commentaire...');
    ApiResponse response =
        await postService.storeComment(widget.postId, comment);
    EasyLoading.dismiss();

    if (response.error == null) {
      _loadPost();
    } else {
      _handleError(response.error);
    }
  }

  Future<void> _deleteComment(int id) async {
    EasyLoading.show(status: 'Suppression...');
    ApiResponse response = await postService.deleteComment(id);
    EasyLoading.dismiss();

    if (response.error == null) {
      _loadPost();
    } else {
      _handleError(response.error);
    }
  }

  void _handleError(String? error) {
    if (error == unauthorized) {
      logout().then((_) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      });
    } else {
      _showErrorAlert(error ?? 'Une erreur est survenue');
    }
  }

  void _showErrorAlert(String text) {
    Alert(
      context: context,
      style: AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        titleStyle: const TextStyle(color: Colors.black),
        animationDuration: const Duration(milliseconds: 100),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        overlayColor: Colors.black54,
        backgroundColor: Colors.white,
      ),
      type: AlertType.error,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.orange.shade100,
          child: const Text("Retour",
              style: TextStyle(color: Colors.orange, fontSize: 20)),
        )
      ],
    ).show();
  }

  void _showConfirmAlert(String text, int id) {
    Alert(
      context: context,
      style: AlertStyle(
        animationType: AnimationType.fromLeft,
        isCloseButton: false,
        titleStyle: const TextStyle(color: Colors.black),
        animationDuration: const Duration(milliseconds: 100),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        overlayColor: Colors.black54,
        isOverlayTapDismiss: false,
        backgroundColor: Colors.white,
      ),
      type: AlertType.info,
      title: text,
      buttons: [
        DialogButton(
          onPressed: () {
            _deleteComment(id);
            Navigator.pop(context);
          },
          color: Colors.orange.shade100,
          child: const Text("Confirmé",
              style: TextStyle(color: Colors.orange, fontSize: 20)),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.orange.shade100,
          child: const Text("Retour",
              style: TextStyle(color: Colors.orange, fontSize: 20)),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      appBar: AppBar(
        backgroundColor: colorwhite,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Image.asset('assets/images/actu.png', width: 30, height: 30),
            const SizedBox(width: 5),
            const Text('Actu', style: TextStyle(color: colorblack)),
          ],
        ),
      ),
      body: _loading ? _buildLoadedContent() : _buildLoadingContent(),
      bottomSheet: _buildCommentInput(),
    );
  }

  Widget _buildLoadedContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPostContent(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _buildCommentSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Column(
      children: [
        _buildShimmerBox(),
        _buildShimmerBox(alignment: Alignment.centerRight),
      ],
    );
  }

  Widget _buildPostContent() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: colorwhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.body,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(widget.description, textAlign: TextAlign.justify),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(widget.image,
                fit: BoxFit.cover, width: double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Column(
      children: _post.comments!.isNotEmpty
          ? _post.comments!
              .map(
                (e) => (sellerId == e.actorId || e.actor! == 'seller')
                    ? _buildCommentCardMe(e)
                    : _buildCommentCardVendeurs(e),
              )
              .toList()
          : [Container()],
    );
  }

  Widget _buildCommentCardMe(PostComment e) => InkWell(
        onLongPress: () =>
            _showConfirmAlert('Veuillez confirmer la suppression svp!', e.id),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BubbleSpecialOne(
                text: e.comment,
                color: colorBlue,
                textStyle: const TextStyle(fontSize: 15, color: colorwhite),
              ),
            ),
            Column(
              children: [
                CircleAvatar(
                    backgroundImage:
                        NetworkImage(e.pictureUrl ?? imgUserDefault)),
                Text(e.fullName, style: const TextStyle(fontSize: 8)),
                Text(e.updatedAtFr, style: const TextStyle(fontSize: 8)),
              ],
            ),
          ],
        ),
      );

  Widget _buildCommentCardVendeurs(PostComment e) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                  backgroundImage:
                      NetworkImage(e.pictureUrl ?? imgUserDefault)),
              Text(e.fullName, style: const TextStyle(fontSize: 8)),
              Text(e.updatedAtFr, style: const TextStyle(fontSize: 8)),
            ],
          ),
          Expanded(
            child: BubbleSpecialOne(
              text: e.comment,
              isSender: false,
              color: const Color(0xFFE8E8EE),
              textStyle: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      );

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: commentController,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Entrez votre commentaire',
                  filled: true,
                  fillColor: colorfond,
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _storeComment,
              icon: const Icon(Icons.send, color: colorBlue, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerBox({Alignment alignment = Alignment.centerLeft}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Align(
        alignment: alignment,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: colorwhite,
          ),
        ),
      ),
    );
  }
}
