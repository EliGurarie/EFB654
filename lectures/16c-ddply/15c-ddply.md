---
title: "Summarizing with `ddply()`"
author: "Hyatt Green"
date: "March 18, 2026"
output: 
  ioslides_presentation:
    fig_width: 7
    fig_height: 6
    fig_caption: true
    widescreen: true
    keep_md: true
---



## Today

 - Review `aggregate()`
 - `plyr::summarize()`
 - **`ddply()`**
 - The `d_ply()` family

## Remember `aggregate()`?


``` r
data(warpbreaks)
aggregate(breaks~wool, warpbreaks, FUN=mean)
```

```
##   wool   breaks
## 1    A 31.03704
## 2    B 25.25926
```

## Remember `aggregate()`?


``` r
aggregate(breaks~wool+tension, warpbreaks, FUN=mean)
```

```
##   wool tension   breaks
## 1    A       L 44.55556
## 2    B       L 28.22222
## 3    A       M 24.00000
## 4    B       M 28.77778
## 5    A       H 24.55556
## 6    B       H 18.77778
```

## `aggregate()` limitation

Only one aggregation function allowed.


``` r
# Does not work
aggregate(breaks~wool+tension, warpbreaks, FUN=c(mean, sd))
```

```
## Error in `get()`:
## ! object 'FUN' of mode 'function' was not found
```

 - What if we want the mean **and** the sd **and** the median in one call?

## `plyr::summarize()`

 - Creates new dataframe


``` r
library(plyr)
summarize(warpbreaks, mean(breaks), sd(breaks))
```

```
##   mean(breaks) sd(breaks)
## 1     28.14815   13.19864
```

## `plyr::summarize()`

 - Usually add custom names


``` r
summarize(warpbreaks, 
  Avg = mean(breaks), 
  StdDev = sd(breaks))
```

```
##        Avg   StdDev
## 1 28.14815 13.19864
```

## `plyr::summarize()`

 - Applied functions can be complex


``` r
summarize(warpbreaks, 
  Avg = mean(breaks), 
  Med = median(breaks), 
  Dif = abs(Avg - Med)) #Can use objects created within function
```

```
##        Avg Med      Dif
## 1 28.14815  26 2.148148
```

 - What capability are we missing here with `summarize()`?

## `ddply()`

 - Also in the `plyr` package
 - "Split data frame, apply function, and return results in a data frame." --- ?ddply
 - Hadley Wickham (2011). "The Split-Apply-Combine Strategy for Data Analysis", *Journal of Statistical Software, 40(1), 1-29*
 - **d**ataframe *in*, **d**ataframe *out*, ap**ply**

## `ddply()` arguments

`ddply()` arguments:
 
 - **`.data`** = data frame to be processed
 - **`.variables`** = variables to split data frame by
    + a character vector
    + as `as.quoted()` variables
    + a formula
 - **`.fun`** = function to apply to each piece
 - **`...`** = arguments passed to **`.fun`** (e.g., `na.rm`)
    + in our case `.fun` is `summarize()`

## `ddply()` in action

 - Often used with `summarize()` to apply more than one function


``` r
ddply(warpbreaks, "wool", summarize,
   Avg = mean(breaks),
   Med = median(breaks),
   Dif = abs(Avg - Med))
```

```
##   wool      Avg Med      Dif
## 1    A 31.03704  26 5.037037
## 2    B 25.25926  24 1.259259
```

## `ddply()`: `.()` notation


``` r
 ddply(warpbreaks, .(wool, tension), summarize,
   Avg = mean(breaks),
   Med = median(breaks),
   Dif = abs(Avg - Med))
```

```
##   wool tension      Avg Med       Dif
## 1    A       L 44.55556  51 6.4444444
## 2    A       M 24.00000  21 3.0000000
## 3    A       H 24.55556  24 0.5555556
## 4    B       L 28.22222  29 0.7777778
## 5    B       M 28.77778  28 0.7777778
## 6    B       H 18.77778  17 1.7777778
```

 - **`.`** is a function that simply quotes the names of each variable (see `?.`)
      + does not evaluate the variable
      + simply allows you to drop quotes

## `ddply()`: formula interface


``` r
 ddply(warpbreaks, ~wool+tension, summarize,
   Avg = mean(breaks),
   Med = median(breaks),
   Dif = abs(Avg - Med))
```

```
##   wool tension      Avg Med       Dif
## 1    A       L 44.55556  51 6.4444444
## 2    A       M 24.00000  21 3.0000000
## 3    A       H 24.55556  24 0.5555556
## 4    B       L 28.22222  29 0.7777778
## 5    B       M 28.77778  28 0.7777778
## 6    B       H 18.77778  17 1.7777778
```


## Three ways to specify variables

| Method | Syntax | Notes |
|---|---|---|
| Character vector | `"wool"` | Quoted, single variable |
| `.()` notation | `.(wool, tension)` | Unquoted, multiple variables |
| Formula | `~wool+tension` | Familiar from `aggregate()` |

All three produce the same result. Use whichever you find most readable.


## The `d_ply()` family

What if we want to output a list? Use `dlply()`...


``` r
dlply(warpbreaks, .(wool, tension), summarize,
   Avg = mean(breaks),
   Med = median(breaks),
   Dif = abs(Avg - Med))
```

```
## $A.L
##        Avg Med      Dif
## 1 44.55556  51 6.444444
## 
## $A.M
##   Avg Med Dif
## 1  24  21   3
## 
## $A.H
##        Avg Med       Dif
## 1 24.55556  24 0.5555556
## 
## $B.L
##        Avg Med       Dif
## 1 28.22222  29 0.7777778
## 
## $B.M
##        Avg Med       Dif
## 1 28.77778  28 0.7777778
## 
## $B.H
##        Avg Med      Dif
## 1 18.77778  17 1.777778
## 
## attr(,"split_type")
## [1] "data.frame"
## attr(,"split_labels")
##   wool tension
## 1    A       L
## 2    A       M
## 3    A       H
## 4    B       L
## 5    B       M
## 6    B       H
```

## The `d_ply()` family

What if we want to output an array? Use `daply()`...


``` r
daply(warpbreaks, .(wool, tension), summarize,
   Avg = mean(breaks),
   Med = median(breaks),
   Dif = abs(Avg - Med))
```

```
## , ,  = Avg
## 
##     tension
## wool L        M        H       
##    A 44.55556 24       24.55556
##    B 28.22222 28.77778 18.77778
## 
## , ,  = Med
## 
##     tension
## wool L  M  H 
##    A 51 21 24
##    B 29 28 17
## 
## , ,  = Dif
## 
##     tension
## wool L         M         H        
##    A 6.444444  3         0.5555556
##    B 0.7777778 0.7777778 1.777778
```

## The `d_ply()` family

By far, `ddply()` is most common because dataframes are easiest to work with.

Other functions that *produce* dataframes:

 - `ldply()`
 - `adply()`
 - `mdply()`


## Practice with `ddply()`

Import the `birthwt` data set from the **MASS** package. For *all combinations of race and smoking status*, find the:

 - number of observations within each group
 - mean and std. dev. of:
    + mother's weight at last menstrual period
    + birth weight
 - median number of physician visits during the first trimester

----


``` r
library(MASS)
data(birthwt)
str(birthwt)
```

```
## 'data.frame':	189 obs. of  10 variables:
##  $ low  : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ age  : int  19 33 20 21 18 21 22 17 29 26 ...
##  $ lwt  : int  182 155 105 108 107 124 118 103 123 113 ...
##  $ race : int  2 3 1 1 1 3 1 3 1 1 ...
##  $ smoke: int  0 0 1 1 1 0 0 0 1 1 ...
##  $ ptl  : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ ht   : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ ui   : int  1 0 0 1 1 0 0 0 0 0 ...
##  $ ftv  : int  0 3 1 2 0 0 1 1 1 0 ...
##  $ bwt  : int  2523 2551 2557 2594 2600 2622 2637 2637 2663 2665 ...
```

----


``` r
head(birthwt)
```

```
##    low age lwt race smoke ptl ht ui ftv  bwt
## 85   0  19 182    2     0   0  0  1   0 2523
## 86   0  33 155    3     0   0  0  0   3 2551
## 87   0  20 105    1     1   0  0  0   1 2557
## 88   0  21 108    1     1   0  0  1   2 2594
## 89   0  18 107    1     1   0  0  1   0 2600
## 91   0  21 124    3     0   0  0  0   0 2622
```

----


``` r
ddply(birthwt, .(race, smoke), summarize, 
  N = length(bwt),
  MW.mean = mean(lwt),
  MW.sd = sd(lwt),
  BWT.mean = mean(bwt),
  BWT.sd = sd(bwt),
  FTV.med = median(ftv) )
```

```
##   race smoke  N  MW.mean    MW.sd BWT.mean   BWT.sd FTV.med
## 1    1     0 44 138.8409 25.70037 3428.750 710.0989     1.0
## 2    1     1 52 126.3077 30.76383 2826.846 626.4725     0.0
## 3    2     0 16 149.4375 43.40809 2854.500 621.2543     0.5
## 4    2     1 10 142.6000 34.52921 2504.000 637.0568     0.0
## 5    3     0 55 119.1455 19.04422 2815.782 709.3493     0.0
## 6    3     1 12 124.0000 44.58292 2757.167 810.0446     0.0
```

----

Wrap in `round()` for cleaner output:


``` r
round(ddply(birthwt, .(race, smoke), summarize,
  N = length(bwt),
  MW.mean = mean(lwt),
  MW.sd = sd(lwt),
  BWT.mean = mean(bwt),
  BWT.sd = sd(bwt),
  FTV.med = median(ftv) ) )
```

```
##   race smoke  N MW.mean MW.sd BWT.mean BWT.sd FTV.med
## 1    1     0 44     139    26     3429    710       1
## 2    1     1 52     126    31     2827    626       0
## 3    2     0 16     149    43     2854    621       0
## 4    2     1 10     143    35     2504    637       0
## 5    3     0 55     119    19     2816    709       0
## 6    3     1 12     124    45     2757    810       0
```


## `aggregate()` vs `ddply()`

| Feature | `aggregate()` | `ddply()` |
|---|---|---|
| Package | base R | `plyr` |
| Functions per call | **One** | **Many** |
| Variable specification | Formula (`y ~ x`) | Character, `.()`, or formula |
| Output | Data frame | Data frame (also list, array via `dlply`, `daply`) |
| Custom column names | No (uses function name) | Yes (name each summary) |
| Cross-referencing summaries | No | Yes (`Dif = abs(Avg - Med)`) |

 > - Use `aggregate()` for quick one-function summaries
 > - Use `ddply()` when you need multiple summaries in one table

## Summary

 > - `plyr::summarize()` applies multiple functions but has no grouping
 > - `ddply()` = `summarize()` + grouping = the full toolkit
 > - **d**ataframe in, **d**ataframe out, ap**ply**
 > - Three equivalent ways to specify grouping variables
 > - The `d_ply()` family: `ddply`, `dlply`, `daply` for different output types
