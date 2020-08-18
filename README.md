# sma.awk

IncrementallyUpdatingAggregateFunctions, on all timeframes, in awk 

This is a small POC illustrating a very efficient approach to generating sliding window based aggregates on Every timeframe from 1 to N, implemented in awk.
Clone the library, make sure you have gawk or awk installed on your command line
Examples of running the script below:

# generate a moving average for all to timeframes from 1 to 10

```
gawk -F, -f sma.awk -v col=3 -v maxWin=10  test_DJI.csv | head
40.32 40.32 40.13 40.01 40.0175 40.134 40.2167 40.2757 40.2662 40.3011 40.365
40.34 40.34 40.33 40.2 40.0925 40.082 40.1683 40.2343 40.2837 40.2744 40.305
39.81 39.81 40.075 40.1567 40.1025 40.036 40.0367 40.1171 40.1812 40.2311 40.228
39.34 39.34 39.575 39.83 39.9525 39.95 39.92 39.9371 40.02 40.0878 40.142
38.41 38.41 38.875 39.1867 39.475 39.644 39.6933 39.7043 39.7463 39.8411 39.92
39.4 39.4 38.905 39.05 39.24 39.46 39.6033 39.6514 39.6662 39.7078 39.797
39.31 39.31 39.355 39.04 39.115 39.254 39.435 39.5614 39.6088 39.6267 39.668
39.55 39.55 39.43 39.42 39.1675 39.202 39.3033 39.4514 39.56 39.6022 39.619
39.93 39.93 39.74 39.5967 39.5475 39.32 39.3233 39.3929 39.5113 39.6011 39.635
40.45 40.45 40.19 39.9767 39.81 39.728 39.5083 39.4843 39.525 39.6156 39.686
```







