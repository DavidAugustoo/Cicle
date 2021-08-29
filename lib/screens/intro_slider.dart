import 'package:cicle/screens/login.dart';
import 'package:cicle/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

main() => runApp(IntroScreen());

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroScreen();
  }
}

class _IntroScreen extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Recicle",
        styleTitle: TextStyles.title,
        description:
            "Ajude a reduzir a pegada de carbono em nosso meio ambiente. Saiba o que, onde e como reciclar seus resíduos",
        styleDescription: TextStyles.subtitleslider,
        pathImage: "assets/Frame1.png",
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "Depósito de lixo",
        styleTitle: TextStyles.title,
        description:
            "Ajudamos a cuidar do destino final de seus resíduos por meio da coleta seletiva",
        styleDescription: TextStyles.subtitleslider,
        pathImage: "assets/Frame2.png",
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "Venda",
        styleTitle: TextStyles.title,
        description:
            "Seja recompensado por fazer sua parte, é uma vitória para todos",
        styleDescription: TextStyles.subtitleslider,
        pathImage: "assets/Frame3.png",
        backgroundColor: Colors.white,
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xff1FCC79),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xff1FCC79),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xff1FCC79),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0x331FCC79)),
      overlayColor: MaterialStateProperty.all<Color>(Color(0x331FCC79)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: this.renderNextBtn(),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot: Color(0x331FCC79),
      colorActiveDot: Color(0xff1FCC79),
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,
    );
  }
}
