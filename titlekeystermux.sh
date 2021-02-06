termux-setup-storage

rm -f title.keys, ~/storage/shared/Documents/title.keys # removes any old title.keys file

shopt -s globstar # enable globstar

for i in ~/storage/shared/**/*.nsp
do 
	./hactool -t pfs0 "$i" --outdir output
	title=$(xxd output/*.tik | grep -oP '(?<=000002a0: ).{39}' | sed 's/ //g')
	key=$(xxd output/*.tik | grep -oP '(?<=00000180: ).{39}' | sed 's/ //g')
	echo $title=$key >> title.keys, e.keys
	rm -r -f output
done

cp title.keys ~/storage/shared/Documents/title.keys
