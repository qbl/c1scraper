c1scraper
=========

Aplikasi ini merupakan aplikasi yang dibuat untuk membantu melakukan scraping data dari [situs resmi Pilpres 2014 dari KPU][1]. Hasil scraping data dari aplikasi c1scraper bisa digunakan untuk membuat dokumen excel yang telah berisi data-data:

  - Nama Provinsi
  - Nama Kabupaten/Kota
  - Nama Kecamatan
  - Nama Kelurahan
  - Nomor TPS
  - ID TPS
  - Link ke 4 file hasil scan dari dokumen C1

Bagaimana Kalau Saya Ingin Ikut Menginput Data Rekap C1?
----

Caranya mudah, Anda cukup memiliki akun Gmail saja. Informasikan akun alamat email Anda ke saya melalui:

  - email ke farabi.iqbal@gmail.com
  - akun twitter [@iqbal_farabi][2]

Nanti saya akan invite Anda untuk bisa menginput data di dokumen-dokumen Google Spreadsheet yang sudah berisi data-data dari situs KPU tadi.

Jika Anda sudah menerima invitasi dari saya, tingal lakukan langkah-langkahnya berikut:
- Buka link [berikut][3]

![Screenshot-1](https://dl.dropboxusercontent.com/u/25906777/Screenshot%20-%201.png)

- Klik satu file yang ingin Anda edit kemudian klik tombol "Open"

![Screenshot-2](https://dl.dropboxusercontent.com/u/25906777/Screenshot%20-%202.png)

- Setelah dokumen terbuka, lihat kolom yang paling kanan

![Screenshot-3](https://dl.dropboxusercontent.com/u/25906777/Screenshot%20-%203.png)

- Copy URL pada kolom Scan4 

![Screenshot-4](https://dl.dropboxusercontent.com/u/25906777/Screenshot%20-%203.png)

- Paste URL tersebut di tab lain

![Screenshot-5](https://dl.dropboxusercontent.com/u/25906777/Screenshot%20-%204.png)

- Lihat hasil perhitungan pada scan dokumen C1 yang muncul

![Screenshot-6](https://dl.dropboxusercontent.com/u/25906777/Screenshot%20-%206.png)

- Inputkan hasil perhitungan tersebut ke dokumen Google Spreadsheet tadi

![Screenshot-6](https://dl.dropboxusercontent.com/u/25906777/Screenshot%20-%205.png)

- Selesai! Tentu saja Anda bisa terus input data di baris berikutnya kalau masih mau. :)

[Hanya Untuk Developer] Cara Instalasi dan Penggunaan Aplikasi
----

Bagian ini hanya untuk developer/programmer yang tertarik untuk a) Ikut menjalankan aplikasi untuk meng-generater file excel atau b) Ingin memeriksa apakah script ini berjalan baik atau tidak. Jika Anda bukan developer/programmer, bagian ini tidak perlu dibaca.

Sebelum melakukan instalasi, pastikan Anda sudah memiliki requirement berikut:

  - Sistem operasi berbasis Unix
  - Ruby versi 2.1.1
  - Ruby on Rails versi 4.0.2

Untuk meng-install aplikasi, ikuti langkah-langkah berikut. 

  - Pada command line, Ketikkan perintah 

```sh
git clone git@github.com:qbl/c1scraper.git
cd c1scrapper
bundle install
```
  - Untuk melihat daftar provinsi ketikkan

```sh
rake fetch_provinces
```
    
  - Adapun daftar lengkap kode Provinsi adalah sebagai berikut

```sh
Kode: 1, ACEH
Kode: 6728, SUMATERA UTARA
Kode: 12920, SUMATERA BARAT
Kode: 14086, RIAU
Kode: 15885, JAMBI
Kode: 17404, SUMATERA SELATAN
Kode: 20802, BENGKULU
Kode: 22328, LAMPUNG
Kode: 24993, KEPULAUAN BANGKA BELITUNG
Kode: 25405, KEPULAUAN RIAU
Kode: 25823, DKI JAKARTA
Kode: 26141, JAWA BARAT
Kode: 32676, JAWA TENGAH
Kode: 41863, DAERAH ISTIMEWA YOGYAKARTA
Kode: 42385, JAWA TIMUR
Kode: 51578, BANTEN
Kode: 53241, BALI
Kode: 54020, NUSA TENGGARA BARAT
Kode: 55065, NUSA TENGGARA TIMUR
Kode: 58285, KALIMANTAN BARAT
Kode: 60371, KALIMANTAN TENGAH
Kode: 61965, KALIMANTAN SELATAN
Kode: 64111, KALIMANTAN TIMUR
Kode: 65702, SULAWESI UTARA
Kode: 67393, SULAWESI TENGAH
Kode: 69268, SULAWESI SELATAN
Kode: 72551, SULAWESI TENGGARA
Kode: 74716, GORONTALO
Kode: 75425, SULAWESI BARAT
Kode: 76096, MALUKU
Kode: 77085, MALUKU UTARA
Kode: 78203, PAPUA
Kode: 81877, PAPUA BARAT
```

  - Untuk menggenerate daftar seluruh TPS pada sebuah provinsi ketikkan "rake generate_excel[kode_propinsi]". Contoh: untuk menggenerate daftar seluruh TPS pada provinsi DKI Jakarta, ketikkan

```sh
rake generate_excel[25823]
```

  - File yang dihasilkan bisa dilihat di folder "c1scraper"


Disclaimer
-----------

Saya bertanggung jawab terhadap program yang menggenerate data dasar dari situs KPU berupa:

* Data Provinsi
* Data Kabupaten/Kota
* Data Kecamatan
* Data Kelurahan
* Data TPS
* Data URL ke file-file hasil scan dokumen C1

adapun pertanggungjawaban saya adalah menjamin bahwa program yang saya buat ditulis tanpa ada maksud untuk memanipulasi data sama sekali. Jika ada yang menemukan kesalahan dalam algoritma yang saya tulis, kontak saya dan akan saya lakukan perbaikan yang diperlukan.

Saya TIDAK bertanggung jawab terhadap:
* Akurasi data jumlah suara yang diisi pada dokumen Google Spreadsheet yang dibagikan
* Kebenaran dari isi hasil scan dokumen yang dilakukan oleh KPU
* Jika muncul konten-konten tidak berkenan di dokumen Google Spreadsheet yang dibagikan setelah dokumen tersebut diedit oleh banyak tangan


License
----

Belum sepmat googling lisensi apa yang tepat. Source code ini bebas di-download oleh siapa saja, dimodifikasi, dan kemudian disebarkan ulang dalam nama yang berbeda selama memberi atribusi kepada source code awal.


**Free Software, Hell Yeah!**

[1]:http://pilpres2014.kpu.go.id/c1.php
[2]:https://twitter.com/iqbal_farabi
[3]:https://drive.google.com/folderview?id=0BxLC5WIzlW3fbzk2WFFTTmd0a2s&usp=sharing