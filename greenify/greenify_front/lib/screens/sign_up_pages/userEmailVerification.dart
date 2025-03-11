import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class userEmailVerification extends StatefulWidget {
  const userEmailVerification({super.key});

  @override
  State<userEmailVerification> createState() => _userEmailVerificationState();
}

class _userEmailVerificationState extends State<userEmailVerification> {
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "Un code de vérification est",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                      color: Colors.green.shade700,
                    ),
                  ),
                  Text(
                    "envoyé sur votre messagerie",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Saisir le code envoyé sous forme de 4 numéros",
                    style: GoogleFonts.poppins(fontSize: 10),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return (SizedBox(
                        width: 60,
                        child: TextFormField(
                          controller: otpController[index],
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 5,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              forwardFocus(index, context);
                            }
                            if (value.isEmpty) {
                              backwardFocus(index, context);
                            }
                          },
                        ),
                      ));
                    }),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Temps restant avant l'expiration de code",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "$minutes:$seconds",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: cd <= 60 ? Colors.red : Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "N'avez pas reçue un code ?",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: resendOTP,
                    child: Text(
                      "Renvoyer",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.green.shade700,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  if (verificationMessage != null)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        verificationMessage!,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color:
                              verificationMessage!.contains('error')
                                  ? Colors.red
                                  : Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: isLoading ? null () => verifyOTP(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        ),
                        child: isLoading ?  CircularProgressIndicator(color: Colors.white,) :Text(
                          "Verifier >",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void forwardFocus(int index,BuildContext context){
    index>0 ? FocusScope.of(context).previousFocus() : FocusScope.of(context).unfocus(); 
  }
  void backwardFocus(int index,BuildContext context){
    index<3 ? FocusScope.of(context).nextFocus() : FocusScope.of(context).unfocus();

  }

  
}
