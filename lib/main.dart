import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Debug işaretini kaldırmak için eklenen satır
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

class KovanEkleSayfasi extends StatefulWidget {
  @override
  _KovanEkleSayfasiState createState() => _KovanEkleSayfasiState();
}

class _KovanEkleSayfasiState extends State<KovanEkleSayfasi> {
  String kovanAdi = '';
  String kovanLokasyonu = '';
  int kovanKatSayisi = 0;
  String anaAri = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kovan Ekle'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  kovanAdi = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Kovan Adı',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  kovanLokasyonu = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Kovan Lokasyonu',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  kovanKatSayisi = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Kovan Kat Sayısı',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  anaAri = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Ana Arı',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Kovanı kaydetmek için gerekli işlemler
                Kovan yeniKovan = Kovan(
                  kovanAdi: kovanAdi,
                  kovanLokasyonu: kovanLokasyonu,
                  kovanKatSayisi: kovanKatSayisi,
                  anaAri: anaAri,
                );
                Navigator.pop(context, yeniKovan);
              },
              child: Text('Kovan Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}

class KovanListeleSayfasi extends StatefulWidget {
  @override
  _KovanListeleSayfasiState createState() => _KovanListeleSayfasiState();
}

class _KovanListeleSayfasiState extends State<KovanListeleSayfasi> {
  List<Kovan> kovanlar = [];

  @override
  void initState() {
    super.initState();
    kovanlar = [
      Kovan(
        kovanAdi: 'Kovan 1',
        kovanLokasyonu: 'Lokasyon 1',
        kovanKatSayisi: 2,
        anaAri: 'Ana Arı 1',
      ),
      Kovan(
        kovanAdi: 'Kovan 2',
        kovanLokasyonu: 'Lokasyon 2',
        kovanKatSayisi: 3,
        anaAri: 'Ana Arı 2',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kovan Listele'),
      ),
      body: ListView.builder(
        itemCount: kovanlar.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      KovanDetaySayfasi(kovan: kovanlar[index]),
                ),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    kovanlar[index] = value;
                  });
                }
              });
            },
            child: Card(
              child: ListTile(
                title: Text(kovanlar[index].kovanAdi),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KovanEkleSayfasi()),
          ).then((value) {
            if (value != null) {
              setState(() {
                kovanlar.add(value); // Yeni kovanı "kovanlar" listesine ekleyin
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class KovanDetaySayfasi extends StatefulWidget {
  final Kovan kovan;

  KovanDetaySayfasi({required this.kovan});

  @override
  _KovanDetaySayfasiState createState() => _KovanDetaySayfasiState();
}

class _KovanDetaySayfasiState extends State<KovanDetaySayfasi> {
  late TextEditingController kovanAdiController;
  late TextEditingController kovanLokasyonuController;
  late TextEditingController kovanKatSayisiController;
  late TextEditingController anaAriController;

  @override
  void initState() {
    super.initState();
    kovanAdiController = TextEditingController(text: widget.kovan.kovanAdi);
    kovanLokasyonuController =
        TextEditingController(text: widget.kovan.kovanLokasyonu);
    kovanKatSayisiController =
        TextEditingController(text: widget.kovan.kovanKatSayisi.toString());
    anaAriController = TextEditingController(text: widget.kovan.anaAri);
  }

  @override
  void dispose() {
    kovanAdiController.dispose();
    kovanLokasyonuController.dispose();
    kovanKatSayisiController.dispose();
    anaAriController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kovan.kovanAdi),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: kovanAdiController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Kovan Adı',
              ),
            ),
            TextField(
              controller: kovanLokasyonuController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Kovan Lokasyonu',
              ),
            ),
            TextField(
              controller: kovanKatSayisiController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Kovan Kat Sayısı',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: anaAriController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Ana Arı',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Kovanı güncellemek için gerekli işlemler
                Kovan updatedKovan = Kovan(
                  kovanAdi: kovanAdiController.text,
                  kovanLokasyonu: kovanLokasyonuController.text,
                  kovanKatSayisi:
                      int.tryParse(kovanKatSayisiController.text) ?? 0,
                  anaAri: anaAriController.text,
                );
                Navigator.pop(context, updatedKovan);
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}

class Kovan {
  final String kovanAdi;
  final String kovanLokasyonu;
  final int kovanKatSayisi;
  final String anaAri;

  Kovan({
    required this.kovanAdi,
    required this.kovanLokasyonu,
    required this.kovanKatSayisi,
    required this.anaAri,
  });
}
