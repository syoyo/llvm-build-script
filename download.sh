#!/bin/bash

LLVM_VERSION="8.0.1"
BASE_DOWNLOAD_URI="https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}"

curdir=`pwd`

set -x

function download_src() {

  mkdir -p llvm-src-${LLVM_VERSION}
  cd llvm-src-${LLVM_VERSION}

  if [ ! -f "llvm-${LLVM_VERSION}.src.tar.xz" ]; then curl -L -O ${BASE_DOWNLOAD_URI}/llvm-${LLVM_VERSION}.src.tar.xz; fi
  if [ ! -f "cfe-${LLVM_VERSION}.src.tar.xz" ]; then curl -L -O ${BASE_DOWNLOAD_URI}/cfe-${LLVM_VERSION}.src.tar.xz; fi
  if [ ! -f "compiler-rt-${LLVM_VERSION}.src.tar.xz" ]; then curl -L -O ${BASE_DOWNLOAD_URI}/compiler-rt-${LLVM_VERSION}.src.tar.xz; fi
  if [ ! -f "libcxx-${LLVM_VERSION}.src.tar.xz" ]; then curl -L -O ${BASE_DOWNLOAD_URI}/libcxx-${LLVM_VERSION}.src.tar.xz; fi
  if [ ! -f "libcxxabi-${LLVM_VERSION}.src.tar.xz" ]; then curl -L -O ${BASE_DOWNLOAD_URI}/libcxxabi-${LLVM_VERSION}.src.tar.xz; fi
  if [ ! -f "libunwind-${LLVM_VERSION}.src.tar.xz" ]; then curl -L -O ${BASE_DOWNLOAD_URI}/libunwind-${LLVM_VERSION}.src.tar.xz; fi
  if [ ! -f "lld-${LLVM_VERSION}.src.tar.xz" ]; then curl -L -O ${BASE_DOWNLOAD_URI}/lld-${LLVM_VERSION}.src.tar.xz; fi
  if [ ! -f "lldb-${LLVM_VERSION}.src.tar.xz" ]; then curl -L -O ${BASE_DOWNLOAD_URI}/lldb-${LLVM_VERSION}.src.tar.xz; fi

  cd ${curdir}
}

download_src;

