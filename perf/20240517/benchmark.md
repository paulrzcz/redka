# Original Redis

====== SET ======
  100000 requests completed in 1.93 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1
  host configuration "save": 
  host configuration "appendonly": no
  multi-thread: no

0.00% <= 0.1 milliseconds
0.01% <= 0.2 milliseconds
0.07% <= 0.3 milliseconds
0.56% <= 0.4 milliseconds
73.82% <= 0.5 milliseconds
92.29% <= 0.6 milliseconds
96.25% <= 0.7 milliseconds
97.89% <= 0.8 milliseconds
98.57% <= 0.9 milliseconds
98.86% <= 1.0 milliseconds
99.04% <= 1.1 milliseconds
99.21% <= 1.2 milliseconds
99.34% <= 1.3 milliseconds
99.44% <= 1.4 milliseconds
99.55% <= 1.5 milliseconds
99.64% <= 1.6 milliseconds
99.70% <= 1.7 milliseconds
99.75% <= 1.8 milliseconds
99.78% <= 1.9 milliseconds
99.81% <= 2 milliseconds
99.90% <= 3 milliseconds
99.90% <= 6 milliseconds
99.95% <= 7 milliseconds
99.98% <= 10 milliseconds
100.00% <= 10 milliseconds
51786.64 requests per second

====== GET ======
  100000 requests completed in 1.95 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1
  host configuration "save": 
  host configuration "appendonly": no
  multi-thread: no

99.11% <= 1 milliseconds
99.88% <= 2 milliseconds
99.95% <= 6 milliseconds
99.99% <= 7 milliseconds
100.00% <= 7 milliseconds
51282.05 requests per second

# Redka

====== SET ======
  100000 requests completed in 4.42 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1
  host configuration "save": 
  host configuration "appendonly": no
  multi-thread: no

0.00% <= 0.1 milliseconds
0.00% <= 0.2 milliseconds
0.01% <= 0.3 milliseconds
0.04% <= 0.4 milliseconds
0.06% <= 0.5 milliseconds
0.11% <= 0.6 milliseconds
0.16% <= 0.7 milliseconds
0.25% <= 0.8 milliseconds
0.32% <= 0.9 milliseconds
0.43% <= 1.0 milliseconds
0.52% <= 1.1 milliseconds
0.73% <= 1.2 milliseconds
1.83% <= 1.3 milliseconds
4.61% <= 1.4 milliseconds
10.13% <= 1.5 milliseconds
17.84% <= 1.6 milliseconds
26.88% <= 1.7 milliseconds
36.31% <= 1.8 milliseconds
45.15% <= 1.9 milliseconds
52.65% <= 2 milliseconds
91.79% <= 3 milliseconds
97.60% <= 4 milliseconds
99.02% <= 5 milliseconds
99.29% <= 6 milliseconds
99.41% <= 7 milliseconds
99.53% <= 8 milliseconds
99.61% <= 9 milliseconds
99.67% <= 10 milliseconds
99.68% <= 11 milliseconds
99.70% <= 12 milliseconds
99.72% <= 13 milliseconds
99.73% <= 14 milliseconds
99.75% <= 15 milliseconds
99.81% <= 16 milliseconds
99.84% <= 17 milliseconds
99.85% <= 19 milliseconds
99.91% <= 20 milliseconds
99.92% <= 21 milliseconds
99.94% <= 25 milliseconds
99.94% <= 27 milliseconds
99.95% <= 28 milliseconds
99.98% <= 30 milliseconds
99.99% <= 31 milliseconds
99.99% <= 33 milliseconds
99.99% <= 34 milliseconds
100.00% <= 35 milliseconds
100.00% <= 36 milliseconds
22629.55 requests per second

====== GET ======
  100000 requests completed in 4.90 seconds
  50 parallel clients
  3 bytes payload
  keep alive: 1
  host configuration "save": 
  host configuration "appendonly": no
  multi-thread: no

0.14% <= 1 milliseconds
40.47% <= 2 milliseconds
84.33% <= 3 milliseconds
95.40% <= 4 milliseconds
98.22% <= 5 milliseconds
98.94% <= 6 milliseconds
99.21% <= 7 milliseconds
99.39% <= 8 milliseconds
99.54% <= 9 milliseconds
99.62% <= 10 milliseconds
99.62% <= 11 milliseconds
99.64% <= 12 milliseconds
99.75% <= 13 milliseconds
99.80% <= 14 milliseconds
99.83% <= 15 milliseconds
99.83% <= 16 milliseconds
99.83% <= 17 milliseconds
99.83% <= 18 milliseconds
99.84% <= 19 milliseconds
99.85% <= 20 milliseconds
99.89% <= 21 milliseconds
99.89% <= 22 milliseconds
99.89% <= 23 milliseconds
99.94% <= 24 milliseconds
99.94% <= 25 milliseconds
99.95% <= 26 milliseconds
99.95% <= 27 milliseconds
99.95% <= 28 milliseconds
99.95% <= 29 milliseconds
99.95% <= 30 milliseconds
99.95% <= 32 milliseconds
99.96% <= 33 milliseconds
99.97% <= 34 milliseconds
99.99% <= 38 milliseconds
99.99% <= 39 milliseconds
100.00% <= 40 milliseconds
100.00% <= 40 milliseconds
20424.84 requests per second
