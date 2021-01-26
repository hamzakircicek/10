import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/arkadaslar.dart';
import 'package:flutter_app/istekGonderme.dart';
import 'package:flutter_app/profilim2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
class dty extends StatefulWidget {
  var url;
  String ad;
  String aciklama;
  String fiyat;
  String lokasyon;
  String pp;
  String kullanici;
  String docId;
  String uid;
  String email;

  dty({this.url,this.ad,this.aciklama,this.fiyat,this.lokasyon,this.pp,this.kullanici,this.docId,this.uid,this.email});
  @override
  _dtyState createState() => _dtyState();
}
FirebaseAuth _auth=FirebaseAuth.instance;
FirebaseFirestore _firestore=FirebaseFirestore.instance;
int sayac=1;
class _dtyState extends State<dty> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
            children:[


              Material(
                child: Container(
                width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.url),fit: BoxFit.cover,
                    )
                  ),
            child: BackdropFilter(
                 filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
            )
            ),
              ),


      Positioned(
        top:40, left: 30,
        child: Material(
          elevation: 25,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: 330,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(widget.url),fit: BoxFit.cover,
                )
            ),
            child: Stack(
              children: [
                Container(
                  height: 55,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius
                        .circular(10),
                    gradient: LinearGradient(
                        begin: FractionalOffset
                            .topCenter,
                        end: FractionalOffset
                            .bottomCenter,
                        colors: [
                          Colors
                              .black,
                          Colors
                              .transparent
                        ]

                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (widget.uid ==
                          _auth
                              .currentUser
                              .uid) {
                        Navigator
                            .push(
                            context,
                            MaterialPageRoute(
                                builder: (
                                    context) =>
                                    profilim()));
                      } else {
                        Navigator
                            .push(
                            context,
                            MaterialPageRoute(
                                builder: (
                                    context) =>
                                    profilark(
                                      pp:  widget.pp,
                                      email: widget.email,
                                      uid: widget.uid,
                                      kuladi: widget.kullanici,)));
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets
                              .all(7),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.pp
                                ),
                                fit: BoxFit
                                    .cover
                            ),
                            color: Colors
                                .white,
                            borderRadius: BorderRadius
                                .circular(
                                60),
                          ),

                        ),
                        SizedBox(
                            width: 5),
                        Container(
                          width: 100,
                          child: Row(
                            children: [
                              Flexible(
                                  child: RichText(
                                    overflow: TextOverflow
                                        .ellipsis,
                                    strutStyle: StrutStyle(
                                        fontSize: 12.0),
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors
                                                .white),
                                        text: widget.kullanici),
                                  )

                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

              Positioned(
                top: 455,


                  child: Padding(

                    padding: const EdgeInsets.only(left:10,right: 10),
                    child: Material(
                      color: Colors.white,
    borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(


                          width: MediaQuery.of(context).size.width-40,
                          height: 150,

                          decoration: BoxDecoration(

                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: ListView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15,),
                                  Text("Ürün Sahibi:  "+widget.kullanici,style: GoogleFonts.comfortaa(fontSize: 15, decoration: TextDecoration.none,color: Colors.blueGrey ),),
                                  SizedBox(height: 5,),
                                  Divider(height: 5,),
                                  SizedBox(height: 5,),
                                  Text("Ürün Adı:  "+widget.ad,style: GoogleFonts.comfortaa(fontSize: 15, decoration: TextDecoration.none,color: Colors.blueGrey ),),
                                  SizedBox(height: 5,),
                                  Divider(height: 5,),
                                  SizedBox(height: 5,),

                                  Text("Ürün Açıklaması:  "+widget.aciklama,style: GoogleFonts.comfortaa(fontSize: 15, decoration: TextDecoration.none,color: Colors.blueGrey),),
                                  SizedBox(height: 5,),
                                  Divider(height: 5,),
                                  SizedBox(height: 5,),
                                  Text("Ürün Fiyatı:  "+widget.fiyat+" TL",style: GoogleFonts.comfortaa(fontSize: 15, decoration: TextDecoration.none,color: Colors.blueGrey),),
                                  SizedBox(height: 5,),
                                  Divider(height: 5,),
                                  SizedBox(height: 5,),
                                  Text("Ürünün Bulunduğu Yer:  "+widget.lokasyon,style: GoogleFonts.comfortaa(fontSize: 15, decoration: TextDecoration.none,color: Colors.blueGrey),),
                                  SizedBox(height: 10,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),


              ),
              Positioned(
                  top: 390,
                  left: 120,
                  child: Row(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          onTap: (){
                            sepet(
                                widget.uid,
                                widget.email,
                                widget.pp,
                                widget.kullanici,
                                widget.ad,
                                widget.docId,
                                widget.url,
                                widget.aciklama,
                                widget.lokasyon,
                                widget.fiyat);
                            Toast.show(
                                "Ürün Sepete Eklendi",
                                context,
                                duration: Toast
                                    .LENGTH_LONG,
                                gravity: Toast
                                    .BOTTOM);
                          },
                          child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                          color: Colors.lightBlue.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(50),
                ),
                            child: Icon(Icons.add_shopping_cart,color: Colors.white,),
              ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (
                                      context) =>
                                      istekGonder(
                                        karsiPp: widget.pp,
                                        url: widget.url,
                                        kullanici: widget.kullanici,
                                        aciklama: widget.aciklama,
                                        fiyat: widget.fiyat,
                                        ad: widget.ad,
                                        lokasyon: widget.lokasyon,
                                        uid: widget.uid,
                                        docId:widget.docId)));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  )),

            ]
        ),

    );
  }
  void sepet(String uid, String email, String pp, String kulad, String ad,
      String doc, var res, String aciklama, String lokasyon,
      String fiyat) async {
    try {
      Map<String, dynamic> aktar = Map();
      aktar['uid'] = uid;
      aktar['pp'] = pp;
      aktar['email'] = email;
      aktar['kullanici'] = kulad;
      aktar['ad'] = ad;
      aktar['resim'] = res;
      aktar['aciklama'] = aciklama;
      aktar['lokasyon'] = lokasyon;
      aktar['fiyat'] = fiyat;

      await _firestore.collection(_auth.currentUser.uid).doc().set(
          aktar, SetOptions(merge: true));
    }
    catch (e) {
      debugPrint(e);
    }
  }
}

