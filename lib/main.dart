import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arıcılık Takip Sistemi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => AnaSayfa(),
        '/kovanEkle': (context) => KovanEkleSayfasi(),
      },
      initialRoute: '/',
    );
  }
}

// ...

class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/kovanEkle');
        },
        child: Icon(Icons.add),
      ),
      body: KovanListeleSayfasi(),
    );
  }
}


class KovanEkleSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kovan Ekle'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Kovan Numarası'),
            ),
            
            // Diğer kovan özellikleri için metin alanları veya açılır listeler ekleyebilirsiniz.
            ElevatedButton(
              onPressed: () {
                // Kovan ekleme işlemini gerçekleştirecek kodu buraya yazın.
              },
              child: Text('Kovan Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}

class KovanListeleSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Kovanları veritabanından alınacak şekilde güncelleyin veya hardcode olarak örnek kovanları kullanın.
    List<Kovan> kovanlar = [
      Kovan('Kovan 1', 'Lokasyon 1'),
      Kovan('Kovan 2', 'Lokasyon 2'),
      // Diğer kovanları da listeye ekleyin.
    ];

    return ListView.builder(
      itemCount: kovanlar.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(kovanlar[index].kovanNumarasi),
          subtitle: Text(kovanlar[index].lokasyon),
          onTap: () {
            // Kovan detay sayfasına yönlendirmek için gerekli kodu buraya yazın.
          },
        );
      },
    );
  }
}

class Kovan {
  final String kovanNumarasi;
  final String lokasyon;

  Kovan(this.kovanNumarasi, this.lokasyon);
}
