import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api_client.dart';
import '../../core/theme.dart';

class _Plan {
  final String id;
  final String name;
  final String duration;
  final int price;
  final List<String> features;
  final bool popular;

  const _Plan({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.features,
    this.popular = false,
  });
}

const _kFallbackPlans = [
  _Plan(
    id: 'basic',
    name: 'Basic Plan',
    duration: '7 Days',
    price: 15,
    features: [
      'Unlimited Planning',
      'Full Map Access',
      'Smart AI Suggestions',
      'Forum Access',
    ],
  ),
  _Plan(
    id: 'premium',
    name: 'Premium Plan',
    duration: '14 Days',
    price: 25,
    features: [
      'Unlimited Planning',
      'Full Map Access',
      'Smart AI Suggestions',
      'Premium Features',
      'Forum Access',
    ],
    popular: true,
  ),
  _Plan(
    id: 'pro',
    name: 'Pro Plan',
    duration: '30 Days',
    price: 39,
    features: [
      'Unlimited Planning',
      'Full Map Access',
      'Smart AI Suggestions',
      'Premium Features',
      'Priority Support',
    ],
  ),
];

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  int _selectedPlan = 1;
  bool _showPayment = false;
  bool _isLoadingPlans = true;

  List<_Plan> _plans = [];

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    try {
      setState(() => _isLoadingPlans = true);

      final response = await ApiClient.get('/purchase/plans');
      final data = response['data'];

      if (data is List && data.isNotEmpty) {
        _plans = data.map<_Plan>((item) {
          final featuresRaw = item['features'];

          return _Plan(
            id: item['id']?.toString() ?? item['code']?.toString() ?? '',
            name: item['name']?.toString() ?? 'Plan',
            duration: item['duration']?.toString() ?? '',
            price: int.tryParse(item['price']?.toString() ?? '0') ?? 0,
            features: featuresRaw is List
                ? featuresRaw.map((e) => e.toString()).toList()
                : <String>[],
            popular: item['popular'] == true,
          );
        }).toList();

        if (_selectedPlan >= _plans.length) {
          _selectedPlan = 0;
        }
      } else {
        _plans = List.from(_kFallbackPlans);
      }
    } catch (e) {
      debugPrint('LOAD PLANS ERROR: $e');
      _plans = List.from(_kFallbackPlans);
    } finally {
      if (mounted) {
        setState(() => _isLoadingPlans = false);
      }
    }
  }

  _Plan get _currentPlan {
    final plans = _plans.isEmpty ? _kFallbackPlans : _plans;
    return plans[_selectedPlan];
  }

  @override
  Widget build(BuildContext context) {
    final plans = _plans.isEmpty ? _kFallbackPlans : _plans;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          _showPayment ? 'Payment Information' : 'Complete Your Purchase',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_showPayment) {
              setState(() => _showPayment = false);
            } else {
              context.canPop() ? context.pop() : context.go('/home');
            }
          },
        ),
      ),
      body: _isLoadingPlans
          ? const Center(child: CircularProgressIndicator())
          : _showPayment
              ? _PaymentForm(
                  plan: _currentPlan,
                  onBack: () => setState(() => _showPayment = false),
                )
              : _PlanSelection(
                  plans: plans,
                  selectedPlan: _selectedPlan,
                  onSelect: (i) => setState(() => _selectedPlan = i),
                  onContinue: () => setState(() => _showPayment = true),
                ),
    );
  }
}

class _PlanSelection extends StatelessWidget {
  final List<_Plan> plans;
  final int selectedPlan;
  final ValueChanged<int> onSelect;
  final VoidCallback onContinue;

  const _PlanSelection({
    required this.plans,
    required this.selectedPlan,
    required this.onSelect,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Text(
            'Choose a plan and unlock your personalized travel experience',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(plans.length, (i) {
                final plan = plans[i];
                final isSelected = selectedPlan == i;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => onSelect(i),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              isSelected ? AppTheme.primary : AppTheme.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          if (plan.popular)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: const BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Most Popular',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          else
                            const SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plan.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  plan.duration,
                                  style: const TextStyle(
                                    color: AppTheme.textMuted,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: AppTheme.textPrimary,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '\$${plan.price}',
                                        style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: ' /trip',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: AppTheme.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ...plan.features.map(
                                  (f) => Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          size: 13,
                                          color: AppTheme.primary,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            f,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: AppTheme.textMuted,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: isSelected
                                      ? ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppTheme.primary,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Text(
                                            'Selected',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        )
                                      : OutlinedButton(
                                          onPressed: () => onSelect(i),
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Text(
                                            'Select Plan',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onContinue,
              icon: const Icon(Icons.credit_card, size: 18),
              label: Text(
                'Continue to Payment - \$${plans[selectedPlan].price}',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PaymentForm extends StatefulWidget {
  final _Plan plan;
  final VoidCallback onBack;

  const _PaymentForm({
    required this.plan,
    required this.onBack,
  });

  @override
  State<_PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<_PaymentForm> {
  final _cardNumberCtrl = TextEditingController();
  final _cardNameCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPaying = false;

  @override
  void dispose() {
    _cardNumberCtrl.dispose();
    _cardNameCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  Future<void> _completePurchase() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    try {
      setState(() => _isPaying = true);

      await ApiClient.post(
        '/purchase/checkout',
        body: {
          'planId': widget.plan.id,
          'planName': widget.plan.name,
          'amount': widget.plan.price,
          'currency': 'USD',
          'paymentMethod': {
            'type': 'card',
            'last4': _cardNumberCtrl.text
                .replaceAll(' ', '')
                .replaceAll('-', '')
                .substring(
                  (_cardNumberCtrl.text
                              .replaceAll(' ', '')
                              .replaceAll('-', '')
                              .length -
                          4)
                      .clamp(0, 999),
                ),
            'cardholderName': _cardNameCtrl.text.trim(),
          },
        },
      );

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: AppTheme.success, size: 56),
              SizedBox(height: 12),
              Text(
                'Purchase Successful!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Your plan is now active. Enjoy your trip!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textMuted),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.pop(true);
                },
                child: Text('Go to Home'),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppTheme.destructive,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isPaying = false);
      }
    }
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.credit_card, color: AppTheme.primary, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Payment Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Card Number',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _cardNumberCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '1234 5678 9012 3456',
                    ),
                    validator: _required,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Cardholder Name',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _cardNameCtrl,
                    decoration: const InputDecoration(hintText: 'John Doe'),
                    validator: _required,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Expiry Date',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _expiryCtrl,
                              decoration:
                                  const InputDecoration(hintText: 'MM/YY'),
                              validator: _required,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CVV',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _cvvCtrl,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              decoration: const InputDecoration(hintText: '123'),
                              validator: _required,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 16,
                          color: AppTheme.textMuted,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'This is a demo payment. Do not enter real card information.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: _isPaying ? null : widget.onBack,
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text('Back'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isPaying ? null : _completePurchase,
                    icon: _isPaying
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.credit_card, size: 18),
                    label: Text(
                      _isPaying
                          ? 'Processing...'
                          : 'Complete Purchase - \$${widget.plan.price}',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}