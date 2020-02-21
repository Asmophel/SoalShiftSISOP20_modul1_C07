echo "1"
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
