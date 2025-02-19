import 'package:distribution_frontend/screens/newscreens/commandeAnnulee/commande_annulee_model.dart';
import 'package:distribution_frontend/screens/newscreens/commandeAttente/commande_attente_model.dart';
import 'package:distribution_frontend/screens/newscreens/commandeEnCours/commande_encours_model.dart';
import 'package:distribution_frontend/screens/newscreens/commandeValidee/commande_validee_model.dart';
import 'package:distribution_frontend/screens/newscreens/flutter_flow_model.dart';

import 'dart:ui';
import 'order_sheet_widget.dart' show OrderSheetWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderSheetModel extends FlutterFlowModel<OrderSheetWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for commandeAttente component.
  late CommandeAttenteModel commandeAttenteModel;
  // Model for commandeAnnulee component.
  late CommandeAnnuleeModel commandeAnnuleeModel;
  // Model for commandeValidee component.
  late CommandeValideeModel commandeValideeModel;
  // Model for commandeEncours component.
  late CommandeEncoursModel commandeEncoursModel;

  @override
  void initState(BuildContext context) {
    commandeAttenteModel = createModel(context, () => CommandeAttenteModel());
    commandeAnnuleeModel = createModel(context, () => CommandeAnnuleeModel());
    commandeValideeModel = createModel(context, () => CommandeValideeModel());
    commandeEncoursModel = createModel(context, () => CommandeEncoursModel());
  }

  @override
  void dispose() {
    commandeAttenteModel.dispose();
    commandeAnnuleeModel.dispose();
    commandeValideeModel.dispose();
    commandeEncoursModel.dispose();
  }
}
