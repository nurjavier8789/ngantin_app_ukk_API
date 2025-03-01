String nama = "";
String nama_stan = "";

int makerID = 0;

String alamat = "";
String noTelp = "";
String urlFoto = "";
int idUser = 0;
String username = "";

class dataUser {
  setDataSiswa(String namaSiswa, String alamatSiswa, String noTelpSiswa, String urlFotoSiswa, int idUserSiswa, String usernameSiswa, int _makerID) {
    nama = namaSiswa;
    alamat = alamatSiswa;
    noTelp = noTelpSiswa;
    urlFoto = urlFotoSiswa;
    idUser = idUserSiswa;
    username = usernameSiswa;
    makerID = _makerID;
  }

  setDataStan(String namaStan, String namaPemilik, String noTelpStan, int idUserStan, String usernameStan) {
    nama_stan = namaStan;
    nama = namaPemilik;
    noTelp = noTelpStan;
    idUser = idUserStan;
    username = usernameStan;
  }

  getNama() {
    return nama;
  }

  getAlamat() {
    return alamat;
  }

  getNoTelp() {
    return noTelp;
  }

  getUrlFoto() {
    return urlFoto;
  }

  getIdUser() {
    return idUser;
  }

  getUsername() {
    return username;
  }
}

