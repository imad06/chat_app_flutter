import "package:chaty/services/auth/auth_service.dart";
import "package:flutter/material.dart";
import "package:chaty/components/my_textfeild.dart";
import "package:chaty/components/my_button.dart";

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();

  void register(BuildContext context) {
    final _auth = AuthService();
    if (_pwController.text == _pwConfirmController.text) {
     try{
      _auth.signUpWithEmailAndPassword(
      _nameController.text,
      _emailController.text,
      _pwController.text,
    );
     }catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
     
    }
    }
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Passwords do not match!"),
        ),
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),
            Text(
              "Let's create an account for you!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 50),
            // email textfield

            MyTextfeild(
              hintText: "Name",
              obscureText: false,
              controller: _nameController,

            ),
            const SizedBox(height: 10),
            MyTextfeild(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            // password textfield
            MyTextfeild(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
            ),
            const SizedBox(height: 10),
            // password confirmation textfield  
            MyTextfeild(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _pwConfirmController,
            ),    
            const SizedBox(height: 25),
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onTap, // <-- Correction ici
                  child: Text(
                    " Login now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}