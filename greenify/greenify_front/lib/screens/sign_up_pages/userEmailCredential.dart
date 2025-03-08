import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenify_front/models/userModel.dart';
import 'package:greenify_front/services/otpService.dart';
import 'package:greenify_front/utils/helpers.dart';
import 'package:provider/provider.dart';

class userEmailCredential extends StatefulWidget {
  const userEmailCredential({super.key});

  @override
  State<userEmailCredential> createState() => _userEmailCredentialState();
}

class _userEmailCredentialState extends State<userEmailCredential> {
  final TextEditingController ec = TextEditingController();
  final GlobalKey<FormState> fk = GlobalKey<FormState>();
  String emailError = "";
  bool emailVerified = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'Messagerie',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                  color: Colors.green.shade700,
                ),
              ),
              Container(
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "Adresse Email",
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                    TextFormField(
                      controller: ec,
                      validator: Helpers().validateEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 5.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        suffixIcon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 10),
                    buildVerificationBar(emailVerified),
                    const SizedBox(height: 30),
                    Container(
                      child: Text(
                        "Vous allez recevoir un code de 4 numéros sur cet email",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 200),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: emailVerified ? sendOTP : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          "Verifier >",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
      ),
    );
  }

  Widget buildVerificationBar(bool v) {
    return (Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Container(
        width: 300,
        height: 10,
        decoration: BoxDecoration(
          color: v ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ));
  }

  void validateForm() {
    if (fk.currentState!.validate()) {
      setState(() {
        emailVerified = true;
      });
    } else {
      setState(() {
        emailVerified = false;
      });
    }
  }

  Future<void> sendOTP() async {
    final String email = ec.text;
    final user = Provider.of<User>(context, listen: false);
    final phoneNumber = user.getPhoneNumber();
    try {
      await otpService.sendOTP(email, phoneNumber!);
    } catch (e) {
      print(e);
    }
  }
}
