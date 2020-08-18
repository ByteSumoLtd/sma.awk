# sma.awk

IncrementallyUpdatingAggregateFunctions, on all timeframes, in awk 

This is a small POC illustrating a very efficient approach to generating sliding window based aggregates on Every timeframe from 1 to N, implemented in awk.

Clone the library, make sure you have gawk or awk installed on your command line

# Examples

### SMA for all timeframes to 10

```
# generate a moving average for all to timeframes from 1 to 10
gawk -F, -f sma.awk -v col=3 -v maxWin=10  test_DJI.csv | column -t | head
Input    TF_1     TF_2     TF_3     TF_4     TF_5     TF_6     TF_7     TF_8     TF_9     TF_10
40.32    40.32    40.13    40.01    40.0175  40.134   40.2167  40.2757  40.2662  40.3011  40.365
40.34    40.34    40.33    40.2     40.0925  40.082   40.1683  40.2343  40.2837  40.2744  40.305
39.81    39.81    40.075   40.1567  40.1025  40.036   40.0367  40.1171  40.1812  40.2311  40.228
39.34    39.34    39.575   39.83    39.9525  39.95    39.92    39.9371  40.02    40.0878  40.142
38.41    38.41    38.875   39.1867  39.475   39.644   39.6933  39.7043  39.7463  39.8411  39.92
39.4     39.4     38.905   39.05    39.24    39.46    39.6033  39.6514  39.6662  39.7078  39.797
39.31    39.31    39.355   39.04    39.115   39.254   39.435   39.5614  39.6088  39.6267  39.668
39.55    39.55    39.43    39.42    39.1675  39.202   39.3033  39.4514  39.56    39.6022  39.619
39.93    39.93    39.74    39.5967  39.5475  39.32    39.3233  39.3929  39.5113  39.6011  39.635

```

### SMA for all timeframes to 30


```
gawk -F, -f sma.awk -v col=3 -v maxWin=30  test_DJI.csv | column -t | head
Input    TF_1     TF_2     TF_3     TF_4     TF_5     TF_6     TF_7     TF_8     TF_9     TF_10    TF_11    TF_12    TF_13    TF_14    TF_15    TF_16    TF_17    TF_18    TF_19    TF_20    TF_21    TF_22    TF_23    TF_24    TF_25    TF_26    TF_27    TF_28    TF_29    TF_30
35.53    35.53    36.285   36.82    37.1075  37.34    37.4733  37.6529  37.9325  38.1656  38.325   38.5264  38.6867  38.7823  38.8371  38.8687  38.9019  38.8729  38.8989  38.9468  39.0165  39.0786  39.1177  39.1461  39.1833  39.24    39.2935  39.343   39.3736  39.4152  39.466
36.15    36.15    35.84    36.24    36.6525  36.916   37.1417  37.2843  37.465   37.7344  37.964   38.1273  38.3283  38.4915  38.5943  38.658   38.6987  38.74    38.7217  38.7542  38.807   38.88    38.9455  38.9887  39.0212  39.062   39.1212  39.177   39.2289  39.2624  39.3063
34.59    34.59    35.37    35.4233  35.8275  36.24    36.5283  36.7771  36.9475  37.1456  37.42    37.6573  37.8325  38.0408  38.2129  38.3273  38.4038  38.4571  38.5094  38.5042  38.546   38.6062  38.685   38.7561  38.8054  38.844   38.89    38.9533  39.0132  39.069   39.1067
34.91    34.91    34.75    35.2167  35.295   35.644   36.0183  36.2971  36.5438  36.7211  36.922   37.1918  37.4283  37.6077  37.8171  37.9927  38.1137  38.1982  38.26    38.32    38.3245  38.3729  38.4382  38.5209  38.5958  38.6496  38.6927  38.7426  38.8089  38.8717  38.9303
34.74    34.74    34.825   34.7467  35.0975  35.184   35.4933  35.8357  36.1025  36.3433  36.523   36.7236  36.9875  37.2215  37.4029  37.612   37.7894  37.9153  38.0061  38.0747  38.141   38.1538  38.2077  38.2774  38.3633  38.4416  38.4992  38.5463  38.5996  38.6686  38.734
34.74    34.74    34.74    34.7967  34.745   35.026   35.11    35.3857  35.6988  35.9511  36.183   36.3609  36.5583  36.8146  37.0443  37.2253  37.4325  37.61    37.7389  37.8342  37.908   37.979   37.9986  38.057   38.13    38.2184  38.2992  38.36    38.4104  38.4666  38.5377
34.87    34.87    34.805   34.7833  34.815   34.77    35       35.0757  35.3212  35.6067  35.843   36.0636  36.2367  36.4285  36.6757  36.8993  37.0781  37.2818  37.4578  37.5879  37.686   37.7633  37.8377  37.8626  37.9242  37.9996  38.0896  38.1722  38.2354  38.2883  38.3467
35.15    35.15    35.01    34.92    34.875   34.882   34.8333  35.0214  35.085   35.3022  35.561   35.78    35.9875  36.1531  36.3371  36.574   36.79    36.9647  37.1633  37.3363  37.466   37.5652  37.6445  37.7209  37.7496  37.8132  37.89    37.9807  38.0643  38.129   38.1837
35.19    35.19    35.17    35.07    34.9875  34.938   34.9333  34.8843  35.0425  35.0967  35.291   35.5273  35.7308  35.9262  36.0843  36.2607  36.4875  36.6959  36.8661  37.0595  37.229   37.3576  37.4573  37.5378  37.6154  37.6472  37.7123  37.79    37.8811  37.9652  38.031

```

note: 
You can alter the column used to create the moving average, by setting col on the command line.
Also, there is lots of commentary in the code, to explain how it works.

I produced this POC to illustrate how working on all timeframes at once is better than picking a timeframe.

This example can be extended to support any aggregate function, as long as
your aggregate function can support Add-One new value semantics.

