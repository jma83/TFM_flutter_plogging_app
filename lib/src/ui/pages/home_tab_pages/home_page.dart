import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/view_models/home_tab_pages/home_page_viewmodel.dart';

class HomePage extends StatelessWidget {
  HomePageViewModel homePageViewModel;
  HomePage(this.homePageViewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[_card0(), const SizedBox(height: 30), _card1()],
    );
  }

  _card1() {
    final card = Column(
      children: <Widget>[
        const FadeInImage(
          image: NetworkImage(
              "https://www.creativefabrica.com/wp-content/uploads/2020/04/25/illustration-of-natural-landscape-Graphics-3952025-1.jpg"),
          placeholder: AssetImage("assets/jar-loading.gif"),
          height: 300.0,
          fadeInDuration: Duration(milliseconds: 200),
          fit: BoxFit.cover,
        ),
        Container(
            child: const Center(child: Text("Hola mundo!")),
            padding: const EdgeInsets.all(10))
      ],
    );
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(2, 10))
            ]),
        child: ClipRRect(
          child: card,
          borderRadius: BorderRadius.circular(20),
        ));
  }

  _card0() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.photo_album, color: Colors.blue),
            title: Text("Soy el titulo de esta tarjeta"),
            subtitle: Text("Aqui estamos con la descripcion"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(onPressed: () {}, child: const Text("Elpepe")),
              TextButton(onPressed: () {}, child: const Text("Elpepe2"))
            ],
          )
        ],
      ),
    );
  }
}
