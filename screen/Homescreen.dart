import 'package:flutter/material.dart';
import 'package:weather_app/screen/stateman.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  @override
  void initState() {
    super.initState();
    final det=context.read<Stateman>();
    det.location();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Stateman>(builder: (context,value,child)=>
        Scaffold(
          appBar: AppBar(
            title: Text(value.loc.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins'
              ),),
            backgroundColor: Colors.amberAccent,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: new BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(25.00),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(value.date.toString(),
                        style: TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600
                        )),
                  ),
                ),
                Text(value.key.toString(),
                  style: TextStyle(
                      fontSize:20,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Text('${value.temp.toString()}°',
                  style: TextStyle(
                    fontSize: 135,
                    fontFamily: 'Poppins',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Daily summary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text('Apparent tempaerature is ${value.apparenttemp.toString()}',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontWeight:FontWeight.w500,
                      ),),
                    Text(value.weather.toString(),
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight:FontWeight.w500,
                        )),
                    Text('Temperature is ${value.temp.toString()}${value.unit.toString()}',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight:FontWeight.w500,)
                    ),
                    Text('Now it seems that ${value.apparenttemp.toString()} but actually ${value.temp.toString()}',
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight:FontWeight.w500,)
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      width: 350,
                      height: 150,
                      decoration: new BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15.00),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.water,
                                color: Colors.amberAccent,
                                size: 60.0,
                              ),
                              Text('${value.wind.toString()} km/h',
                                style: TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 15,
                                ),
                              ),
                              Text("Wind",
                                style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 15
                                ),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.water_drop_outlined,
                                color: Colors.amberAccent,
                                size: 60.0,
                              ),
                              Text('${value.humidity.toString()} %',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.amberAccent,
                                ),),
                              Text("Humidity",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.amberAccent,
                                ),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.filter_hdr_outlined,
                                color: Colors.amberAccent,
                                size: 60.0,
                              ),
                              Text("${value.ele.toString()} m",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.amberAccent
                                ),),
                              Text("Elevation",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.amberAccent,
                                ),)
                            ],
                          ),
                        ],
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Weekly Forecast",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          )),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
                  child: SizedBox(
                    height: 150,
                    child: CarouselView(
                        itemExtent: 100,
                        children:List.generate(7, (int index){
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.amberAccent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 5,
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${value.dailydate[index]}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),),
                                Text('${value.dailytemp[index].toString()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                    ),
                  ),
                )
              ],
            ),
          ),
          backgroundColor: Colors.amberAccent,
        ),
    );
  }
}