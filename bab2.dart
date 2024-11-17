enum Kategori { DataManagement, NetworkAutomation }
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

class ProdukDigital {
  String namaProduk;
  double harga;
  Kategori kategori;
  int jumlahTerjual;

  ProdukDigital(this.namaProduk, this.harga, this.kategori, this.jumlahTerjual) {
 
    if (kategori == Kategori.NetworkAutomation && harga < 200000) {
      throw Exception("Harga NetworkAutomation harus minimal 200.000");
    } else if (kategori == Kategori.DataManagement && harga >= 200000) {
      throw Exception("Harga DataManagement harus di bawah 200.000");
    }
  }
  void terapkanDiskon() {
    if (kategori == Kategori.NetworkAutomation && jumlahTerjual > 50) {
      double hargaDiskon = harga * 0.85;
      if (hargaDiskon >= 200000) {
        harga = hargaDiskon;
      }
    }
  }
}

abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void bekerja();
}

mixin Kinerja {
  int produktivitas = 0;

  void perbaruiProduktivitas(int hari, int kenaikan, String peran) {
    if (hari >= 30) {
      produktivitas += kenaikan;
      if (produktivitas > 100) produktivitas = 100;
      if (peran == "Manager" && produktivitas < 85) {
        print("Peringatan: Produktivitas manajer harus minimal 85.");
      }
      print("Produktivitas diperbarui menjadi $produktivitas.");
    }
  }
}

class KaryawanTetap extends Karyawan with Kinerja {
  KaryawanTetap(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);
  void bekerja() {
    print("$nama bekerja sebagai Karyawan Tetap dalam peran $peran.");
  }
}

class KaryawanKontrak extends Karyawan with Kinerja {
  KaryawanKontrak(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  
  void bekerja() {
    print("$nama bekerja sebagai Karyawan Kontrak dalam peran $peran.");
  }
}

class Proyek {
  FaseProyek fase;
  List<Karyawan> timProyek;
  int hariProyek;

  Proyek(this.fase, this.timProyek, this.hariProyek);

  void beralihFase() {
    if (fase == FaseProyek.Perencanaan && timProyek.length >= 5) {
      fase = FaseProyek.Pengembangan;
      print("Fase proyek beralih ke Pengembangan.");
    } else if (fase == FaseProyek.Pengembangan && hariProyek > 45) {
      fase = FaseProyek.Evaluasi;
      print("Fase proyek beralih ke Evaluasi.");
    } else {
      print("Kondisi belum terpenuhi untuk beralih fase.");
    }
  }
}

class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  final int batasKaryawanAktif = 20;

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < batasKaryawanAktif) {
      karyawanAktif.add(karyawan);
      print("Karyawan ${karyawan.nama} ditambahkan sebagai karyawan aktif.");
    } else {
      print("Batas karyawan aktif tercapai. Tidak bisa menambah karyawan baru.");
    }
  }

  void resignKaryawan(Karyawan karyawan) {
    if (karyawanAktif.contains(karyawan)) {
      karyawanAktif.remove(karyawan);
      karyawanNonAktif.add(karyawan);
      print("Karyawan ${karyawan.nama} telah resign dan sekarang menjadi karyawan non-aktif.");
    } else {
      print("Karyawan ${karyawan.nama} tidak ditemukan dalam daftar karyawan aktif.");
    }
  }
}

void main() {

  var produk1 = ProdukDigital("Sistem Manajemen Data", 180000, Kategori.DataManagement, 30);
  var produk2 = ProdukDigital("Sistem Otomasi Jaringan", 250000, Kategori.NetworkAutomation, 60);

  produk2.terapkanDiskon();
  print("Harga produk2 setelah diskon: ${produk2.harga}");

  var karyawan1 = KaryawanTetap("Indah", umur: 20, peran: "Developer");
  var karyawan2 = KaryawanKontrak("Audila", umur: 28, peran: "NetworkEngineer");

  karyawan1.perbaruiProduktivitas(30, 10, karyawan1.peran);

  var perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawan1);
  perusahaan.tambahKaryawan(karyawan2);

  var proyek = Proyek(FaseProyek.Perencanaan, [karyawan1, karyawan2], 50);
  proyek.beralihFase();

  perusahaan.resignKaryawan(karyawan2);
}