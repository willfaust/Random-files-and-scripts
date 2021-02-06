termux-setup-storage

pkg update -y
pkg install vim

rm -f title.keys, ~/storage/shared/Documents/title.keys # removes any old title.keys file

shopt -s globstar # enable globstar

for i in ~/storage/shared/**/*.nsp
do
	reference=$(xxd "$i" | grep -oP -m 1 ".{8}(?=.{43}Root-CA00000003-)")
	titleloc=$(printf "%x\n" $((16#$reference + 16#160)))
	keyloc=$(printf "%x\n" $((16#$reference + 16#40)))
	title=$(xxd "$i" | grep -oP -m 1 "(?<=$titleloc: ).{39}" | sed 's/ //g')
	key=$(xxd "$i" | grep -oP -m 1 "(?<=$keyloc: ).{39}" | sed 's/ //g')
	echo $title=$key >> title.keys
done

cp title.keys ~/storage/shared/Documents/title.keys
