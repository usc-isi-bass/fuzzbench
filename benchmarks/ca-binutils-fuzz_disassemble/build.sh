
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
	export SKIPLIST="libiberty/ zlib/ bfd/ opcodes/ libctf/ gas/expr.c filemode.c 
	addr2line.c elfcomm.c is-ranlib.c nm.c od-elf32_avr.c rdcoff.c   rescoff.c stabs.c ar.c 
	binemul.c   debug.c    elfedit.c       is-strip.c      not-ranlib.c  od-macho.c      rddbg.c    resrc.c    strings.c      windmc.c
	arsup.c      bucomm.c    dlltool.c  emul_aix.c      maybe-ranlib.c  not-strip.c   od-xcoff.c      readelf.c  resres.c   sysdump.c      windres.c
	bfdtest1.c   coffdump.c  dllwrap.c  emul_vanilla.c  maybe-strip.c   objcopy.c     prdbg.c         rename.c   size.c     syslex_wrap.c  winduni.c
	bfdtest2.c   coffgrok.c  dwarf.c    filemode.c      mclex.c         objdump.c     rclex.c         resbin.c   srconv.c   unwind-ia64.c  wrstabs.c
	ld/lexsup.c"
	export SKIPFUNCS="bb_read_rec"
fi

./configure --disable-gdb --disable-gdbserver --disable-gdbsupport \
	    --disable-libdecnumber --disable-readline --disable-sim \
	    --enable-targets=all --disable-werror
make -j4

mkdir -p fuzz
cp ../fuzz_*.c fuzz/
cd fuzz

$CC $CFLAGS -I ../include -I ../bfd -I ../opcodes -c fuzz_disassemble.c -o fuzz_disassemble.o
$CXX $CXXFLAGS fuzz_disassemble.o -o $OUT/fuzz_disassemble $LIB_FUZZING_ENGINE ../opcodes/libopcodes.a ../bfd/libbfd.a ../libiberty/libiberty.a ../zlib/libz.a
