#!/bin/bash

LLVM_VERSION=8.0.1
sourcefiles="llvm-${LLVM_VERSION}.src cfe-${LLVM_VERSION}.src compiler-rt-${LLVM_VERSION}.src"
sourcefiles="${sourcefiles} libcxx-${LLVM_VERSION}.src libcxxabi-${LLVM_VERSION}.src"
sourcefiles="${sourcefiles} libunwind-${LLVM_VERSION}.src lld-${LLVM_VERSION}.src lldb-${LLVM_VERSION}.src"              \
#sourcefiles="${sourcefiles} openmp-${LLVM_VERSION}.src polly-${LLVM_VERSION}.src"
#sourcefiles="${sourcefiles} clang-tools-extra-${LLVM_VERSION}.src"

llvm_build_root=llvm-${LLVM_VERSION}.src

curdir=`pwd`

cd llvm-src-${LLVM_VERSION}

rm -rf ${llvm_build_root}

for base in ${sourcefiles}
do
  if [ ! -f "${base}.tar.xz"]; then wget -t inf -c http://llvm.org/releases/${LLVM_VERSION}/${base}.tar.xz; fi
  tar xvf ${base}.tar.xz
done


mv -v cfe-${LLVM_VERSION}.src ${llvm_build_root}/tools/clang
#mv -v clang-tools-extra-${LLVM_VERSION}.src ${llvm_build_root}/tools/clang/tools/extra
mv -v compiler-rt-${LLVM_VERSION}.src ${llvm_build_root}/projects/compiler-rt
mv -v libcxx-${LLVM_VERSION}.src ${llvm_build_root}/projects/libcxx
mv -v libcxxabi-${LLVM_VERSION}.src ${llvm_build_root}/projects/libcxxabi
mv -v libunwind-${LLVM_VERSION}.src ${llvm_build_root}/projects/libunwind

# TODO(syoyo): build lld/lldb
#mv -v lld-${LLVM_VERSION}.src ${llvm_build_root}/tools/lld
#mv -v lldb-${LLVM_VERSION}.src ${llvm_build_root}/tools/lldb

#mv -v openmp-${LLVM_VERSION}.src ${llvm_build_root}/projects/openmp
#mv -v polly-${LLVM_VERSION}.src ${llvm_build_root}/tools/polly

mkdir ${llvm_build_root}/build
cd ${llvm_build_root}/build

# https://boxbase.org/entries/2018/jun/11/minimal-llvm-build/
# Add 
#  -DLLVM_TARGETS_TO_BUILD="host" \
#  -DLLVM_BUILD_TOOLS="NO" \
#  -DLLVM_BUILD_LLVM_DYLIB="YES" \
# To reduce binary size.

cmake -G Ninja \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DCMAKE_C_COMPILER=clang \
  -DLLVM_ENABLE_TERMINFO=Off \
  -DLLVM_ENABLE_LIBCXX=On \
  -DCMAKE_INSTALL_PREFIX=$HOME/local/clang+llvm-${LLVM_VERSION} \
  -DCMAKE_BUILD_TYPE=MinSizeRel \
  -DLLVM_TARGETS_TO_BUILD="host" \
  -DLLVM_BUILD_TOOLS="NO" \
  -DLLVM_BUILD_LLVM_DYLIB="YES" \
  ..

ninja && ninja install

cd ${curdir}
