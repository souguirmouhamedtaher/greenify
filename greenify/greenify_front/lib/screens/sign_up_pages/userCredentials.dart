import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenify_front/controllers/userSignUpController.dart';
import 'package:greenify_front/models/userModel.dart';
import 'package:greenify_front/utils/helpers.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class userCredentials extends StatefulWidget {
  const userCredentials({super.key});

  @override
  State<userCredentials> createState() => _userCredentialsState();
}

class _userCredentialsState extends State<userCredentials> {
  String? _phoneError;
  final fk = GlobalKey<FormState>();
  final TextEditingController nc = TextEditingController();
  final TextEditingController fnc = TextEditingController();
  final TextEditingController bdc = TextEditingController();
  final TextEditingController pnc = TextEditingController();
  final h = Helpers();
  final usuc = userSignUpController();

  void validateForm() {
    setState(() {
      _phoneError = null;
    });
  }

  Future<void> collect() async {
    try {
      final user = Provider.of<User>(context, listen: false);
      final phoneExists = await usuc.checkPhoneNumberExists(pnc.text);
      if (fk.currentState!.validate() || phoneExists) {
        if (phoneExists) {
          setState(() {
            _phoneError = "Numero de telephone déja existant";
          });
        } else {
          user.setName(nc.text);
          user.setForeName(fnc.text);
          user.setBirthDate(DateFormat("dd/MM/yyyy").parse(bdc.text));
          user.setPhoneNumber(pnc.text);

          Navigator.pushNamed(context, '/userPassword');
        }
      }
    } catch (e) {
      setState(() {
        _phoneError = "Erreur: $e";
      });
    }
  }

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
          key: fk,
          onChanged: validateForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                "Données Générales",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: buildNameField("Nom", nc)),
                        SizedBox(width: 8),
                        Expanded(child: buildForeNameField("Prénom", fnc)),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Date de naissance",
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                    buildBirthDateField(),
                    SizedBox(height: 30),
                    buildPhoneNumberField(),
                    SizedBox(height: 80),
                    buildContinueButton(collect),
                  ],
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNameField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 20)),
        TextFormField(
          controller: controller,
          validator: h.validateName,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black, width: 5.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget buildForeNameField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 20)),
        TextFormField(
          controller: controller,
          validator: h.validateForeName,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.black, width: 5.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget buildContinueButton(Function collect) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          collect();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade700,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
    );
  }

  Widget buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Numéro de téléphone", style: GoogleFonts.poppins(fontSize: 20)),
        SizedBox(
          width: 300,
          child: TextFormField(
            controller: pnc,
            keyboardType: TextInputType.phone,
            maxLength: 8,
            validator: (value) {
              if (!Helpers.isPhoneNumberValid(value)) {
                return "Numéro invalide";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              counterText: "",
            ),
          ),
        ),
        if (_phoneError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8),
            child: Text(
              _phoneError!,
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget buildBirthDateField() {
    return SizedBox(
      width: 250,
      child: TextFormField(
        controller: bdc,
        validator: (value) => h.validateBirthDate(value),
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.black, width: 5.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            setState(() {
              bdc.text = DateFormat("dd/MM/yyyy").format(date);
            });
          }
        },
      ),
    );
  }
}
