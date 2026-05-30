import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  // ✅ Pre-filled
  final TextEditingController numberController = TextEditingController(
    text: "780026880",
  );

  final TextEditingController amountController = TextEditingController();

  final TextEditingController operatorController = TextEditingController(
    text: "Etisalat",
  );

  bool isLoading = false;

  // 🔔 Toast function (reusable)
  void showToast(String msg, Color color) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 14,
    );
  }

  Future<void> recharge() async {
    final url = Uri.parse(
      "https://hardwired-absurd-nibble.ngrok-free.dev/recharge",
    );

    // ✅ validation
    if (amountController.text.trim().isEmpty) {
      showToast("Enter amount", Colors.orange);
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "number": numberController.text.trim(),
          "amount": amountController.text.trim(),
          "operator": operatorController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (data['status'] == "duplicate") {
        showToast("Duplicate Request!", Colors.orange);
      } else {
        showToast("Success! TXN: ${data['txn_id']}", Colors.green);
      }
    } catch (e) {
      showToast("Error: $e", Colors.red);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    numberController.dispose();
    amountController.dispose();
    operatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recharge")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔢 Number
            TextField(
              controller: numberController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // 💰 Amount
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // 📡 Operator
            TextField(
              controller: operatorController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Operator",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // 🚀 Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : recharge,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Recharge Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
