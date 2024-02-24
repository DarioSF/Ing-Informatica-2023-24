set terminal png

set xtics ("2¹⁵" 32768, "2²⁰" 1048576, "2²¹" 2097152, "2²²" 4194304, "2²³" 8388608)

set xlabel "size of arrays"
set ylabel "Millions of program steps"

set yrange[0:]

set output "quickSort.png"
set title "Quicksort"
plot "qs-vs-hs.Msteps" using 1:2 w l title "random arrays",\
     "qs-vs-hs.Msteps" using 1:4 w l title "sorted arrays",\
     "qs-vs-hs.Msteps" using 1:6 w l title "reverse-sorted-arrays"

set output "heapSort.png"
set title "Heapsort"
plot "qs-vs-hs.Msteps" using 1:3 w l title "random arrays",\
     "qs-vs-hs.Msteps" using 1:5 w l title "sorted arrays",\
     "qs-vs-hs.Msteps" using 1:7 w l title "reverse-sorted arrays"

y(x) = a1xlog(x)+b1x+c1
z(x) = a2xlog(x)+b2x+c2

set output "qs-vs-hs-RA.png"
set title "QuickSort versus Heapsort (random arrays)"

fit y(x) "qs-vs-hs.Msteps" using 1:2 via a1,b1,c1
fit z(x) "qs-vs-hs.Msteps" using 1:3 via a2,b2,c2

plot "qs-vs-hs.Msteps" using 1:2 w l title "Quicksort",\
     "qs-vs-hs.Msteps" using 1:3 w l title "Heapsort",\
y(x) w l title "fitting QuickSort time values to n·log(n)+n",\
z(x) w l title "fitting HeapSort time values to n·log(n)+n"

set output "qs-vs-hs-SA.png"
set title "QuickSort versus Heapsort (sorted arrays)"

fit y(x) "qs-vs-hs.Msteps" using 1:2 via a1,b1,c1
fit z(x) "qs-vs-hs.Msteps" using 1:3 via a2,b2,c2

plot "qs-vs-hs.Msteps" using 1:2 w l title "Quicksort",\
     "qs-vs-hs.Msteps" using 1:3 w l title "Heapsort",\
y(x) w l title "fitting QuickSort time values to n·log(n)+n",\
z(x) w l title "fitting HeapSort time values to n·log(n)+n"

set output "qs-vs-hs-RSA.png"
set title "QuickSort versus Heapsort (reverse-sorted arrays)"

fit y(x) "qs-vs-hs.Msteps" using 1:2 via a1,b1,c1
fit z(x) "qs-vs-hs.Msteps" using 1:3 via a2,b2,c2

plot "qs-vs-hs.Msteps" using 1:2 w l title "Quicksort",\
     "qs-vs-hs.Msteps" using 1:3 w l title "Heapsort",\
y(x) w l title "fitting QuickSort time values to n·log(n)+n",\
z(x) w l title "fitting HeapSort time values to n·log(n)+n"