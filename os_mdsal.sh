if [ -z $1 ]; then
    echo "Usage: $0 DIRECTORY"
    exit
fi

dir=$1
../tools/showOvsdbMdsal.py -c -i 192.168.50.1 > $dir/mdsalc.txt
../tools/showOvsdbMdsal.py -c -i 192.168.50.1 -d > $dir/mdsalc_d.txt
../tools/showOvsdbMdsal.py -c -i 192.168.50.1 -ddddd > $dir/mdsalc_ddddd.txt
../tools/showOvsdbMdsal.py -i 192.168.50.1 -ddddd > $dir/mdsalo_ddddd.txt
../tools/showOvsdbMdsal.py -i 192.168.50.1 -d > $dir/mdsalo_d.txt
../tools/showOvsdbMdsal.py -i 192.168.50.1  > /$dir/mdsalo.txt
