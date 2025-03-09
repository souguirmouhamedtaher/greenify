import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenify_front/models/userModel.dart';
import 'package:greenify_front/utils/helpers.dart';
import 'package:provider/provider.dart';

class userPassword extends StatefulWidget {
  const userPassword({super.key});

  @override
  State<userPassword> createState() => _userPasswordState();
}

class _userPasswordState extends State<userPassword> {
  final fk = GlobalKey<FormState>();
  final TextEditingController pwc = TextEditingController();
  final TextEditingController cpwc = TextEditingController();

  bool isVisiblePw = false;
  bool isLengthSup18 = false;
  bool hasUpperChar = false;
  bool hasLowerChar = false;
  bool hasDigit = false;
  bool isEqual = false;

  void verifyPw() {
    String value = pwc.text;

    setState(() {
      isLengthSup18 = Helpers.hasPasswordMinimumLength(value);
      hasUpperChar = Helpers.hasPasswordUpperCase(value);
      hasLowerChar = Helpers.hasPasswordLowerCase(value);
      hasDigit = Helpers.hasPasswordDigit(value);
      isEqual = cpwc.text == value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: fk,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                "Données de compte",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                  color: Colors.green.shade700,
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "Mot de passe",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                      buildPwField(
                        pwc,
                        Helpers().validatePassword(pwc.text)
                            as String? Function(String? p1),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          buildV(isLengthSup18),
                          SizedBox(width: 10),
                          buildV(hasUpperChar),
                          SizedBox(width: 10),
                          buildV(hasLowerChar),
                          SizedBox(width: 10),
                          buildV(hasDigit),
                        ],
                      ),
                      buildMissingConstraints(),
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "Confirmer le mot de passe",
                          style: GoogleFonts.poppins(fontSize: 20),
                        ),
                      ),
                      buildPwField(
                        cpwc,
                        verifyPw as String? Function(String? p1),
                      ),
                      SizedBox(height: 10),
                      buildVC(isEqual),
                      SizedBox(height: 50),
                      Center(
                        child: ElevatedButton(
                          onPressed: setUpPassword,
                          child: Text("Continuer"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 20,
                            ),
                            textStyle: GoogleFonts.poppins(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setUpPassword() {
    if (isEqual && isLengthSup18 && hasDigit && hasLowerChar && hasUpperChar) {
      final user = Provider.of<User>(context, listen: false);
      user.setPassword(Helpers().encodePassword(pwc.text));
      Navigator.pushNamed(context, '/userEmailChoice');
    }
  }

  Widget buildMissingConstraints() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        "Le mot de passe doit contenir au moins 8 caractères, une lettre majuscule, une lettre minuscule et un chiffre",
        style: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
      ),
    );
  }

  Widget buildPwField(TextEditingController c, String? Function(String?) v) {
    return TextFormField(
      controller: c,
      obscureText: !isVisiblePw,
      decoration: InputDecoration(
        hintText: "Mot de passe",
        suffixIcon: IconButton(
          icon: Icon(isVisiblePw ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isVisiblePw = !isVisiblePw;
            });
          },
        ),
      ),
      validator:
          (v) =>
              v!.isEmpty
                  ? "Champ obligatoire"
                  : c.text.length < 8
                  ? "Le mot de passe doit contenir au moins 8 caractères"
                  : null,
    );
  }

  Widget buildV(bool t) {
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Container(
        width: 55,
        height: 10,
        decoration: BoxDecoration(
          color: t ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildVC(bool t) {
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Container(
        width: 300,
        height: 10,
        decoration: BoxDecoration(
          color: t ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
