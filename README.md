# Aplikasi Feeder PDDIKTI: versi NEO
Hadirnya Feeder PDDIKTI versi NEO merupakan terobosan yang patut diapresisasi. Sebelumnya, repo ini membuat docker image dengan membuat dockerfile sendiri agar Aplikasi Feeder dapat digunakan di docker ditambah kritik terhadap proyek pemerintah itu yang 'mempersulit' perguruan tinggi. Namun, dengan adanya Feeder PDDIKTI versi NEO yang rilis akhir Februari 2022 adalah langkah bagus. Kita perlu apresiasi dan bangga karna DIKTI/Kemendikbud mau mengadopsi teknologi docker di aplikasinya. 

Di repo ini, saya hanya menghadirkan Feeder PDDIKTI yang versi dockernya tidak tersedia di docker hub. Sekaligus ingin berbagi apa yang kami lakukan agar penggunaan Feeder Neo dapat berjalan dengan lebih baik.

## Latest version
v22.106.2 = v1.0.6b

## Versi Neo, versi 22.x.y.
Docker hub versi 22..x.y adalah feeder versi NEO. Misalnya, versi feeder v1.0.3, maka docker TAG adalah 22.103.x.
Dimana 22 menyatakan tahun 2022 sebagai tahun rilis feeder Neo. 103 adalah versi aplikasi yang dirilis, dan x adalah kode build docker image ini. 

## Persiapan
Copy directory 'pgsql' yang disediakan oleh installer. Letakkan pada directory volume data database PostgreSQL. Misalnya `/home/pizaini/docker-volume/feeder/pgsql`

## Docker compose
See [docker-compose.yaml](https://github.com/pizaini/docker-feeder-pddikti/blob/master/docker-compose.yaml)

## Cara menggunakan
Run docker compose
`docker compose up -d`

## Volumes
Volume pada Feeder-app bersifat optional, Anda dapat menggunakan volume yg ada di docker-compose.yaml.
Sedangkan volume dbpddikti harus ada. Untuk menyimpan database secara permanen.

## Prefill
1. Uncomment konfigurasi volume di docker compose pada service feeder
2. Copy file prefill ke direktory host volume `/home/pizaini/docker-volume/feeder-neo/prefill_pddikti`
3. Jalankan aplikasi dan lakukan prefill seperti yang dijelaskan pada manual penggunaan

## Migrasi
Jika menggunakan teknik migrasi, tidak perlu prefill.

## Directory owner
User default aplikasi feeder adalah 'www'. Maka kita perlu menyesuikan volume yang di-bind. Caranya, masuk ke docker container
`docker exec -ti feeder_pddikti`

lalu ganti directory owner berikut
`chown www:www -R /prefill_pddikti`

Optional jika diperlukan
`chown www:www -R /app`

## SSL
Secara default, docker pddikti tidak menyertakan pengaturan HTTPS. Padahal ini SANGAT PENTING menjaga kerahasiaan akun PDDIKTI. Akun yg digunakan di Feeder biasanya AKUN ADMINISTRATOR Perguruan Tinggi. Bayangkan jika akun tersebut diketahui orang lain dan masuk ke sistem penting PDDIKTI seperti Feeder dan PDDIKTI ADMIN. Gak kebayang saya, sama seperti pencurian kartu ATM beserta PIN nya, hehe...

Untuk mengatur HTTPS/SSL silakan modifikasi file `nginx.conf`. Anda juga bisa menggunakan reverse proxy.

## Custom port
Secara default, feeder docker membuka port 8100 dan 3003 dari host server. Dan URL menjadi `https://namadomain.ac.id:8100` dan alamat API `https://namadomain.ac.id:8100`. Nah, di repo ini, kita bisa menggunakan custom port misalnya dengan mengambalikan port HTTPS ke 443 baik feeder web maupun API. Sehingga URL menjadi `https://namadomain.ac.id` untuk web feeder dan `https://namadomain.ac.id/ws`. Lebih formal, bukan?

Anda juga harus modifikasi file `nginx.conf` agar menyesuaikan port 8100 dan 3003 ke port 443. 

Anda juga bisa mengguankan reverse proxy untuk menggunakan custom port ini.

## Reverse proxy
Jika menggunakan reverse proxy misalnya Nginx, kita dapat mengatur HTTPS/SSL dan custom port di pengaturan block nginx. Kami sendiri menggunakan teknik ini agar tidak banyak mengubah pengaturan standard Feeder. Kami menggunakan Nginx reverse proxy untuk bisa mengatur HTTPS dan memforward request ke port yg dibuka container Feeder (default 8100 dan 3003).

Anda juga dapat mengaturan port default feeder 8100 dan 3003 tidak terbuka untuk akses ekternal sehingga port tersebut hanya dapat diakses oleh host.
````
    feeder:
        ...
        ports:
            - "127.0.0.1:8100:8100"
            - "127.0.0.1:3003:3003"
        ...
  ````

## Source
https://github.com/pizaini/docker-feeder-pddikti
