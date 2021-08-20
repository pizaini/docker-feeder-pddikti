# Aplikasi Feeder PDDIKTI
Docker image ini guna mempermudah deployment aplikasi Feeder bagi insan Dikti yang ingin menggunakan Docker sebagai pilihan penggunaan aplikasi Feeder.

## Latar belakang
1. Aplikasi Feeder PDDIKTI mengharuskan menginstall di virtual machine (VM) linux
2. Aplikasi Feeder tidak ingin "diganggu" dengan aplikasi web lain. Ini dibuktikan jika kita memiliki aplikasi web di direktori default linux Debian/Ubuntu, instalasi Feeder akan menghapusnya direktori dan menimpanya dengan aplikasi Feeder. Bayangkan, jika kita menginstal aplikasi Feeder bersandingan dengan aplikasi web lainnya. Atau saat kita "uninstall", langsung menghapus tanpa ada konfirmasi apa yang mau dihapus.
3. Instalasi Feeder menginginkan server yang "clean" alias baru install OS. Juga dengan otomatis menginstalkan semua kebutuhan-kebutuhan aplikasi seperti web server, php, database, dan kebutuhan lain. Dan akan "terganggu" jika sudah ada database server di VM tersebut. Dengan kata lain, aplikasi Feeder PDDIKTI menginginkan satu server (VM) sendiri untuknya. (Gokil, kan.....). Jika kita ingin menggabungkan dengan aplikasi lain, siap2 mengatur sendiri dan tidak ada petunjuknya.
4. Instalasi tidak bisa di-custom. Kita tidak tahu persis apa yang diinstall dan apa yg dimodifikasi di sistem operasi kita. Ditambah lagi aplikasi webnya di-encrypt, uncustomable
5. Request sistem operasi DEBIAN v9.11 x64 (Gak boleh kurang atau lebih. Misal v9.10 atau v9.13 gak bakal bisa) atau Ubuntu 16.04 x64 (Gak bakal jalan di Ubuntu di atasnya). Please dech, aplikasi canggih apa yang minta sistem operasi se-strict itu. Klo bukan karena terpaksa, gak bakal jadi nih repo.. hehe

## Ingin memudahkan
Semoga dengan docker image ini dapat mempermudah deployment Feeder dikti tanpa khawatir digabungkan dengan aplikasi lain di server yang sama

## Hemat biaya!
Berapa biaya yang harus keluarkan untuk membayar sebuah virtual machine (VM) tapi hanya efektif digunakan oleh satu aplikasi? Belum lagi aplikasi lain seperti Sister. Institusi pendidikan jadinya harus punya 2 VM untuk 2 aplikasi berbeda dari kementrian yang sama. Cerdaskah cara berfikir demikian? Mari berinovasi dengan mempermudah sesama demi pendidikan Indonesia yang maju, bukan malah sebaliknya. 

## Cara menggunakan
Run docker:

`docker run -p 8082:8082 --name feeder-pddikti pizaini/feeder-pddikti:4.1`

1. Isi prefill sesuai dengan file dan kode yang didapatkan dari PDDIKTI
2. Patch 3.3 `/feeder/UPDATE_PATCH.3.3`
2. Patch 3.4 `/feeder/UPDATE_PATCH.3.4`
2. Patch 4.0 `/feeder/UPDATE_PATCH.4.0`
2. Patch 4.1 `/feeder/UPDATE_PATCH.4.1`

## Volumes
Sejauh ini kita hanya perlu menyimpan secara persistence database  `/var/lib/postgresql` dan prefill `/home/prefill`

## Source
https://github.com/pizaini/docker-feeder-pddikti

## Thanks to 
https://www.kadekjayak.web.id/install-feeder-pddikti-dengan-docker/