# Aplikasi Feeder PDDIKTI: versi NEO
Hadirnya Feeder PDDIKTI versi NEO merupakan terobosan yang patut diapresisasi. Sebelumnya, repo ini membuat docker image dengan membuat dockerfile sendiri agar Aplikasi Feeder dapat digunakan di docker ditambah kritik terhadap proyek pemerintah itu yang 'mempersulit' perguruan tinggi. Namun, dengan adanya Feeder PDDIKTI versi NEO yang rilis akhir Februari 2022 adalah langkah bagus. Kita perlu apresiasi dan bangga karna DIKTI/Kemendikbud mau mengadopsi teknologi docker di aplikasinya. 

Di repo ini, saya hanya menghadirkan Feeder PDDIKTI yang versi dockernya tidak tersedia di docker hub. Sekaligus ingin berbagi apa yang kami lakukan agar penggunaan Feeder Neo dapat berjalan dengan lebih baik.

## Versi Neo, versi 22.2.x.
Docker hub versi 22.2 adalah versi NEO.

## Cara menggunakan
Run docker compose

`docker compose up -d`

## Prefill
1. Upload file prefill ke direktory host volume (lihat file docker compose)
2. Lakukan prefill seperti yang dijelaskan pada manual penggunaan

## Migrasi
Jika menggunakan teknik migrasi, tidak perlu prefill.

## Source
https://github.com/pizaini/docker-feeder-pddikti