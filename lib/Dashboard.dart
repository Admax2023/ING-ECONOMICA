import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pro0030/Amortizacion.dart';
import 'package:pro0030/Anualidad.dart';
import 'package:pro0030/Capitalizacion.dart';
import 'package:pro0030/InteresCompuesto.dart';
import 'package:pro0030/InteresSimple.dart';
import 'package:pro0030/Tir.dart';

class Dashboard extends StatelessWidget {
  var height, width;

  List imgData = [
    "assets/1.png",
    "assets/2.png",
    "assets/3.png",
    "assets/4.png",
    "assets/5.png",
    "assets/6.png",
  ];

  List titles = [
    "Interes simple",
    "Interes Compuesto",
    "Anualidades",
    "Tasa de interes de retorno",
    "Capitalizacion",
    "Amortizacion",
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(116, 108, 175, 238),
          width: width,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                height: height * 0.23,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 35,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.menu, color: Colors.white),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 35,
                                  left: 20,
                                  right: 100,
                                ),
                              ),
                              TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.person, color: Colors.white),
                                  label: Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  )),
                            ],
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            // Coloca un color para visualizar el contenedor
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 30,
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ingenieria Economica",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 245, 245, 245),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                    ),
                  ),
                  //height: height, // No necesitas establecer altura si usas Expanded
                  width: width,
                  padding: EdgeInsets.only(bottom: 20),
                  child: GridView.builder(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 25),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: imgData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InteresSimple(),
                                ),
                              );
                              break;
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      InterestCalculatorPage(),
                                ),
                              );
                              break;
                            case 2:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AnualidadesPage(),
                                ),
                              );
                              break;

                            case 3:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TirCalculatorPage(),
                                ),
                              );
                              break;

                            case 4:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CapitalizationCalculator(),
                                ),
                              );
                              break;

                            case 5:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AmortizationCalculator(),
                                ),
                              );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.zero,
                            color: Color.fromARGB(255, 58, 103, 163),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                imgData[index],
                                width: 80,
                              ),
                              Text(
                                titles[index],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
