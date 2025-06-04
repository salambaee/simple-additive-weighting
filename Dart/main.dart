class Laptop {

  final String nama;
  final int hargaRupiah;
  final String layar;
  final String prosesor;
  final int ramGB;
  final String tipeRam;
  final int storageGB;
  final bool bluetooth;
  final bool webcam;

  Laptop({
    required this.nama,
    required this.hargaRupiah,
    required this.layar,
    required this.prosesor,
    required this.ramGB,
    required this.tipeRam,
    required this.storageGB,
    required this.bluetooth,
    required this.webcam,
  });

  Map<String, double> toSAWScore() => {
        'harga': _konversiHarga(hargaRupiah),
        'layar': _konversiUkuranLayar(layar),
        'prosesor': _konversiProsesor(prosesor),
        'ram': _konversiRAM(ramGB),
        'tipeRam': _konversiTipeRAM(tipeRam),
        'storage': _konversiStorage(storageGB),
        'bluetooth': bluetooth ? 5 : 2,
        'webcam': webcam ? 5 : 2,
      };

  static double _konversiHarga(int harga) {
    if (harga <= 5000000) return 1;
    if (harga <= 8000000) return 2;
    if (harga <= 11000000) return 3;
    if (harga <= 14000000) return 4;
    return 5;
  }


  static double _konversiUkuranLayar(String ukuran) {
    final inc = int.tryParse(ukuran.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    switch (inc) {
      case 11:
      case 12:
        return 1;
      case 17:
        return 2;
      case 13:
        return 3;
      case 16:
        return 4;
      case 14:
      case 15:
        return 5;
      default:
        return 3;
    }
  }

  static double _konversiProsesor(String prosesor) {
    final p = prosesor.toLowerCase();
    if (p.contains("pentium")) return 1;
    if (p.contains("celeron") || p.contains("dual")) return 2;
    if (p.contains("i3")) return 3;
    if (p.contains("i5")) return 4;
    if (p.contains("i7") || p.contains("i9")) return 5;
    return 3;
  }

  static double _konversiRAM(int ram) {
    if (ram <= 4) return 1;
    if (ram <= 8) return 2;
    if (ram <= 16) return 3;
    if (ram <= 32) return 4;
    return 5;
  }

  static double _konversiTipeRAM(String tipe) {
    final t = tipe.toLowerCase();
    if (t.contains("ddr2")) return 2;
    if (t.contains("ddr3")) return 3;
    if (t.contains("ddr4")) return 4;
    if (t.contains("ddr5")) return 5;
    return 3;
  }

  static double _konversiStorage(int s) {
    if (s <= 128) return 1;
    if (s <= 256) return 2;
    if (s <= 512) return 3;
    if (s <= 1024) return 4;
    return 5;
  }
}

class SAW {
  final List<Laptop> data;

  SAW(this.data);

  final Map<String, int> _bobot = {
    'harga': 3,
    'layar': 5,
    'prosesor': 4,
    'ram': 2,
    'tipeRam': 4,
    'storage': 3,
    'bluetooth': 5,
    'webcam': 5,
  };

  final Map<String, String> _jenis = {
    'harga': 'cost',
    'layar': 'benefit',
    'prosesor': 'benefit',
    'ram': 'benefit',
    'tipeRam': 'benefit',
    'storage': 'benefit',
    'bluetooth': 'benefit',
    'webcam': 'benefit',
  };

  Map<String, double> hitungPreferensi() {
    final Map<String, double> hasil = {};
    final List<Map<String, double>> skorList = data.map((l) => l.toSAWScore()).toList();
    final Map<String, double> maxVal = {};
    final Map<String, double> minVal = {};
    
    for (var key in _bobot.keys) {
      maxVal[key] = skorList.map((s) => s[key]!).reduce((a, b) => a > b ? a : b);
      minVal[key] = skorList.map((s) => s[key]!).reduce((a, b) => a < b ? a : b);
    }
  
    for (int i = 0; i < data.length; i++) {
      double vi = 0.0;
      final skor = skorList[i];
      for (var key in skor.keys) {
        double r = _jenis[key] == 'cost' ? minVal[key]! / skor[key]! : skor[key]! / maxVal[key]!;
        vi += _bobot[key]! * r;
      }
      hasil[data[i].nama] = vi;
    }
    return hasil;
  }
}

void main() {
 final List<Laptop> laptopList = [
    Laptop(
      nama: "Laptop 1",
      hargaRupiah: 6300000,
      layar: "14 inc",
      prosesor: "Ryzen 3",
      ramGB: 8,
      tipeRam: "DDR4",
      storageGB: 256,
      bluetooth: true,
      webcam: true,
    ),
    Laptop(
      nama: "Laptop 2",
      hargaRupiah: 5100000,
      layar: "14 inc",
      prosesor: "Ryzen 3",
      ramGB: 8,
      tipeRam: "DDR5",
      storageGB: 512,
      bluetooth: true,
      webcam: true,
    ),
    Laptop(
      nama: "Laptop 3",
      hargaRupiah: 5400000,
      layar: "14 inc",
      prosesor: "Ryzen 3",
      ramGB: 8,
      tipeRam: "DDR5",
      storageGB: 512,
      bluetooth: true,
      webcam: true,
    ),
    Laptop(
      nama: "Laptop 4",
      hargaRupiah: 8500000,
      layar: "14 inc",
      prosesor: "Core i5",
      ramGB: 8,
      tipeRam: "DDR5",
      storageGB: 512,
      bluetooth: true,
      webcam: true,
    ),
    Laptop(
      nama: "Laptop 5",
      hargaRupiah: 8600000,
      layar: "14 inc",
      prosesor: "Core i5",
      ramGB: 8,
      tipeRam: "DDR4",
      storageGB: 512,
      bluetooth: true,
      webcam: true,
    ),
    Laptop(
      nama: "Laptop 6",
      hargaRupiah: 3000000,
      layar: "14 inc",
      prosesor: "Core i5",
      ramGB: 8,
      tipeRam: "DDR3",
      storageGB: 256,
      bluetooth: true,
      webcam: true,
    ),
  ];

  final saw = SAW(laptopList);
  final hasil = saw.hitungPreferensi();
  final sorted = hasil.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

  print("=== Hasil Ranking Laptop (Metode SAW) ===");
  for (var i = 0; i < sorted.length; i++) {
    print('${i + 1}. ${sorted[i].key} -> ${sorted[i].value.toStringAsFixed(2)}');
  }
}