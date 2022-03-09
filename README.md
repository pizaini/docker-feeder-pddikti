# Aplikasi Feeder PDDIKTI: versi NEO
Hadirnya Feeder PDDIKTI versi NEO merupakan terobosan yang patut diapresisasi. Sebelumnya, repo ini membuat docker image dengan membuat dockerfile sendiri agar Aplikasi Feeder dapat digunakan di docker ditambah kritik terhadap proyek pemerintah itu yang 'mempersulit' perguruan tinggi. Namun, dengan adanya Feeder PDDIKTI versi NEO yang rilis akhir Februari 2022 adalah langkah bagus. Kita perlu apresiasi dan bangga karna DIKTI/Kemendikbud mau mengadopsi teknologi docker di aplikasinya. 

Di repo ini, saya hanya menghadirkan Feeder PDDIKTI yang versi dockernya tidak tersedia di docker hub. Sekaligus ingin berbagi apa yang kami lakukan agar penggunaan Feeder Neo dapat berjalan dengan lebih baik.

## Versi Neo, versi 22.2.x.
Docker hub versi 22.2 adalah feeder versi NEO

## Persiapan
1. Copy directory 'pgsql' yang disediakan oleh installer. Letakkan pada directory volume data database PostgreSQL. Misalnya `/home/pizaini/docker-volume/feeder/pgsql`
2. Copy directory 'nginx' yang disediakan oleh installer. Letakkan pada directory volume data database Nginx config. Misalnya `/home/pizaini/docker-volume/feeder/nginx`
3. Copy directiry 'app' dari github repository ini ke directory yang diinginkan misalnya `/home/pizaini/docker-volume/feeder/app`

## Cara menggunakan
Run docker compose
`docker compose up -d`

## Prefill
1. Copy file prefill ke direktory host volume `/home/pizaini/docker-volume/feeder-neo/prefill_pddikti`
2. Jalankan aplikasi dan lakukan prefill seperti yang dijelaskan pada manual penggunaan

## Migrasi
Jika menggunakan teknik migrasi, tidak perlu prefill.

## Directory owner
User default aplikasi feeder adalah 'www'. Maka kita perlu menyesuikan volume yang di-bind. Caranya, masuk ke docker container
`docker exec -ti feeder_pddikti`

lalu ganti directory owner berikut

`chown www:www -R /prefill_pddikti`

`chown www:www -R /app`

## SSL
Secara default, docker pddikti tidak menyertakan pengaturan HTTPS. Padahal ini SANGAT PENTING menjaga kerahasiaan akun PDDIKTI. Dan akun yg digunakan di Feeder biasanya AKUN ADMINISTRATOR Perguruan Tinggi. Bayangkan jika akun tersebut diketahui orang lain dan masuk ke sistem penting PDDIKTI seperti Feeder dan PDDIKTI ADMIN. Gak kebayang saya, sama seperti pencurian kartu ATM, hehe...

Untuk mengatur HTTPS/SSL silakan modifikasi file `/home/pizaini/docker-volume/feeder-neo/nginx/nginx.conf`. Anda juga bisa menggunakan reverse proxy.

## Custom port
Secara default, feeder docker membuka port 8100 dan 3003 dari host server. Dan URL menjadi `https://namadomain.ac.id:8100` dan alamat API `https://namadomain.ac.id:8100`. Nah, di repo ini, kita bisa menggunakan custom port misalnya dengan mengambalikan port HTTPS ke 443 baik feeder web maupun API. Sehingga URL menjadi `https://namadomain.ac.id` untuk web feeder dan `https://namadomain.ac.id/ws`. Lebih formal, bukan?

Caranya dengan mengubah nama (rename) file `/home/pizaini/docker-volume/feeder-neo/app/public/index-custom.html` menjadi `/home/pizaini/docker-volume/feeder-neo/app/public/index.html`

Namun jika tidak menggunakan 'bind volume' pada docker compose silakan masuk ke container `docker exec -ti feeder_pddikti` lalu rename file `/app/index-custom.html` menjadi `/app/index.html`

Anda juga harus modifikasi file `/home/pizaini/docker-volume/feeder-neo/nginx/nginx.conf` agar menyesuaikan port 8100 dan 3003 ke port 443. 

Anda juga bisa mengguankan reverse proxy untuk menggunakan custom port ini.

## Reverse proxy
Jika menggunakan reverse proxy misalnya Nginx, kita dapat mengatur HTTPS/SSL dan custom port di pengaturan block nginx. Kami sendiri menggunakan teknik ini agar tidak banyak mengubah pengaturan standard Feeder. Kami menggunakan Nginx reverse proxy untuk bisa mengatur HTTPS dan memforward request ke port yg dibuka container Feeder (default 8100 dan 3003).

## Source
https://github.com/pizaini/docker-feeder-pddikti