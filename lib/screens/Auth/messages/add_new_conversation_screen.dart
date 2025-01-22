import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/common/alert_component.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/models/conversation.dart';
import 'package:distribution_frontend/screens/Auth/messages/conversation_screen.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/profile_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddNewConversationScreen extends StatefulWidget {
  const AddNewConversationScreen({
    super.key,
    this.idCategory,
    this.category,
    required this.profile,
  });
  final String? idCategory;
  final String? category;
  final Profile profile;
  @override
  State<AddNewConversationScreen> createState() =>
      _AddNewConversationScreenState();
}

class _AddNewConversationScreenState extends State<AddNewConversationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageContoller = TextEditingController();

  ProfileService profileService = ProfileService();

  Future<void> storeMessage() async {
    AlertComponent().loading();

    ApiResponse response = await profileService.storeConversation(
      widget.profile.id.toString(),
      _messageContoller.text,
      widget.category,
      widget.idCategory,
    );

    AlertComponent().endLoading();

    if (response.error == null) {
      Conversation conversation = response.data as Conversation;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationScreen(
            conversation: conversation,
          ),
        ),
      );
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  void _submit() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorwhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          iconTheme: const IconThemeData(color: colorblack),
          backgroundColor: colorwhite,
          elevation: 0,
          leadingWidth: 40,
          titleTextStyle: const TextStyle(color: colorblack, fontSize: 20),
          title: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: NetworkImage(
                        widget.profile.picturePath ?? imgUserDefault),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.profile.name),
                  const Text(
                    'Nouvelle conversation',
                    style: TextStyle(
                      color: colorBlue,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        color: const Color.fromARGB(255, 236, 235, 235),
        child: Form(
          key: _formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                child: TextFormField(
                  minLines: 1,
                  maxLines: 5,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  controller: _messageContoller,
                  decoration: InputDecoration(
                    hintText: 'Votre message',
                    filled: true,
                    fillColor: colorfond,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide: const BorderSide(
                        width: 0.1,
                        color: colorfond,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide: const BorderSide(
                        width: 0.1,
                        color: colorfond,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide: const BorderSide(
                        width: 0.1,
                        color: colorfond,
                      ),
                    ),
                  ),
                ),
              ),
              // ignore: avoid_print
              IconButton(
                // ignore: avoid_print
                onPressed: () {
                  if (_messageContoller.text != '') {
                    storeMessage();
                  }
                },
                icon: const FaIcon(
                  color: colorBlue,
                  FontAwesomeIcons.paperPlane,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
