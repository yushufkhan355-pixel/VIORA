import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        title: const Text('ViewVerse Wallet', style: TextStyle(color: AppTheme.accent)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.4), blurRadius: 20)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Earnings', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('₹12,450', style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('~ 2,490,000 Valid Views', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _WalletAction(icon: Icons.send_to_mobile, label: 'UPI', onTap: (){}),
                _WalletAction(icon: Icons.account_balance_wallet, label: 'Paytm', onTap: (){}),
                _WalletAction(icon: Icons.currency_bitcoin, label: 'Binance', onTap: (){}),
              ],
            ),
            const SizedBox(height: 30),
            // Transaction History
            Align(
              alignment: Alignment.centerLeft,
              child: const Text('Recent Transactions', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: [
                  _TransactionTile(title: 'View Reward', amount: '+₹50', isCredit: true, time: '2 hours ago'),
                  _TransactionTile(title: 'Withdrawal (UPI)', amount: '-₹1000', isCredit: false, time: 'Yesterday'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _WalletAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _WalletAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: AppTheme.glassDecoration,
        child: Column(
          children: [
            Icon(icon, color: AppTheme.accent, size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String title;
  final String amount;
  final bool isCredit;
  final String time;

  const _TransactionTile({required this.title, required this.amount, required this.isCredit, required this.time});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward, color: isCredit ? Colors.green : Colors.redAccent),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(time, style: const TextStyle(color: AppTheme.textSecondary)),
      trailing: Text(amount, style: TextStyle(color: isCredit ? AppTheme.accent : Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}
