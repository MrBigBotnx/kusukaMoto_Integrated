import 'package:flutter/material.dart';
import 'login_screen.dart';

class RecoverPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo Section
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Image.asset(
                  'assets/icons/kusuka.png',
                  width: 350,
                  height: 350,
                ),
              ),

              // Instruction Text
              Text(
                'Recupere a sua senha',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF070245), // rgb(7, 2, 69)
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),

              // Email Input Field with Icon
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email,
                      color: Color(0xFF201C58)), // rgb(32, 28, 88)
                  labelStyle: TextStyle(color: Color(0xFF070245)),
                  filled: true,
                  fillColor: Color(0xFFB7E3FE), // Light background for contrast
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Recover Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF201C58), // rgb(32, 28, 88)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    // Add recovery action here
                  },
                  icon: Icon(Icons.refresh, color: Colors.white),
                  label: Text(
                    'RECUPERAR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Login Navigation Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Já tem uma conta?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF070245),
                    ),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'fazer login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
