# Define your functions prior to Action Blocks

  # create a min function, to manage our washout period check
  function min(a, b){
    return a < b ? a: b
  }  

# helper function to generate a header for the output
  function header(maxWin){
    head = "Input"
    for (i = 1; i <= maxWin; i++)
       head = head OFS "TF_"i
    return head
  }

# create an IncrementallyUpdatingAggregateFunction that calculates 
# the MA on All timeframes to maxWin

  function MovingAvg(offset, num, maxWin){

    # update the incrementing moving average on all timeframes to maxWin
    # do it by looping over all timeframes from 1 to maxWin, mindful of washout period

    # if this is the first row, set num at top of timeWindow stack for this offset

    sum_buffer[offset][1] = num

    # create a string to pass back all the data, coz in awk you can’t return arrays. 
    # Set first val to current timeseries value, as it is timeframe 1. 
    # Note, this runs on the very first value seen on a timeseries, and continues for all others

    all_ma_values = num
 
    # now iterate from timeframe 2 to maxWin updating running window values
    # because of washout, only run from at least the second value in our time series
    # as it means there is at least one existing value preceding it, ie lookback of 1 step

    if (offset > 1){   

       # now we iterate up from 2 to minimum of the current offset, or max window, 
       # so the array grows in a triangular way until we get past the washout period

       for (i = 2; i <= min(offset, maxWin); i++){ 

         # fetch that running sum, at this timeframe minus one, found at the previous offset 
         runningsum = sum_buffer[offset-1][i-1]

         # update our sum for this timeframe at this offset to calc the Moving Averages "MA"
         updatedsum = runningsum + num 

         # if we return a payload of all running MA values, build it up like this:
         all_ma_values = all_ma_values OFS updatedsum/i

         # we also store the running sum in an array for this offset@timeframe 
         sum_buffer[offset][i] = updatedsum

         # if wanted, we can store the moving averages in an array too:
         #ma_buffer[i] = updatedMA
       }
   } 
   # now we manage memory by deleting old data at offsets we don’t need after this
   delete sum_buffer[offset-1]
   
   # return the updated moving average to the caller:
   # (in the washout period this will be an empty value). Note here I only output the max MA
   # but we could have returned all_ma_values (the concated strings) 
   # or we could have returned an array of all moving averages (but that’s unsupported by awk)

   return all_ma_values
   #return sum_buffer[offset][maxWin]/maxWin

   } # end of function definition

## First Action Block ##
## on launch, check we have the user defined parameters passed in, or default them ##

BEGIN{
  # start by checking we received a maxWin option on command line, or set one here
  if (! maxWin){
     maxWin=20
  }

  # also check if the user wants to select a particular column, else set to first position $1
  if (! col){ 
     col=1
  }

  # output the header using our helper function
  print header(maxWin)
}

## Main Action Block ##
## start of the main gawk program processing rows meeting conditions ##
 
# note the condition to only produce outputs After the washout period. 
# This can be relaxed to printing all output, if you’d like to see the triangular outputs being produced to see more clearly how the aggregates accumulate over time.

# no condition set - this will process every single input record:
{
   # map your input column containing numbers to our value feeding the moving averages
   value = $(col)

   # call the function to create the moving averages
   ma = MovingAvg(NR, value, maxWin)
}

# condition set to only print values when the offset of this row NumberRows (NR) > maxWin
NR > maxWin {

   print(value, ma)

}

