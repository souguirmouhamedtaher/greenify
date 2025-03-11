import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenify_front/controllers/userSignUpController.dart';
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
                      onChanged: (value) => validateEmail(),
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
                    const SizedBox(height: 30),
                    Text(
                      emailError,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
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

  void initState() {
    super.initState();
    ec.addListener(validateEmail);
  }

  void validateEmail() {
    if (Helpers().validateEmail(ec.text) == null) {
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
    final String? phoneNumber =
        user.phoneNumber; // Get the phone number from the user object

    try {
      // Check if the email already exists
      bool exists = await userSignUpController().checkEmailExists(email);
      if (exists) {
        setState(() {
          emailError = "Cet adresse est déjà utilisée !";
        });
        return;
      }

      setState(() {
        emailError = "";
      });

      // Store the user without the email
      bool userCreated = await userSignUpController().signUpUserWithoutEmail(
        user.toJson(),
      );

      if (!userCreated) {
        setState(() {
          emailError = "Échec de l'inscription. Veuillez réessayer.";
        });
        return;
      }

      // Generate OTP
      String otp = OTPService().generateOTP();
      DateTime expirationTime = DateTime.now().add(Duration(minutes: 5));

      // Store OTP in the backend
      bool stored = await OTPService().storeOTP(
        email,
        otp,
        expirationTime,
        phoneNumber!,
      );

      if (stored) {
        // Send OTP to the user's email
        bool otpSent = await OTPService().sendOTP(email, otp);

        if (otpSent) {
          // Navigate to the OTP verification screen
          Navigator.pushNamed(context, '/userEmailVerification');
        } else {
          setState(() {
            emailError = "Échec de l'envoi du OTP. Veuillez réessayer.";
          });
        }
      } else {
        setState(() {
          emailError = "Échec de l'enregistrement du OTP. Veuillez réessayer.";
        });
      }
    } catch (e) {
      setState(() {
        emailError = "Une erreur s'est produite. Veuillez réessayer.";
      });
      print("Error in sendOTP: $e");
    }
  }
}
