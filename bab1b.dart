enum Peran { Admin, Pelanggan }
//bab 1 indah audila rauf
class Produk {
  String namaProduk;
  double harga;
  bool tersedia;

  Produk(this.namaProduk, this.harga, this.tersedia);
}

class Pengguna {
  String nama;
  int umur;
  late List<Produk> produkList; 
  Peran? peran;

  Pengguna(this.nama, this.umur, this.peran) {
    produkList = []; 
  }
}

class AdminPengguna extends Pengguna {
  AdminPengguna(String nama, int umur) : super(nama, umur, Peran.Admin);

    void tambahProduk(Produk produk, Map<String, Produk> produkMap) {
    try {
      if (!produk.tersedia) throw Exception("Produk tidak tersedia dalam stok");

      if (produkList.any((item) => item.namaProduk == produk.namaProduk)) {
        print("Produk ${produk.namaProduk} sudah ada di daftar.");
      } else {
        produkList.add(produk);
        produkMap[produk.namaProduk] = produk;
        print("Produk ${produk.namaProduk} berhasil ditambahkan.");
      }
    } catch (e) {
      print("Kesalahan: $e");
    }
  }

  void hapusProduk(Produk produk) {
    if (produkList.remove(produk)) {
      print("Produk ${produk.namaProduk} berhasil dihapus.");
    } else {
      print("Produk ${produk.namaProduk} tidak ditemukan dalam daftar.");
    }
  }
}

class PelangganPengguna extends Pengguna {
  PelangganPengguna(String nama, int umur) : super(nama, umur, Peran.Pelanggan);

  void lihatProduk() {
    if (produkList.isEmpty) {
      print("Tidak ada produk yang tersedia.");
    } else {
      print("Daftar Produk:");
      for (var produk in produkList) {
        print("- ${produk.namaProduk}: Rp${produk.harga}");
      }
    }
  }
}

Produk ambilDetailProduk(String namaProduk, double harga) {

  return Produk(namaProduk, harga, true); 
}

void main() {
 
  var admin = AdminPengguna("Indah", 19);
  var pelanggan = PelangganPengguna("Audila", 20);

  Map<String, Produk> produkMap = {};

  var produk1 = ambilDetailProduk("Laptop", 15000000.0);
  var produk2 = ambilDetailProduk("Smartphone", 8000000.0);

  admin.tambahProduk(produk1, produkMap);
  admin.tambahProduk(produk2, produkMap);

  pelanggan.produkList = admin.produkList; 
  pelanggan.lihatProduk();
}