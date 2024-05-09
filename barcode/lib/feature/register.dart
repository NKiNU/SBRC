import 'package:barcodee/model/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
            return _buildMobileLayout();          
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/1.png',
                      width: 60,
                      height: 60,
                    ),
                    Text(
                      'RajaMark',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: SvgPicture.asset(
                        'images/examIllustration.svg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 700,
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Center(child: RegisterModule()),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
