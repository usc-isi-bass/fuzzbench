# FuzzBench: Fuzzer Benchmarking As a Service

## Common Issues
- Requires Docker >= 20.
- The minimum fuzzing time is 1000 in order to merge data successfully.   
[https://github.com/google/fuzzbench/issues/777](https://github.com/google/fuzzbench/issues/777).
- Patch protobuf issue in docker.   
[https://github.com/google/fuzzbench/pull/1407/files](https://github.com/google/fuzzbench/pull/1407/files).

## Benchmarks
### Type bug
```
arrow_parquet-arrow-fuzz                                 cpp
aspell_aspell_fuzzer
binutils-fuzz_cxxfilt                              R            CA
binutils-fuzz_disassemble                          R            _
curl                                               R     cpp
ffmpeg_ffmpeg_demuxer_fuzzer                       NS    cpp
file_magic_fuzzer
grok_grk_decompress_fuzzer                               cpp
lcms                                               R            CA
libarchive_libarchive_fuzzer                       NS           CA
libgit2_objects_fuzzer                             NS    cpp
libhevc_hevc_dec_fuzzer                                  cpp
libhtp_fuzz_htp
libpcap                                            R     cpp
libxml2_libxml2_xml_reader_for_file_fuzzer
libxml2_reader                                     R     cpp
libxml2_xml                                        R     cpp
matio_matio_fuzzer
muparser_set_eval_fuzzer                                 cpp
ndpi_fuzz_ndpi_reader
njs_njs_process_script_fuzzer                      NS
openh264_decoder_fuzzer
php_php-fuzz-execute                               NS
php_php-fuzz-parser-2020-07-25                     NS
poppler_pdf_fuzzer                                       cpp
proj4                                              R            CA
proj4_standard_fuzzer
stb_stbi_read_fuzzer
systemd_fuzz-varlink
tpm2_tpm2_execute_command_fuzzer
usrsctp                                            R     cpp
usrsctp_fuzzer_connect                                   cpp
wireshark_fuzzshark_ip                                   cpp
zstd                                               R            CA
zstd_stream_decompress
```

### No SYMCC
```
ffmpeg_ffmpeg_demuxer_fuzzer
lcms-2017-03-21
libpcap_fuzz_both
ndpi_fuzz_ndpi_reader
njs_njs_process_script_fuzzer
php_php-fuzz-execute
php_php-fuzz-parser
php_php-fuzz-parser-2020-07-25
sqlite3_ossfuzz
```

### RevBugBench
```
binutils-fuzz_cxxfilt  binutils-fuzz_disassemble  curl  lcms  libpcap  libxml2_reader  libxml2_xml  proj4  usrsctp  zstd
```

FuzzBench is a free service that evaluates fuzzers on a wide variety of
real-world benchmarks, at Google scale. The goal of FuzzBench is to make it
painless to rigorously evaluate fuzzing research and make fuzzing research
easier for the community to adopt. We invite members of the research community
to contribute their fuzzers and give us feedback on improving our evaluation
techniques.

FuzzBench provides:

* An easy API for integrating fuzzers.
* Benchmarks from real-world projects. FuzzBench can use any
  [OSS-Fuzz](https://github.com/google/oss-fuzz) project as a benchmark.
* A reporting library that produces reports with graphs and statistical tests
  to help you understand the significance of results.

To participate, submit your fuzzer to run on the FuzzBench platform by following
[our simple guide](
https://google.github.io/fuzzbench/getting-started/).
After your integration is accepted, we will run a large-scale experiment using
your fuzzer and generate a report comparing your fuzzer to others.
See [a sample report](https://www.fuzzbench.com/reports/sample/index.html).

## Overview
![FuzzBench Service diagram](docs/images/FuzzBench-service.png)

## Sample Report

You can view our sample report
[here](https://www.fuzzbench.com/reports/sample/index.html) and
our periodically generated reports
[here](https://www.fuzzbench.com/reports/index.html).
The sample report is generated using 10 fuzzers against 24 real-world
benchmarks, with 20 trials each and over a duration of 24 hours.
The raw data in compressed CSV format can be found at the end of the report.

When analyzing reports, we recommend:
* Checking the strengths and weaknesses of a fuzzer against various benchmarks.
* Looking at aggregate results to understand the overall significance of the
  result.

Please provide feedback on any inaccuracies and potential improvements (such as
integration changes, new benchmarks, etc.) by opening a GitHub issue
[here](https://github.com/google/fuzzbench/issues/new).

## Documentation

Read our [detailed documentation](https://google.github.io/fuzzbench/) to learn
how to use FuzzBench.

## Contacts

Join our [mailing list](https://groups.google.com/forum/#!forum/fuzzbench-users)
for discussions and announcements, or send us a private email at
[fuzzbench@google.com](mailto:fuzzbench@google.com).
