import 'package:flutter/material.dart';
// import 'login_screen.dart'; // Removed for testing

// A simple data model for the content of each onboarding page
class OnboardingInfo {
  final String image;
  final String title;
  final String description;

  OnboardingInfo({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // List of content for each onboarding page
  final List<OnboardingInfo> _onboardingData = [
    OnboardingInfo(
      image: 'assets/images/onboarding_illustration1.png',
      title: 'Your Smart EV Charging Partner',
      description:
          'Get ready to charge smarter. Find nearby stations, monitor charging status, and power your ride with ease. Let\'s get started!',
    ),
    OnboardingInfo(
      image: 'assets/images/onboarding_illustration2.png',
      title: 'Find Charging Stations Near You',
      description:
          'Quickly locate the nearest EV charging stations anytime, anywhere. Your next charge is just a tap away!',
    ),
    OnboardingInfo(
      image: 'assets/images/onboarding_illustration3.png',
      title: 'Seamless Booking & Payments',
      description:
          'Book your charging slot in advance and pay securely within the app for a hassle-free experience.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Function to handle navigation to the main app
  void _navigateToNextScreen() {
    // This is now a placeholder. It will print to the debug console.
    print("Navigate to Login/Home Screen");
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isLastPage = _currentPage == _onboardingData.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // The swipeable pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _onboardingData[index];
                  return OnboardingPageContent(
                    image: item.image,
                    title: item.title,
                    description: item.description,
                  );
                },
              ),
            ),

            // The controls at the bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Column(
                children: [
                  // Page indicator dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: PageIndicatorDot(isActive: index == _currentPage),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Action buttons: Skip and Continue
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _navigateToNextScreen,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color(0xFFE8F5E9), // Light green
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF388E3C), // Dark green
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (isLastPage) {
                              _navigateToNextScreen();
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color(0xFF4CAF50), // Main green
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            isLastPage ? 'Get Started' : 'Continue',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// A reusable widget for the content of a single onboarding page
class OnboardingPageContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPageContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Give the image a large, flexible space
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 8.0, right: 8.0),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        // Give the text content a smaller, fixed space
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// A helper widget for the page indicator dots to keep the code clean
class PageIndicatorDot extends StatelessWidget {
  final bool isActive;
  const PageIndicatorDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isActive ? 24 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4CAF50) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
