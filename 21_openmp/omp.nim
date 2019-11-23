# Compile and run:
# nim c -r -d:release --passc:-march=native -d:openmp omp.nim

import random, times

var size: int

proc genRandom(): seq[int] =
    result = newSeqOfCap[int](size)
    for i in 0 .. size - 1:
        result.add rand(size)

template doubleIt[T](n: T): T =
    n * 2

randomize()

size = 1_000_000_000
echo "Serial"

var a = genRandom()
var startTime = cpuTime()
for i in 0 .. a.high:
    a[i] *= 2
    #a[i] = doubleIt(a[i])
var interval = cpuTime() - startTime
echo "time = ", interval

echo "OpenMP"
a = genRandom()
startTime = cpuTime()
for i in 0 || a.high:
    a[i] *= 2
    #a[i] = doubleIt(a[i])
interval = cpuTime() - startTime
echo "time = ", interval