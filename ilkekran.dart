import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/bottom.dart';
import 'package:flutter_app/firebase.dart';
import 'package:flutter_app/grs.dart';
import 'package:flutter_app/verilerigoster.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
class kullanici extends StatefulWidget {
  String ad;
  kullanici({this.ad});
  @override
  _kullaniciState createState() => _kullaniciState();
}
ProgressDialog progressDialog;
TextEditingController txt=new TextEditingController();
TextEditingController txt2=new TextEditingController();
User Girisyapan;
FirebaseAuth _auth=FirebaseAuth.instance;
class _kullaniciState extends State<kullanici> {

  @override
  Widget build(BuildContext context) {
    progressDialog=ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: 'Yükleniyor...');
    return Scaffold(

      body: Container(

        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ Colors.teal,Colors.indigoAccent]
            )
        ),
        child: Padding(

          padding: const EdgeInsets.only(top:150),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(30),

                child: Column(
                  children: [
                    TextField(
                      controller: txt,style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "E-Mail Adresininizi Girin",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35),borderSide: BorderSide(color: Colors.white)),
                        focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(35),borderSide: BorderSide(color: Colors.white)) ,
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,

                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: txt2,style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Şifrenizi Girin",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35),borderSide: BorderSide(color: Colors.white)),
                        focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(35),borderSide: BorderSide(color: Colors.white)) ,
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,

                      ),
                    ),
                    SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    girisyap(context,txt.text,txt2.text,widget.ad);

                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [ Colors.green,Colors.teal]

                        ),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(child: Text("Giriş Yap",style: GoogleFonts.comfortaa(fontSize: 14,color: Colors.white),)),

                  ),
                ),








                    SizedBox(height: 10,),

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>giris()));

                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [ Colors.blue,Colors.lightBlueAccent]

                        ),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(child: Text("Kaydol",style: GoogleFonts.comfortaa(fontSize: 14,color: Colors.white),)),

                  ),
                ),








                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void girisyap(BuildContext context,String email, String password,String kull)async{
  try{

    if(_auth.currentUser==null ){
      progressDialog.show();
      Girisyapan=(await _auth.signInWithEmailAndPassword(
          email: email, password: password)).user;
      progressDialog.hide();
      if(Girisyapan.emailVerified){
        Toast.show("Giriş Başarılı", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>bottom()));

      }else{
        Toast.show("Lütfen Size Gönderdiğimiz Maili Onaylayın", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM );
        await _auth.signOut();
      }


    }else{
      progressDialog.show();
      debugPrint("Bu kullanıcı zaten giriş yapmış");
      Girisyapan=(await _auth.signInWithEmailAndPassword(
          email: email, password: password)).user;
      progressDialog.hide();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>bottom()));
    }
  }
  catch(e){

  }

}