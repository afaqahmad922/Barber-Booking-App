import 'package:barberbookingapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingUser extends StatefulWidget {
  const BookingUser({super.key});

  @override
  State<BookingUser> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingUser> {
  Stream? BookingStream;

  getontheload()async{
    BookingStream= await DatabaseMethods().getBookings();
    setState(() {

    });
  }

  Widget allBookings() {
    return StreamBuilder(
      stream: BookingStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    colors: [Colors.blueGrey, Colors.blue],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          ds["image"],
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Service: " +ds["Service"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Name: "+ds["Username"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Date: "+ds["Date"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Time: "+ds["Time"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
            );
          },
        )
            : Container();
      },
    );
  }

  @override
  @override
  void initState() {
    getontheload();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "All Bookings",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(child: allBookings()),
          ],
        ),
      ),
    );
  }
}
