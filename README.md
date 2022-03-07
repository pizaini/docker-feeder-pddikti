# Aplikasi Feeder PDDIKTI: versi NEO
Hadirnya Feeder PDDIKTI versi NEO merupakan terobosan yang patut diapresisasi. Sebelumnya, repo ini membuat docker image dengan membuat dockerfile sendiri agar Aplikasi Feeder dapat digunakan di docker ditambah kritik terhadap proyek pemerintah itu yang 'mempersulit' perguruan tinggi. Namun, dengan adanya Feeder PDDIKTI versi NEO yang rilis akhir Februari 2022 adalah langkah bagus. Kita perlu apresiasi dan bangga karna DIKTI/Kemendikbud mau mengadopsi teknologi docker di aplikasinya. 

Di repo ini, saya hanya menghadirkan Feeder PDDIKTI yang versi dockernya tidak tersedia di docker hub. Sekaligus ingin berbagi apa yang kami lakukan agar penggunaan Feeder Neo dapat berjalan dengan lebih baik.

## Versi Neo, versi 22.2.x.
Docker hub versi 22.2 adalah feeder versi NEO

## Persiapan
1. Copy directory 'pgsql' yang disediakan oleh installer. Letakkan pada directory volume data database PostgreSQL. Misalnya `/home/pizaini/docker-volume/feeder/pgsql`
2. Copy directory 'nginx' yang disediakan oleh installer. Letakkan pada directory volume data database Nginx config. Misalnya `/home/pizaini/docker-volume/feeder/nginx`

## Docker compose
See [docker-compose.yaml](https://github.com/pizaini/docker-feeder-pddikti/blob/master/README.md)

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

Lalu, di dalam container ganti directory owner berikut (sesuaikan dengan volume di docker compose)
`chown www:www -R /home/pizaini/docker-volume/feeder-neo/prefill_pddikti`

`chown www:www -R /home/pizaini/docker-volume/feeder-neo/nginx`

## Source
https://github.com/pizaini/docker-feeder-pddikti
