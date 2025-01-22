import 'dart:async';
import 'package:distribution_frontend/services/profile_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:distribution_frontend/api_response.dart';
import 'package:distribution_frontend/constante.dart';
import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:distribution_frontend/services/conversation_service.dart';
import 'package:distribution_frontend/services/user_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:distribution_frontend/models/conversation.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    super.key,
    required this.conversation,
  });

  final Conversation conversation;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageContoller = TextEditingController();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int idMessage = 0;

  ProfileService profileService = ProfileService();

  List<Message> _messages = [];

  bool _loading = true;

  Future<void> getConversation() async {
    ApiResponse response =
        await profileService.getConversation(widget.conversation.id);
    if (response.error == null) {
      setState(() {
        Conversation conversation = response.data as Conversation;
        _messages = conversation.messages;
        _loading = false;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false)
          });
    } else {
      setState(() {
        _loading = true;
      });
    }
  }

  Future<void> storeMessage() async {
    ApiResponse response = await profileService.storeMessage(
        widget.conversation.id.toString(), _messageContoller.text);
    getConversation();
    if (response.message != null) {
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
    initializeDateFormatting('fr_FR', null);
    getConversation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
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
                        widget.conversation.profile.picturePath ??
                            imgUserDefault),
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
                  Text(widget.conversation.profile.name),
                  const Text(
                    'Conversation',
                    style: TextStyle(
                      color: colorBlue,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(71, 255, 255, 255),
          iconTheme: const IconThemeData(color: colorblack),
        ),
      ),
      body: _loading
          ? const CircularProgressIndicator()
          : SmartRefresher(
              enablePullDown: true,
              controller: _refreshController,
              onRefresh: () async {
                await getConversation();
                _refreshController.refreshCompleted();
              },
              child: GroupedListView<Message, String>(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 60, left: 10, right: 10),
                reverse: true,
                scrollDirection: Axis.vertical,
                elements: _messages,
                groupBy: (message) {
                  DateTime updatedAt = DateTime.parse(message.updatedAt);
                  return DateFormat('yyyy-MM-dd').format(updatedAt);
                },
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: false,
                groupSeparatorBuilder: (String groupByValue) {
                  DateTime date = DateTime.parse(groupByValue);
                  String formattedDate =
                      DateFormat.yMMMEd('fr_FR').format(date);

                  return Container(
                    alignment: Alignment.center,
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
                itemBuilder: (context, message) {
                  return message.person == 'profile'
                      ? messageProfile(
                          message.id,
                          message.message,
                          message.category == MESSAGE_PRODUCT
                              ? 'Produit'
                              : 'Commande',
                          message.categoryData != null
                              ? message.categoryData.id.toString()
                              : '',
                          message.category == MESSAGE_PRODUCT
                              ? message.categoryData?.photo ??
                                  imgProdDefault.toString()
                              : message.category == MESSAGE_ORDER
                                  ? message.categoryData?.photo ??
                                      imgProdDefault.toString()
                                  : '',
                          message.categoryData != null
                              ? message.categoryData?.name
                              : '',
                          message.updatedAt.substring(11, 16),
                        )
                      : messageUser(
                          message.id,
                          message.message,
                          message.category == MESSAGE_PRODUCT
                              ? 'Produit'
                              : 'Commande',
                          message.categoryData != null
                              ? message.categoryData.id.toString()
                              : '',
                          message.category == MESSAGE_PRODUCT
                              ? message.categoryData?.photo ??
                                  imgProdDefault.toString()
                              : message.category == MESSAGE_ORDER
                                  ? message.categoryData?.photo ??
                                      imgProdDefault.toString()
                                  : '',
                          message.categoryData != null
                              ? message.categoryData?.name
                              : '',
                          message.updatedAt.substring(11, 16),
                        );
                },
              ),
            ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        color: colorwhite,
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
                    setState(() {
                      _messageContoller.clear();
                    });
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

  InkWell messageProfile(int id, String comment, String sujet, String sujetId,
          String photo, String nom, String date) =>
      InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: NetworkImage(
                        widget.conversation.profile.picturePath ??
                            imgUserDefault),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  photo != ''
                      ? InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width - 120,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(108, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(photo),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(sujet),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: 200,
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        nom,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        idMessage == id ? idMessage = 0 : idMessage = id;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      width: MediaQuery.of(context).size.width - 120,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 235, 235),
                        borderRadius: photo == ''
                            ? BorderRadius.circular(24)
                            : const BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                      ),
                      child: Text(
                        comment,
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black87),
                      ),
                    ),
                  ),
                  idMessage == id
                      ? Container(
                          padding: const EdgeInsets.only(top: 2),
                          width: MediaQuery.of(context).size.width - 120,
                          alignment: Alignment.centerRight,
                          child: Text(date),
                        )
                      : Container()
                ],
              ),
            ],
          ),
        ),
      );

  InkWell messageUser(int id, String comment, String sujet, String sujetId,
          String photo, String nom, String date) =>
      InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              photo != ''
                  ? InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        /*sujet != 'Produit'
                            ? print(sujetId.toString())
                            : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ClickProduit(
                                  id: int.parse(sujetId),
                                ),
                          ),
                        );*/
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 50),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(108, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(photo),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    sujet,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width:
                                      MediaQuery.of(context).size.width - 220,
                                  child: Text(nom),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    idMessage == id ? idMessage = 0 : idMessage = id;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: BoxDecoration(
                    color: colorBlue,
                    borderRadius: photo == ''
                        ? BorderRadius.circular(24)
                        : const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                  ),
                  child: Text(
                    comment,
                    style: const TextStyle(fontSize: 18, color: colorwhite),
                  ),
                ),
              ),
              idMessage == id
                  ? Container(
                      padding: const EdgeInsets.only(top: 2),
                      width: MediaQuery.of(context).size.width - 120,
                      alignment: Alignment.centerRight,
                      child: Text(date),
                    )
                  : Container()
            ],
          ),
        ),
      );
}
