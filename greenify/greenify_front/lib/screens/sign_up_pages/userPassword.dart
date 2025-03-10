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
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.warning, color: Colors.red),
                        onPressed: () {
                          showPasswordRequirements(context);
                        },
                      ),
                    ),
                    Padding(
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
                          buildPwField(pwc),
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
                          SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "Confirmer le mot de passe",
                              style: GoogleFonts.poppins(fontSize: 20),
                            ),
                          ),
                          buildPwField(cpwc),
                          SizedBox(height: 10),
                          buildVC(isEqual),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed:
                            (isLengthSup18 &&
                                    hasUpperChar &&
                                    hasLowerChar &&
                                    hasDigit &&
                                    isEqual)
                                ? setUpPassword
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          "Continuer >",
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

  void showPasswordRequirements(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Exigences du mot de passe",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.green.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Le mot de passe doit contenir:\n\n"
            "- Au moins 8 caractères \n"
            "- Une lettre majuscule [A...Z] \n"
            "- Une lettre minuscule [a...z] \n"
            "- Un chiffre [0...9]",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("ok"),
            ),
          ],
        );
      },
    );
  }

  void setUpPassword() {
    if (isEqual && isLengthSup18 && hasDigit && hasLowerChar && hasUpperChar) {
      final user = Provider.of<User>(context, listen: false);
      user.setPassword(Helpers().encodePassword(pwc.text));
      Navigator.pushNamed(context, '/userEmailChoice');
    }
  }

  Widget buildPwField(TextEditingController c) {
    return TextFormField(
      controller: c,
      obscureText: !isVisiblePw,
      onChanged: (value) {
        verifyPw();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.black, width: 5.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(isVisiblePw ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isVisiblePw = !isVisiblePw;
            });
          },
        ),
      ),
      validator: (value) => Helpers().validatePassword(value),
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
