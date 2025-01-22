import 'package:distribution_frontend/screens/newscreens/flutter_flow_model.dart';
import 'package:distribution_frontend/screens/newscreens/produit_comp/produit_comp_model.dart';

import 'dart:ui';
import 'boutique_widget.dart' show BoutiqueWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BoutiqueModel extends FlutterFlowModel<BoutiqueWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for produitComp component.
  late ProduitCompModel produitCompModel;

  @override
  void initState(BuildContext context) {
    produitCompModel = createModel(context, () => ProduitCompModel());
  }

  @override
  void dispose() {
    produitCompModel.dispose();
  }
}
