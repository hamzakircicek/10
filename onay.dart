import 'package:flutter/material.dart';
import 'package:flutter_app/profilim2.dart';
import 'dart:io';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/detay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'arkadaslar.dart';
import 'bottom.dart';
import 'profil.dart';
class onay extends StatefulWidget {
  String url;
  String aciklama;
  String gonderenAd;
  String gunSayisi;
  String lokasyon;
  String kullanici;
  String sahipUid;
  String docAl;
  var docId;
  bool onayDurumu=false;

  onay({this.url,this.aciklama,this.gonderenAd,this.gunSayisi,this.lokasyon,this.docId,this.sahipUid});
  @override
  _onayState createState() => _onayState();
}
FirebaseFirestore _firestore=FirebaseFirestore.instance;
FirebaseAuth _auth=FirebaseAuth.instance;

class _onayState extends State<onay> {
  bool _gormeDurumu=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('istekler').where("docId", isEqualTo: widget.docId ).where("kullanici",isEqualTo: widget.gonderenAd).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.data == null) return CircularProgressIndicator();
          return SingleChildScrollView(
              child: Column(
                  children:
              snapshot.data.docs.map((doc) => Column(
                children: [
                  Container(
                    height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        doc['resim']
                      ),fit: BoxFit.cover
                    )
                  ),
          ),
                    SizedBox(height: 25,),
                    InkWell(
                        onTap: (){
                          Navigator
                              .push(
                              context,
                              MaterialPageRoute(
                                  builder: (
                                      context) =>
                                      profilark(
                                        pp:  doc['pp'],
                                        email: doc['email'],
                                        uid: doc['uid'],
                                        kuladi: doc['kullanici'],)));
                        },
                        child: Text('Kiralama İsteği Gönderen: '+doc['kullanici'],style: GoogleFonts.comfortaa(fontSize: 14,color: Colors.black),)),
                  SizedBox(height: 5,),
                  Divider(height: 5,),
                  SizedBox(height: 5,),
                  Text('Kiralamak İstediği Gün Sayısı: '+doc['gunSayisi'],style: GoogleFonts.comfortaa(fontSize: 14,color: Colors.black),),
                  SizedBox(height: 5,),
                  Divider(height: 5,),
                  SizedBox(height: 5,),
                  Text('Toplam Fiyat: '+doc['fiyat']+" TL",style: GoogleFonts.comfortaa(fontSize: 14,color: Colors.black),),
                  SizedBox(height: 5,),
                  Divider(height: 5,),
                  SizedBox(height: 20,),
                  if(doc['istekDurumu']==true)
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          _firestore.collection('istekler').doc(doc.id).delete();
                          Toast.show("İstek Reddedildi", context, duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                          setState(() {
                            widget.onayDurumu=false;
                            widget.docAl=doc.id.toString();
                            DocumentReference docRef= FirebaseFirestore.instance.collection('istekler').doc(doc.id);
                            Map<String, dynamic> aktar= Map();

                            aktar['istekDurumu']=false;
                            docRef.set(aktar, SetOptions(merge: true));
                          });
                          bildirim(doc['karsiPp'],doc['pp'],_auth.currentUser.displayName,_gormeDurumu,widget.onayDurumu, widget.sahipUid, doc['uid'], doc['sahipAd'],widget.docAl+doc['uid'],false);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>bottom()));
                        },
                        child: Container(
                          width: 130,
                          height: 35,
                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [ Colors.red,Colors.pinkAccent]

                              ),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Center(child: Text("Reddet",style: GoogleFonts.comfortaa(fontSize: 14,color: Colors.white),)),

                        ),
                      ),
                      SizedBox(width: 15,),
                      InkWell(
                        onTap: (){

                          Toast.show("İstek Kabul Edildi", context, duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                          setState(() {
                            widget.onayDurumu=true;
                            widget.docAl=doc.id.toString();


                            DocumentReference docRef= FirebaseFirestore.instance.collection('istekler').doc(doc.id);
                            Map<String, dynamic> aktar= Map();
                            aktar['onayDurumu']=true;
                            aktar['istekDurumu']=false;
                            docRef.set(aktar, SetOptions(merge: true));


                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>bottom()));


                          bildirim(doc['karsiPp'],doc['pp'],_auth.currentUser.displayName,_gormeDurumu,widget.onayDurumu, widget.sahipUid,doc['uid'], doc['sahipAd'],widget.docAl+doc['uid'],false);
                        },
                        child: Container(
                          width: 130,
                          height: 35,
                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [ Colors.cyanAccent,Colors.green]

                              ),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Center(child: Text("Kabul Et",style: GoogleFonts.comfortaa(fontSize: 14,color: Colors.white),)),

                        ),
                      ),


                    ],
                  ),
                  if(doc['istekDurumu']==false)
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>bottom()));


                      },

                    child: Container(
                      width: 220,
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [ Colors.orange,Colors.deepOrangeAccent]

                          ),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Center(child: Text( "Bu İsteği Kabul Etmiştiniz",style: GoogleFonts.comfortaa(fontSize: 14,color: Colors.white),)),

                    ),
                  ),



                ],
              ),


              ).toList(),

          )
          );

        }
    ),

    );
  }
  void bildirim(karsiPp,pp,String adim,bool gormeDurumu,bool onayDurumu,String uid,String karsiUid,String kulad,String dcal,bool istekDurumu) async{
    try{

      Map<String, dynamic> aktar= Map();
      aktar['karsiPp']=karsiPp;
      aktar['pp']=pp;
      aktar['adim']=adim;
      aktar['gormeDurumu']=gormeDurumu;
      aktar['onayDurumu']=onayDurumu;
      aktar['uid']=uid;
      aktar['karsiUid']=karsiUid;
      aktar['kullanici']=kulad;
      aktar['doc']=dcal;
      aktar['istekDurumu']=istekDurumu;


      await _firestore.collection('bildirimler').doc(dcal).set(aktar, SetOptions(merge: true));

    }catch(e){
    }
  }
}
