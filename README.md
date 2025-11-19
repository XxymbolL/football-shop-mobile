# football-shop-mobile
LINK TO PWS:

---
# Tugas 7

## 1) Apa itu widget tree dan hubungan parent–child?
Widget tree adalah struktur hirerarcy semua widget pada layar. Setiap widget (child) berada di dalam widget lain (parent). Parent bertanggung jawab untuk memetakan layout child lalu meneruskan constraint dan child merender diri berdasarkan constraint dirinya dan parentnya sehingga memudahkan developer untuk melakukan modifikasi karena hanya perlu merubah sekali.
## 2) Widget yang digunakan & fungsinya
- **MaterialApp**: Root app yang berisi material, terdapat theme, navigator, dll.
- **Scaffold**: Kerangka dari page (AppBar, body, SnackBar).
- **AppBar**: bagian paling atas yang berisi judul halaman.
- **Text**: Menampilkan teks.
- **Chip**: komponen kecil untuk menampilkan potongan informasi singkat (NPM, nama, kelas).
- **GridView.count**: Grid 3 kolom untuk menaruh tombol.
- **Material** + **InkWell**: Efek material untuk kartu tombol.
- **Icon**: Ikon di dalam tombol.
- **SnackBar** + **ScaffoldMessenger**: Notifikasi popup saat tombol ditekan.
- **Container**, **Row**, **Column**, **SizedBox**: Layouting, padding, dan spacing.
## 3) Fungsi MaterialApp dan kenapa sering jadi root
MaterialApp mengatur desain global seperti global.css (tema, navigator, dll). Dipakai sebagai root agar seluruh subtree mendapat tema/navigator yang konsisten.
## 4) Perbedaan StatelessWidget vs StatefulWidget
- **StatelessWidget**: Tidak menyimpan state yang berubah, sehingga build tergantung pada input/konfigurasi saja. Cocok untuk UI yang statis karena ringan.
- **StatefulWidget**: Memiliki state yang bisa berubah (setState) seiring interaksi/asyncronus. Digunakan ketika UI bergantung pada data/animasi yang berubah.
## 5) Apa itu BuildContext dan pentingnya?
BuildContext digunakan untuk menghandle lokasi widget di dalam tree. Digunakan untuk:
- Mengakses inherited widgets (Theme.of, MediaQuery.of).
- Navigasi, menampilkan SnackBar melalui `ScaffoldMessenger.of(context)`.
Dalam build, context dipakai untuk membaca theme, ukuran layar, dll.
## 6) Hot reload vs hot restart
- **Hot reload**: Langsung melakukan perubahan kode di VM, melakukan rebuild widget tree tanpa mengulang state saat ini. Cepat untuk iterasi UI.
- **Hot restart**: Memulai ulang app dari `main()`, lalu **menghapus state**. Dipakai ketika perubahan tidak bisa diterapkan via reload.

---

# Tugas 8

### 1) Perbedaan Navigator.push vs Navigator.pushReplacement
**Navigator.push()** menaruh halaman baru di atas stack sehingga user tetap bisa kembali (Back). Disini digunakan untuk membuka form dari tombol “Create Product” atau opsi drawer “Tambah Produk”. **Navigator.pushReplacement()** mengganti halaman teratas, jadi tidak ada history kembali. Ini cocok saat user memilih “Halaman Utama” dari drawer agar halaman lama langsung diganti tanpa loop kembali.

### 2) Scaffold, AppBar, Drawer
Setiap layar dibangun dari **Scaffold** supaya desain diturunkan dan sama (AppBar, body, drawer). **AppBar** berisi judul “Alpha Shoes” atau “Tambah Produk Baru” dengan warna tema yang konsisten. **Drawer**  ditambahkan ke Scaffold untuk navigasi global (Home dan Tambah Produk) sehingga user selalu punya cara yang sama untuk berpindah layar. Hierarki ini menjaga struktur antar page agar tetap konsisten tanpa duplikasi.

### 3) Layout widget (Padding, SingleChildScrollView, ListView)
Form dibungkus dengan **SingleChildScrollView** agar tetap bisa di-scroll pada layar kecil. Setiap field di wrap dengan **Padding** 8 px supaya input tidak menempel ke tepi dan tidak menganggu UX. Untuk daftar ukuran sepatu, saya menaruh **DropdownButtonFormField** bersama field lain di satu kolom, jadi layout tetap rapi dan validatornya bekerja. Kombinasi ini membuat form panjang tetap mudah dibaca sekaligus responsif.

### 4) Konsistensi warna tema
Di **MaterialApp**, digunakan `ColorScheme.fromSwatch(primarySwatch: Colors.blue)` supaya AppBar dan komponen default mengikuti warna biru. Tombol grid di home masih sama seperti Tugas 7 (biru/hijau/merah), sementara tombol form menggunakan warna yang masih satu palet. Dengan begitu seluruh layar terasa berasal dari brand yang sama tanpa perlu set warna manual di tiap widget.


---

# Tugas 9

### 1) Kenapa butuh model Dart untuk JSON?
Model Dart memastikan struktur dan tipe data konsisten (int, String, bool, DateTime) serta null-safety terjaga. Model dengan **fromJson/toJson** membuat tipe data jelas, konsisten dan lebih maintainable.

### 2) Peran http vs CookieRequest
**http** dipakai untuk request biasa tanpa session (seperti fetch public) dan memberi kontrol manual untuk header/body/response. **CookieRequest** (pbp_django_auth) memaintain session cookies/CSRF otomatis, digunakan untuk endpoint Django yang butuh login dan persistence credential. Jadi, **http** = fetch stateless saja sedangkan **CookieRequest** = stateful, autentikasi Django yang membutuhkan session.

### 3) Kenapa CookieRequest dibagi ke semua komponen?
Session (cookies, loggedIn status) harus dari satu sumber, jika tiap widget membuat instance sendiri, cookie login akan terputus. Dengan Provider<CookieRequest> di root, semua screen berbagi session yang sama: login -> cookies tersimpan -> fetch/POST berikutnya otomatis pakai session yang sudah dibuat. Logout memutus session untuk seluruh app.

### 4) Konfigurasi konektivitas Flutter ↔ Django
- **ALLOWED_HOSTS** menambah **10.0.2.2** agar emulator Android dapat mengakses host machine.
- **CORS, CORS_ALLOW_CREDENTIALS, SameSite=None, secure cookies** mengizinkan cross-origin dan mengirim cookie saat auth dari web/Chrome/emulator.  
- Android permission `<uses-permission android:name="android.permission.INTERNET" />` allow app terkoneksi dengan internet.  

### 5) Alur data dari input ke tampilan Flutter
Input di form Flutter -> divalidasi -> dikirim via **CookieRequest.post** ke endpoint Django (create shoes) -> Django menyimpan dan membalas JSON -> Flutter parse ke model Dart -> ditampilkan lewat widget (list/detail) dengan `FutureBuilder`/setState.

### 6) Mekanisme autentikasi (login/register/logout)
- Register: form Flutter mengirim username dan password ke **/auth/register/** -> Django membuat user lalu response -> Flutter popup SnackBar dan redirect ke login.  
- Login: form kirim ke **/auth/login/** via **CookieRequest.login()** -> Django authenticate dan set session cookie -> **CookieRequest** menyimpan cookie -> Flutter **pushReplacement** ke Home(request berikutnya membawa cookie).  
- Logout: panggil **/auth/logout/** via **CookieRequest.logout()** -> Django menghapus session -> Flutter SnackBar + **pushReplacement** ke Login.

### 7) Step-by-step implementasi checklist
1) Modify backend Alpha_Shoes: auth endpoints, JSON list/detail, create API, CORS/hosts.
2) Install dependency `provider`, `pbp_django_auth`, `http`.
3) Buat login/register screens, set **home: LoginPage**, dan wire URLs ke Django.  
4) Modify form untuk melakukan POST via **CookieRequest** ke API create shoes.
5) Buat model Dart (**Shoe**) dan screens untuk list/detail, fetch dengan **CookieRequest.get**, tampilkan cards/detail.  
6) Update drawer/menu navigasi (Home, All Products, My Products, Add Product, Logout) supaya sama dengan webapp.
