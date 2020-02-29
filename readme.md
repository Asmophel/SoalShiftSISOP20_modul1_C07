# SoalShift_Modul 1 Kelompok C07
##### Fandi Wahyu R - 05111840000108, Brananda Denta WP - 05111840000143

### Outline
+ [Soal 1](#soal-1)
    * [1a](#1a)
    * [1b](#1b)
    * [1c](#1c)
+ [Soal 2](#soal-2)
    * [2a](#2a)
    * [2b](#2b)
    * [2c](#2c)
    * [2d](#2d)
+ [Soal 3](#soal-3)
    * [3a](#3a)
    * [3b](#3b)
    * [3c](#3c)

### Soal 1
Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”.
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :

a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit

b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a

c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b
Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan
laporan tersebut.
*Gunakan Awk dan Command pendukung
#### 1a
untuk memproses data, gunakan syntax `awk` 

```
echo "a. Wilayah(Region) dengan profit paling sedikit adalah :"
lpreg=$(awk -F "\t" '{
    if ($13 == "South" || $13 == "Central" || $13 == "West" || $13 == "East"){
        array[$13] += $21
    }
} END {
    for(i in array) {
        print i, array[i]
    }
}' Sample-Superstore.tsv | sort -g -k2 | head -n 1 | awk '{print $1}')
echo "$lpreg"
```
pertama buat variabel lpreg berisi value dari data yg akan kita proses, agar nanti dapat dibandingkan dengan soal b

kelompokkan isi kolom 13 yang sama yaitu South, Central, West, East lalu jumlahkan profit masing-masing dengan syntax
```
array[$13] += $21
```
lalu print semua hasilnya dengan syntax
```
for(i in array) {
        print i, array[i]
    }
```

i sebagai index Region dan array[i] sebagai nilai profit

```
Sample-Superstore.tsv
```
adalah file berisi data yang ingin diproses
```
sort -g -k2
```
-g berfungsi untuk mengurutkan angka, sedangkan -k2 adalah berarti yang diurutkan adalah kolom ke 2
```
head -n 1
```
Fungsinya adalah menampilkan n baris data, dalam kasus ini 1 baris
```
awk '{print $1}'
```
untuk print data pada kolom 1, yaitu Region

#### 1b
```
echo "b. 2 Negara bagian(State) dengan profit paling sebikit berdasarkan poin a adalah :"
lpstate1=$(awk -F "\t" -v lpreg=$lpreg '{
    if ($13 == lpreg){
        array[$11] += $21
    }
} END {
    for (i in array){
        print array[i], i
    }
}' Sample-Superstore.tsv |sort -g -k1 | head -n 1 | awk '{first=$1; $1=""; print $0}')

lpstate2=$(awk -F "\t" -v lpreg=$lpreg '{
    if ($13 == lpreg){
        array[$11] += $21
    }
} END {
    for (i in array){
        print array[i],i
    }
}' Sample-Superstore.tsv |sort -g -k1 | head -n 2 | tail -n 1 | awk '{first=$1; $1=""; print $0}')

lpsta1="$(echo -e "${lpstate1}" | sed -e 's/^[[:space:]]*//')"
lpsta2="$(echo -e "${lpstate2}" | sed -e 's/^[[:space:]]*//')"

echo "$lpsta1"
echo "$lpsta2"
```
buat variabel lpstate berisi value dari data yg akan kita proses, agar nanti dapat dibandingkan dengan soal c disini dibuat 2 syntax awk, karena terdapat kesusahan memisahkan 1 awk yang besrisi 2 data

```
-v lpreg=$lpreg
```
-v berfungsi untuk mengambil variabel yang berada diluar syntax awk 

dengan kondisi data di kolom 13(Region) sama dengan output soal a, lalu kelompokkan isi kolom 11 yang sama yaitulalu jumlahkan isinya dari kolom 21 (profit) masing-masing, dengan syntax:
```
    if ($13 == lpreg){
        array[$11] += $21
    }
```
lalu print semua hasilnya dengan syntax
```
for(i in array) {
        print array[i],i
    }
```

i sebagai index Region dan array[i] sebagai nilai profit

```
Sample-Superstore.tsv
```
adalah file berisi data yang ingin diproses
```
sort -g -k2
```
-g berfungsi untuk mengurutkan angka, sedangkan -k2 adalah berarti yang diurutkan adalah kolom ke 2

pada awk pertama digunakan
```
head -n 1
```
Fungsinya adalah menampilkan n baris data, dalam kasus ini 1 baris.

sedangkan pada awk kedua digunakan
```
head -n 2 | tail -n 1
```
karena data yg dibutuhkan adalah terendah kedua, maka setelah ditampilkan 2 data dari atas, dari data tersebut ditampilkan lagi 1 dari bawah

```
 awk '{first=$1; $1=""; print $0}'
```
karena kolom 1 berisi profit, maka hilangkan kolom 1, lalu print semua data. awk pertama dan kedua sama

```
lpsta1="$(echo -e "${lpstate1}" | sed -e 's/^[[:space:]]*//')"
lpsta2="$(echo -e "${lpstate2}" | sed -e 's/^[[:space:]]*//')"
```
syntax diatas digunakan untuk menghilangkan spasi didepannya

#### 1c
```
echo "c. 10 produk dengan profit tersedikit adalah :"
lpproduct=$(awk -F "\t" -v lpstate1="$lpsta1" -v lpstate2="$lpsta2" '{
    if ($11 == lpstate1 || $11 == lpstate2){
        array[$17] += $21
    }
} END {
    for (i in array){
        print array[i], i
    }
}' Sample-Superstore.tsv |sort -g -k1| head -n 10 | awk '{first=$1; $1=""; print $0}')

lppro="$(echo -e "${lpproduct}" | sed -e 's/^[[:space:]]*//')"

echo "$lppro"
```

```
-v lpstate1="$lpsta1" -v lpstate2="$lpsta2"
```
syntax diatas digunakan untuk mengambil variabel yg berada diluar syntax awk.

Dengan kondisi data di kolom 11(state) sama dengan output soal a, lalu kelompokkan isi kolom 17 yang sama, lalu jumlahkan isinya dari kolom 21 (profit) masing-masing, dengan syntax:
```
    if ($11 == lpstate1 || $11 == lpstate2){
        array[$17] += $21
    }
```
lalu print semua hasilnya dengan syntax
```
for(i in array) {
        print array[i],i
    }
```

i sebagai index Region dan array[i] sebagai nilai profit

```
Sample-Superstore.tsv
```
adalah file berisi data yang ingin diproses
```
sort -g -k1
```
-g berfungsi untuk mengurutkan angka, sedangkan -k1 adalah berarti yang diurutkan adalah kolom ke 1 yaitu profit

```
head -n 10
```
Fungsinya adalah menampilkan n baris data dari atas, dalam kasus ini 10 baris.

```
 awk '{first=$1; $1=""; print $0}'
```
karena kolom 1 berisi profit, maka hilangkan kolom 1, lalu print semua data.

```
lppro="$(echo -e "${lpproduct}" | sed -e 's/^[[:space:]]*//')"

```
syntax diatas digunakan untuk menghilangkan spasi didepannya

## Soal 2
### Soal
 Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka
meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.
Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang
dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi
.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
(c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28,
maka akan menjadi huruf b.) dan (d) jangan lupa untuk membuat dekripsinya supaya
nama file bisa kembali.

### penyelesaian
### 2a
membuat fungsi random untuk meng-random password yang dibutuhkan sepanjang 28 kombinasi huruf besar, huruf kecil, dan angka.
```
    function random(){

    array=()

    for i in {a..z} {A..Z} {0..9};
    do
        array[$RANDOM]=$i
    done

    printf %s ${array[@]::28} > /home/denta/Downloads/$a
    }
```

membuat deklarasi variabel array
```
array=()
```

menggunakan looping for untuk mendapatkan nilai huruf besar, kecil dan angka
```
for i in {a..z} {A..Z} {0..9};
    do
        array[$RANDOM]=$i
    done
```

lalu di print dan diberi batasan sebanyak 28 karakter
```
 printf %s ${array[@]::28} > /home/denta/Downloads/$a
```
### 2b
membuat variabel untuk menampung argumen yang diinputkan
```
a=$1
```
lalu memasukkan hasil random ke dalam file yang bernama sesuai dengan argumen yang di inputkan
```
printf %s ${array[@]::28} > /home/denta/Downloads/$a
```
### 2c
membuat variabel untuk menampung argumen yang diinputkan
```
name=$1
```

memisahkan nama file dengan ekstensinya
```
filename="${name%.*}"
```

mengambil format angka jam dan di simpan dalam variabel bernama geser
```
geser=$(stat -c %y $1 | grep -o -P '(?<= ).*(?=:.*:)')
``` 

```
stat -c %y $1
```
digunakan untuk mengambil format time pada file

```
grep -o -P '(?<= ).*(?=:.*:)')
```
digunakan untuk mengambil nilai jam dalam time yang sudah di akses melalui stat tadi

menyediakan deretan huruf besar dan huruf kecil
```
kecil="abcdefghijklmnopqrstuvwxyz"
besar="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
```

lalu nama file yang sudah di pisahkan dengan ekstensi nya dilakukan enkripsi dengan cara menggunakan command sed
```
caesar=$(echo "$filename" | sed "y/$low$up/${low:$geser}${low::$geser}${up:$geser}${up::$geser}/")
```

perintah
```
sed "y/$low$up/${low:$geser}${low::$geser}${up:$geser}${up::$geser}/"
```
digunakan untuk mengubah huruf per huruf menjadi ditambah dengan jam pembuatan file.

caranya adalah dengan menggunakan string manipulation
jadi 
```
${low:$geser}
```
jika misal hasil dari geser nya adalah 3. maka isi dari low akan di mulai dari setelah index ke-3, jadi defghijklmnopqrstuvwxyz
dan 
```
${low::$geser}
```
adalah untuk menampung nilai abc nya.

lalu saya membuat kondisi dimana kodingan enkripsi ini akan berjalan jika jam nya >0.
dan mengembalikan ekstensi file .txt
```
if [ $geser -ne 0 ]
then
mv $name "${caesar}".txt
fi
```

### 2d
dekripsi nya pakai cara yang sama dengan enkripsi tetapi variabel geser dikalikan dengan -1 sehingga index nya bergerak mundur
```
geser=$((geser * -1))
```

## Soal 3
### soal
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati
kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang
sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma,
kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. [a] Maka dari
itu, kalian mencoba membuat script untuk mendownload 28 gambar dari
"https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file
dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam
sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya
berjalan[b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena
gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda
antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke
Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan
kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] Maka dari
itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).
Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya
merupakan hasil dari grep "Location".
*Gunakan Bash, Awk dan Crontab

### penyelesaian
### 3a
membuat script untuk men-download gambar dari link "https://loremflickr.com/320/240/cat" sebanyak 28 kali menggunakan command wget
```
#!/bin/bash
b=28
for ((a=1; a <= $b; a=a+1))
do
wget -a https://loremflickr.com/320/240/cat
done
```
lalu setelah di download dirubah nama gambar nya menjadi "pdkt_kusuma_NO"
```
wget https://loremflickr.com/320/240/cat -O dkt_kusuma_NO_$a
```

lalu  menyimpan log message ke dalam wget.log
```
wget -a wget.log https://loremflickr.com/320/240/cat
```

### 3b
membuat crontab yang berguna untuk mendownload gambar setiap 8 jam dimulai dari jam 06.05 mulai dari hari minggu sampai jum'at
```
crontab -e
```
```
5 6-23/8 * * 0-5 bash Modul_1_3_C07.sh
```

### 3c
Kita diharuskan mengecek apakah foto yang didownload sudah ada atau belum, jika ada, akan masuk ke folder 
```
duplicate
``` 
jika baru akan masuk ke folder 
```
kenangan
```
Source code keseluruhan :

```
cat wget.log | grep Location: > location.log

mkdir kenangan
mkdir duplicate

awk '{
	i++
	print i " " $2
}' location.log | awk '
	{
		count[$2]++
		if (count[$2] > 1){
			system("mv pdkt_kusuma_"$1 " duplicate/duplicate_" $1)
		}else{
			system("mv pdkt_kusuma_"$1 " kenangan/kenangan_" $1)
		}
	}
'

cat location.log >> location.log.bak
> location.log

cat wget.log >> wget.log.bak
> wget.log

```
Pertama, masukkan logfile di ``` wget.log```yang memuat kata```location :```ke dalam file```location.log```dengan 
```
cat wget.log | grep Location: > location.log
```
Lalu, buat folder ```kenangan ```dan```duplicate```
dengan
```
mkdir kenangan
mkdir duplicate
```
Selanjutnya, gunakan perintah ```awk``` untuk memberi index/nomor pada setiap urutan gambar yang didownload, lalu ambil path dari ```location.log```yang nantinya akan dibuat untuk identifikasi file yang identik. lalu hasil ```awk``` tadi dijalankan perintah ```awk``` lagi.
Buat assosiative array yang indexnya adalah path yang diambil dari ```location.log``` tadi. jika index sama, maka value ditambah 1.
Lalu dalam setiap baris dicek jika sudah ada file dengan path yang sama akan dipindah kedalam file ```duplicate``` dengan nama ```duplicate_xx```. Jika file masih baru akan dipindah kedalam file ```kenangan``` dengan nama ```kenangan_xx```

Source code :
```
awk '{
	i++
	print i " " $2
}' location.log | awk '
	{
		count[$2]++
		if (count[$2] > 1){
			system("mv pdkt_kusuma_"$1 " duplicate/duplicate_" $1)
		}else{
			system("mv pdkt_kusuma_"$1 " kenangan/kenangan_" $1)
		}
	}
'
```

Setelah semua selesai, backup file ```wget.log``` dan ```location.log```. Baca file dengan ```cat```  lalu masing-masing file diappend dengan format ```log.bak```. Kosongkan file agar dapat digunakan untuk pemisahan selanjutnya dengan ```> location.log```
Source code:
```
cat location.log >> location.log.bak
> location.log

cat wget.log >> wget.log.bak
> wget.log
```
