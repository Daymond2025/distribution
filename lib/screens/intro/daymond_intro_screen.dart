import 'package:distribution_frontend/screens/login_screen.dart';
import 'package:flutter/material.dart';

class DaymondIntroScreen extends StatefulWidget {
  const DaymondIntroScreen({super.key});

  @override
  _DaymondIntroScreenState createState() => _DaymondIntroScreenState();
}

class _DaymondIntroScreenState extends State<DaymondIntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage == 1) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Dynamic progress bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Container(
                    height: 4,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            ((_currentPage + 1) / 2), // Adjust for more pages
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Page content with PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildScreen(
                    title: "BIENVENUE CHEZ VOTRE FOURNISSEUR\nDAYMOND",
                    description:
                        "En tant que agent de vente daymond, nous nous engageons à vous fournir divers produits pour vos clients, et effectuer la livraison de vos commandes à travers cette plate-forme",
                    imagePath: 'assets/images/intro_one.png',
                  ),
                  _buildScreen(
                    title: "BIENVENUE CHEZ VOTRE FOURNISSEUR\nDAYMOND",
                    description:
                        "Ta mission est de recommander des produits Daymond à tes proches, ta famille, tes amis également à tes clients et tu gagne de l’argent sur chaque produits vendu",
                    imagePath: 'assets/images/intro_two.png',
                  ),
                ],
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Précédent button
                  if (_currentPage > 0)
                    Flexible(
                      child: GestureDetector(
                        onTap: _previousPage,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.grey, Colors.grey.shade400],
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_back, color: Colors.white),
                              SizedBox(width: 5),
                              Text(
                                "Précédent",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 100),

                  // Suivant button
                  Flexible(
                    child: GestureDetector(
                      onTap: _nextPage,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.pinkAccent],
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Suivant",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen({
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Column(
      children: [
        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Image
        Expanded(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            height: 100,
            width: 400,
          ),
        ),
      ],
    );
  }
}
