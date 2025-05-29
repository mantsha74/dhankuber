import 'package:dhan_kuber/presentation/screens/home/components/trust_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../domain/models/fd_plan.dart';
import 'components/fd_overview_card.dart';
import 'components/fd_plan_card.dart';
import 'components/tenure_selector.dart';
import 'components/welcome_header.dart';
import 'home_viewmodel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<String> tenures = ['12M', '18M', '24M', '30M', '36M', '42M', '50M', '60M'];
  String selectedTenure = '18M';

  late final PageController _highlightPageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _highlightPageController = PageController(viewportFraction: 0.92);
  }

  @override
  void dispose() {
    _highlightPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("Error loading data: $e")),
          data: (data) {
            final fdPlans = data.fdPlans;
            final highlights = data.highlights;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Welcome Header
                  buildWelcomeHeader(context, "Investor", profileImageUrl: null),
                  const SizedBox(height: 12),

                  //ViewPager
                  Text("FD Opportunities", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 220,
                    child: PageView.builder(
                      controller: _highlightPageController,
                      itemCount: highlights.length,
                      onPageChanged: (index) => setState(() => _currentPage = index),
                      itemBuilder: (context, index) {
                        final item = highlights[index];
                        return FDOverviewCard(
                          investmentAmount: item.investmentAmount,
                          tenure: item.tenure,
                          estimatedReturn: item.estimatedReturn,
                          rate: item.rate,
                          bankName: item.bankName,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _highlightPageController,
                      count: highlights.length,
                      effect: WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 8,
                        activeDotColor: theme.colorScheme.primary,
                        dotColor: theme.colorScheme.primary.withOpacity(0.3),
                      ),
                    ),
                  ),

                  //Chips Tenure
                  const SizedBox(height: 20),
                  Text("Select FD Tenure", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 10),
                  TenureSelector(
                    tenures: tenures,
                    selectedTenure: selectedTenure,
                    onSelected: (value) {
                      setState(() => selectedTenure = value);
                    },
                  ),
                  const SizedBox(height: 20),

                  //Banks
                  Text("Available FD Plans", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: fdPlans.length,
                      itemBuilder: (context, index) {
                        return FDPlanCard(
                          plan: fdPlans[index],
                          selectedTenure: selectedTenure,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  TrustSection()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
