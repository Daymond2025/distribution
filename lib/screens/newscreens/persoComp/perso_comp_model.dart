import '../flutter_flow_expanded_image_view.dart';
import '../flutter_flow_icon_button.dart';
import '../flutter_flow_theme.dart';
import '../flutter_flow_util.dart';
import '../flutter_flow_widgets.dart';
import 'dart:ui';
import 'perso_comp_widget.dart' show PersoCompWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PersoCompModel extends FlutterFlowModel<PersoCompWidget> {
  ///  Local state fields for this component.

  bool activNom = true;

  bool activDesc = true;

  bool activSub = true;

  bool offre = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for nomController widget.
  FocusNode? nomControllerFocusNode;
  TextEditingController? nomControllerTextController;
  String? Function(BuildContext, String?)? nomControllerTextControllerValidator;
  // State field(s) for soustitre widget.
  FocusNode? soustitreFocusNode;
  TextEditingController? soustitreTextController;
  String? Function(BuildContext, String?)? soustitreTextControllerValidator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  // State field(s) for contact widget.
  FocusNode? contactFocusNode;
  TextEditingController? contactTextController;
  String? Function(BuildContext, String?)? contactTextControllerValidator;

  FocusNode? textFieldFocusNode;

  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nomControllerFocusNode?.dispose();
    nomControllerTextController?.dispose();

    soustitreFocusNode?.dispose();
    soustitreTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    contactFocusNode?.dispose();
    contactTextController?.dispose();
  }
}
