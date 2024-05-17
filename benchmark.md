# Original Redis

====== SET ======
  100000 requests completed in 0.64 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1
  host configuration "save":
  host configuration "appendonly": no
  multi-thread: no

Latency by percentile distribution:
0.000% <= 0.079 milliseconds (cumulative count 2)
50.000% <= 0.151 milliseconds (cumulative count 71483)
75.000% <= 0.159 milliseconds (cumulative count 79242)
87.500% <= 0.271 milliseconds (cumulative count 89365)
93.750% <= 0.303 milliseconds (cumulative count 94086)
96.875% <= 0.423 milliseconds (cumulative count 96938)
98.438% <= 0.583 milliseconds (cumulative count 98441)
99.219% <= 1.159 milliseconds (cumulative count 99224)
99.609% <= 1.671 milliseconds (cumulative count 99623)
99.805% <= 1.719 milliseconds (cumulative count 99809)
99.902% <= 1.775 milliseconds (cumulative count 99907)
99.951% <= 1.855 milliseconds (cumulative count 99954)
99.976% <= 2.023 milliseconds (cumulative count 99977)
99.988% <= 2.095 milliseconds (cumulative count 99988)
99.994% <= 2.119 milliseconds (cumulative count 99994)
99.997% <= 2.159 milliseconds (cumulative count 99997)
99.998% <= 2.183 milliseconds (cumulative count 99999)
99.999% <= 2.191 milliseconds (cumulative count 100000)
100.000% <= 2.191 milliseconds (cumulative count 100000)

Cumulative distribution of latencies:
0.011% <= 0.103 milliseconds (cumulative count 11)
84.550% <= 0.207 milliseconds (cumulative count 84550)
94.086% <= 0.303 milliseconds (cumulative count 94086)
96.658% <= 0.407 milliseconds (cumulative count 96658)
97.877% <= 0.503 milliseconds (cumulative count 97877)
98.505% <= 0.607 milliseconds (cumulative count 98505)
98.687% <= 0.703 milliseconds (cumulative count 98687)
98.775% <= 0.807 milliseconds (cumulative count 98775)
98.842% <= 0.903 milliseconds (cumulative count 98842)
98.983% <= 1.007 milliseconds (cumulative count 98983)
99.148% <= 1.103 milliseconds (cumulative count 99148)
99.279% <= 1.207 milliseconds (cumulative count 99279)
99.330% <= 1.303 milliseconds (cumulative count 99330)
99.374% <= 1.407 milliseconds (cumulative count 99374)
99.420% <= 1.503 milliseconds (cumulative count 99420)
99.487% <= 1.607 milliseconds (cumulative count 99487)
99.763% <= 1.703 milliseconds (cumulative count 99763)
99.932% <= 1.807 milliseconds (cumulative count 99932)
99.963% <= 1.903 milliseconds (cumulative count 99963)
99.973% <= 2.007 milliseconds (cumulative count 99973)
99.991% <= 2.103 milliseconds (cumulative count 99991)
100.000% <= 3.103 milliseconds (cumulative count 100000)

Summary:
  throughput summary: 155521.00 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
        0.184     0.072     0.151     0.343     1.023     2.191
====== GET ======
  100000 requests completed in 0.58 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1
  host configuration "save":
  host configuration "appendonly": no
  multi-thread: no

Latency by percentile distribution:
0.000% <= 0.087 milliseconds (cumulative count 2)
50.000% <= 0.143 milliseconds (cumulative count 53108)
75.000% <= 0.151 milliseconds (cumulative count 76587)
87.500% <= 0.183 milliseconds (cumulative count 88071)
93.750% <= 0.295 milliseconds (cumulative count 93997)
96.875% <= 0.375 milliseconds (cumulative count 97080)
98.438% <= 0.423 milliseconds (cumulative count 98440)
99.219% <= 0.487 milliseconds (cumulative count 99302)
99.609% <= 0.519 milliseconds (cumulative count 99683)
99.805% <= 0.535 milliseconds (cumulative count 99842)
99.902% <= 0.543 milliseconds (cumulative count 99917)
99.951% <= 0.551 milliseconds (cumulative count 99959)
99.976% <= 0.559 milliseconds (cumulative count 99980)
99.988% <= 0.567 milliseconds (cumulative count 99990)
99.994% <= 0.575 milliseconds (cumulative count 99996)
99.997% <= 0.583 milliseconds (cumulative count 99999)
99.999% <= 0.599 milliseconds (cumulative count 100000)
100.000% <= 0.599 milliseconds (cumulative count 100000)

Cumulative distribution of latencies:
0.010% <= 0.103 milliseconds (cumulative count 10)
88.971% <= 0.207 milliseconds (cumulative count 88971)
94.352% <= 0.303 milliseconds (cumulative count 94352)
98.123% <= 0.407 milliseconds (cumulative count 98123)
99.494% <= 0.503 milliseconds (cumulative count 99494)
100.000% <= 0.607 milliseconds (cumulative count 100000)

Summary:
  throughput summary: 170940.17 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
        0.164     0.080     0.143     0.327     0.463     0.599

# Redka

====== SET ======
  100000 requests completed in 2.07 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1
  host configuration "save":
  host configuration "appendonly": no
  multi-thread: no

Latency by percentile distribution:
0.000% <= 0.647 milliseconds (cumulative count 4)
50.000% <= 0.975 milliseconds (cumulative count 50624)
75.000% <= 1.183 milliseconds (cumulative count 75104)
87.500% <= 1.319 milliseconds (cumulative count 88028)
93.750% <= 1.391 milliseconds (cumulative count 93767)
96.875% <= 1.447 milliseconds (cumulative count 96888)
98.438% <= 1.511 milliseconds (cumulative count 98570)
99.219% <= 1.567 milliseconds (cumulative count 99236)
99.609% <= 1.631 milliseconds (cumulative count 99615)
99.805% <= 1.695 milliseconds (cumulative count 99814)
99.902% <= 1.799 milliseconds (cumulative count 99903)
99.951% <= 2.927 milliseconds (cumulative count 99952)
99.976% <= 5.239 milliseconds (cumulative count 99976)
99.988% <= 8.623 milliseconds (cumulative count 99988)
99.994% <= 10.583 milliseconds (cumulative count 99994)
99.997% <= 11.423 milliseconds (cumulative count 99997)
99.998% <= 11.919 milliseconds (cumulative count 99999)
99.999% <= 12.183 milliseconds (cumulative count 100000)
100.000% <= 12.183 milliseconds (cumulative count 100000)

Cumulative distribution of latencies:
0.000% <= 0.103 milliseconds (cumulative count 0)
0.257% <= 0.703 milliseconds (cumulative count 257)
16.069% <= 0.807 milliseconds (cumulative count 16069)
36.878% <= 0.903 milliseconds (cumulative count 36878)
55.735% <= 1.007 milliseconds (cumulative count 55735)
66.489% <= 1.103 milliseconds (cumulative count 66489)
77.693% <= 1.207 milliseconds (cumulative count 77693)
86.587% <= 1.303 milliseconds (cumulative count 86587)
94.854% <= 1.407 milliseconds (cumulative count 94854)
98.421% <= 1.503 milliseconds (cumulative count 98421)
99.537% <= 1.607 milliseconds (cumulative count 99537)
99.820% <= 1.703 milliseconds (cumulative count 99820)
99.910% <= 1.807 milliseconds (cumulative count 99910)
99.929% <= 1.903 milliseconds (cumulative count 99929)
99.930% <= 2.103 milliseconds (cumulative count 99930)
99.961% <= 3.103 milliseconds (cumulative count 99961)
99.970% <= 4.103 milliseconds (cumulative count 99970)
99.975% <= 5.103 milliseconds (cumulative count 99975)
99.978% <= 6.103 milliseconds (cumulative count 99978)
99.982% <= 7.103 milliseconds (cumulative count 99982)
99.985% <= 8.103 milliseconds (cumulative count 99985)
99.989% <= 9.103 milliseconds (cumulative count 99989)
99.992% <= 10.103 milliseconds (cumulative count 99992)
99.995% <= 11.103 milliseconds (cumulative count 99995)
99.999% <= 12.103 milliseconds (cumulative count 99999)
100.000% <= 13.103 milliseconds (cumulative count 100000)

Summary:
  throughput summary: 48285.85 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
        1.026     0.640     0.975     1.415     1.543    12.183
====== GET ======
  100000 requests completed in 2.45 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1
  host configuration "save":
  host configuration "appendonly": no
  multi-thread: no

Latency by percentile distribution:
0.000% <= 0.607 milliseconds (cumulative count 3)
50.000% <= 1.183 milliseconds (cumulative count 50225)
75.000% <= 1.455 milliseconds (cumulative count 75230)
87.500% <= 1.631 milliseconds (cumulative count 87868)
93.750% <= 1.735 milliseconds (cumulative count 93812)
96.875% <= 1.847 milliseconds (cumulative count 97087)
98.438% <= 1.911 milliseconds (cumulative count 98446)
99.219% <= 1.967 milliseconds (cumulative count 99273)
99.609% <= 2.047 milliseconds (cumulative count 99640)
99.805% <= 2.191 milliseconds (cumulative count 99819)
99.902% <= 2.247 milliseconds (cumulative count 99903)
99.951% <= 2.479 milliseconds (cumulative count 99954)
99.976% <= 5.879 milliseconds (cumulative count 99976)
99.988% <= 9.663 milliseconds (cumulative count 99988)
99.994% <= 11.511 milliseconds (cumulative count 99994)
99.997% <= 12.479 milliseconds (cumulative count 99997)
99.998% <= 13.087 milliseconds (cumulative count 99999)
99.999% <= 13.383 milliseconds (cumulative count 100000)
100.000% <= 13.383 milliseconds (cumulative count 100000)

Cumulative distribution of latencies:
0.000% <= 0.103 milliseconds (cumulative count 0)
0.003% <= 0.607 milliseconds (cumulative count 3)
0.327% <= 0.703 milliseconds (cumulative count 327)
8.284% <= 0.807 milliseconds (cumulative count 8284)
20.020% <= 0.903 milliseconds (cumulative count 20020)
34.372% <= 1.007 milliseconds (cumulative count 34372)
44.082% <= 1.103 milliseconds (cumulative count 44082)
52.301% <= 1.207 milliseconds (cumulative count 52301)
60.772% <= 1.303 milliseconds (cumulative count 60772)
71.841% <= 1.407 milliseconds (cumulative count 71841)
77.589% <= 1.503 milliseconds (cumulative count 77589)
85.760% <= 1.607 milliseconds (cumulative count 85760)
92.218% <= 1.703 milliseconds (cumulative count 92218)
96.017% <= 1.807 milliseconds (cumulative count 96017)
98.299% <= 1.903 milliseconds (cumulative count 98299)
99.482% <= 2.007 milliseconds (cumulative count 99482)
99.710% <= 2.103 milliseconds (cumulative count 99710)
99.964% <= 3.103 milliseconds (cumulative count 99964)
99.969% <= 4.103 milliseconds (cumulative count 99969)
99.973% <= 5.103 milliseconds (cumulative count 99973)
99.976% <= 6.103 milliseconds (cumulative count 99976)
99.979% <= 7.103 milliseconds (cumulative count 99979)
99.982% <= 8.103 milliseconds (cumulative count 99982)
99.986% <= 9.103 milliseconds (cumulative count 99986)
99.989% <= 10.103 milliseconds (cumulative count 99989)
99.992% <= 11.103 milliseconds (cumulative count 99992)
99.995% <= 12.103 milliseconds (cumulative count 99995)
99.999% <= 13.103 milliseconds (cumulative count 99999)
100.000% <= 14.103 milliseconds (cumulative count 100000)

Summary:
  throughput summary: 40833.00 requests per second
  latency summary (msec):
          avg       min       p50       p95       p99       max
        1.217     0.600     1.183     1.775     1.943    13.383