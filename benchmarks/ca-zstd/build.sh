#!/bin/bash -eu
# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

git apply ../fr_injection.patch

cd tests/fuzz

if [ -z $FR_COV_BUILD ]; then
	pushd /src/Cannotate
	./fuzzbench-install.sh
	popd

	export ORIG_CC=$CC
	export CC=cannotate-cc
	export ADDITIONAL_FLAGS="-I/src/Cannotate/clang+llvm-13/lib/clang/13.0.0/include"
fi

# Download the seed corpora
make seedcorpora
# Build all of the fuzzers
./fuzz.py build stream_decompress

for target in "stream_decompress"; do
    cp "$target" "$OUT"

    cp "corpora/${target}_seed_corpus.zip" "$OUT"
done
