import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenify_front/models/userModel.dart';
import 'package:greenify_front/models/userTypeEnum.dart';
import 'package:provider/provider.dart';
import '../../models/userModel.dart';

class userTypeChoice extends StatefulWidget {
  const userTypeChoice({super.key});

  @override
  _userTypeChoiceState createState() => _userTypeChoiceState();
}

class _userTypeChoiceState extends State<userTypeChoice> {
  bool _isButtonDisabled = false;

  void _onContinue(BuildContext context) async {
    setState(() {
      _isButtonDisabled = true; // Disable button to prevent multiple clicks
    });

    try {
      final user = Provider.of<User>(context, listen: false);
      if (user.userType == null) {
        throw Exception('Please select a user type');
      }

      // Navigate to the next screen
      Navigator.pushNamed(context, '/donneesGenerales');
    } catch (e) {
      // Handle errors (e.g., show a snackbar)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isButtonDisabled = false; // Re-enable the button
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              // Top green bar
              Container(height: 100, color: Colors.green.shade700),
              const SizedBox(height: 100),

              // Farmer option card
              GestureDetector(
                onTap: () {
                  user.setUserType(UserTypeEnum.farmer);
                },
                child: OptionCard(
                  imagePath: 'assets/images/farmerIcon.png',
                  text: "Un agriculteur possédant une ferme",
                  isSelected: user.userType == 'farmer',
                ),
              ),
              const SizedBox(height: 70),

              // Employee option card
              GestureDetector(
                onTap: () {
                  user.setUserType(UserTypeEnum.employee);
                },
                child: OptionCard(
                  imagePath: 'assets/images/employeeIcon.png',
                  text: "Un employé cherchant un travail",
                  isSelected: user.userType == 'employee',
                ),
              ),
            ],
          ),

          // Continue button
          Positioned(
            left: 100,
            bottom: 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextButton(
                onPressed:
                    _isButtonDisabled ? null : () => _onContinue(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  user.userType == 'farmer'
                      ? "Continuer en tant qu’un agriculteur >"
                      : "Continuer en tant qu’un employé >",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  softWrap: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool isSelected;

  const OptionCard({
    super.key,
    required this.imagePath,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 180,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green.shade100 : Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Radio button icon
          Align(
            alignment: Alignment.topRight,
            child: Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: Colors.black,
              size: 40,
            ),
          ),

          // Custom image and text
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(imagePath, width: 50, height: 50),
                ),
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
