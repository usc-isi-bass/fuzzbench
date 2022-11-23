
pushd /src/Cannotate
./fuzzbench-install.sh
popd


cd binutils-gdb
git apply ../fr_injection.patch

cd binutils
sed -i 's/vfprintf (stderr/\/\//' elfcomm.c
sed -i 's/fprintf (stderr/\/\//' elfcomm.c
cd ../

if [ -z $FR_COV_BUILD ]; then
	export ORIG_CC=$CC
	export CC=cannotate-cc
	export ADDITIONAL_FLAGS="-I/src/Cannotate/clang+llvm-13/lib/clang/13.0.0/include"
	export SKIPLIST="libiberty/"
fi
./configure --disable-gdb --disable-gdbserver --disable-gdbsupport \
	    --disable-libdecnumber --disable-readline --disable-sim \
	    --enable-targets=all --disable-werror
make -j4
export CC=$ORIG_CC

cd binutils
cp ../../fuzz_cxxfilt.c .

sed 's/main (int argc/old_main (int argc, char **argv);\nint old_main (int argc/' cxxfilt.c > cxxfilt.h

$CC $CFLAGS -DHAVE_CONFIG_H -I. -I../bfd -I./../bfd -I./../include -I./../zlib -DLOCALEDIR="\"/usr/local/share/locale\"" -Dbin_dummy_emulation=bin_vanilla_emulation -W -Wall -MT fuzz_cxxfilt.o -MD -MP -c -o fuzz_cxxfilt.o fuzz_cxxfilt.c

$CXX $CXXFLAGS $LIB_FUZZING_ENGINE -W -Wall -Wstrict-prototypes -Wmissing-prototypes -Wshadow -I./../zlib -o fuzz_cxxfilt fuzz_cxxfilt.o bucomm.o version.o filemode.o ../bfd/.libs/libbfd.a -L/src/binutils-gdb/zlib -lpthread -ldl -lz ../libiberty/libiberty.a
mv fuzz_cxxfilt $OUT/fuzz_cxxfilt

cp $SRC/fuzz_cxxfilt.options $OUT/fuzz_cxxfilt.options
