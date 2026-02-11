---
title: Plotting with the `graphics` package, `par()`, and `R` colors
date: Feb 11, 2026
output: 
  beamer_presentation:
    fig_width: 7
    fig_height: 6
    fig_caption: true
    keep_md: true
---





Plots in R
----

 1. R's built-in statistical graphics in the `graphics` package (already attached, use `sessionInfo()`)
 2. Plotting parameters in `par()`
 3. `R`'s basic colors
 4. `RColorBrewer` package

Built-in Statistical Graphics
----

  Plot Type               R function        Objective
  ---------               ----------        -----------------
  Histogram               `hist()`          Statistical distributions
  Boxplot                 `boxplot()`       Statistical distributions
  Barplot                 `barplot()`       Categorical data
  Scatterplot             `plot()`          Numerical data
  Regression diagnostics  `plot()`          Assessing model fit

 : Common plot types, functions, and objectives

Histogram
----
 
 - `rnorm()` 
 - `hist()`
 - `density()`
 - `lines()`

Histogram
----
<!--Nothing makes better histogram data than numbers sampled from a normal distribution -->

``` r
?rnorm
```

``` r
norm.dat<-rnorm(10000, 50, sd=10)
head(norm.dat)
```

```
## [1] 40.92291 55.96915 64.01477 55.91938 54.25731 32.34942
```

Usually takes a vector of numeric...

Histogram
----

...but can also be a numeric matrix

``` r
data(volcano)
hist(volcano)
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-5-1} \end{center}

Histogram
----


``` r
hist(norm.dat)
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-6-1} \end{center}

Histogram (behind the scenes)
----

<PRE>
hist(x, breaks = "Sturges",
     freq = NULL, probability = !freq,
     include.lowest = TRUE, right = TRUE,
     density = NULL, angle = 45, col = NULL, 
     border = NULL,
     main = paste("Histogram of" , xname),
     xlim = range(breaks), ylim = NULL,
     xlab = xname, ylab,
     axes = TRUE, plot = TRUE, labels = FALSE,
     nclass = NULL, warn.unused = TRUE, ...)
</PRE>

 - **`x`** = numeric data (vector)
 - **`breaks`** = how to perform binning, i.e., the # of bins
    + specified in multiple ways, see `?hist`

`breaks` are customizable
----


\begin{center}\includegraphics[width=250px]{unnamed-chunk-22-1} \end{center}

Histogram (behind the scenes)
----

<PRE>
hist(x, breaks = "Sturges",
     freq = NULL, probability = !freq,
     include.lowest = TRUE, right = TRUE,
     density = NULL, angle = 45, col = NULL, 
     border = NULL,
     main = paste("Histogram of" , xname),
     xlim = range(breaks), ylim = NULL,
     xlab = xname, ylab,
     axes = TRUE, plot = TRUE, labels = FALSE,
     nclass = NULL, warn.unused = TRUE, ...)
</PRE>

 - **`freq`** = show frequencies (`T`) or probabilities (`F`)
 - **`xlim`** = x min and max (numeric vector of 2)
 - **`ylim`** = y min and max (numeric vector of 2)
 
Histogram
----


``` r
hist(norm.dat, breaks=100, xlim=c(50,90))
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-8-1} \end{center}

Histogram
----


``` r
hist(norm.dat, breaks=100, 
     xlim=c(50,90), freq = F) # Must change to freq = F
lines(density(norm.dat)) # see ?density and ?lines
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-9-1} \end{center}

Boxplot
----

 - `boxplot()`
 - `par()`

Boxplot
----
 

``` r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 4.5.2
```

``` r
data(msleep) # ?msleep
str(msleep)
```

```
## tibble [83 x 11] (S3: tbl_df/tbl/data.frame)
##  $ name        : chr [1:83] "Cheetah" "Owl monkey" "Mountain beaver" "Greater short-tailed shrew" ...
##  $ genus       : chr [1:83] "Acinonyx" "Aotus" "Aplodontia" "Blarina" ...
##  $ vore        : chr [1:83] "carni" "omni" "herbi" "omni" ...
##  $ order       : chr [1:83] "Carnivora" "Primates" "Rodentia" "Soricomorpha" ...
##  $ conservation: chr [1:83] "lc" NA "nt" "lc" ...
##  $ sleep_total : num [1:83] 12.1 17 14.4 14.9 4 14.4 8.7 7 10.1 3 ...
##  $ sleep_rem   : num [1:83] NA 1.8 2.4 2.3 0.7 2.2 1.4 NA 2.9 NA ...
##  $ sleep_cycle : num [1:83] NA NA NA 0.133 0.667 ...
##  $ awake       : num [1:83] 11.9 7 9.6 9.1 20 9.6 15.3 17 13.9 21 ...
##  $ brainwt     : num [1:83] NA 0.0155 NA 0.00029 0.423 NA NA NA 0.07 0.0982 ...
##  $ bodywt      : num [1:83] 50 0.48 1.35 0.019 600 ...
```

Change `vore` to factor
----


``` r
msleep$vore<-factor(msleep$vore)
str(msleep)
```

```
## tibble [83 x 11] (S3: tbl_df/tbl/data.frame)
##  $ name        : chr [1:83] "Cheetah" "Owl monkey" "Mountain beaver" "Greater short-tailed shrew" ...
##  $ genus       : chr [1:83] "Acinonyx" "Aotus" "Aplodontia" "Blarina" ...
##  $ vore        : Factor w/ 4 levels "carni","herbi",..: 1 4 2 4 2 2 1 NA 1 2 ...
##  $ order       : chr [1:83] "Carnivora" "Primates" "Rodentia" "Soricomorpha" ...
##  $ conservation: chr [1:83] "lc" NA "nt" "lc" ...
##  $ sleep_total : num [1:83] 12.1 17 14.4 14.9 4 14.4 8.7 7 10.1 3 ...
##  $ sleep_rem   : num [1:83] NA 1.8 2.4 2.3 0.7 2.2 1.4 NA 2.9 NA ...
##  $ sleep_cycle : num [1:83] NA NA NA 0.133 0.667 ...
##  $ awake       : num [1:83] 11.9 7 9.6 9.1 20 9.6 15.3 17 13.9 21 ...
##  $ brainwt     : num [1:83] NA 0.0155 NA 0.00029 0.423 NA NA NA 0.07 0.0982 ...
##  $ bodywt      : num [1:83] 50 0.48 1.35 0.019 600 ...
```

Boxplot
----

Is there a relationship between ($y$) the total amount of sleep mammals get and ($x$) what they eat?

``` r
boxplot(sleep_total~vore, msleep)
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-12-1} \end{center}

 - `~` = "as a function of" or "as modeled by"
    + `y-axis-data ~ x-axis-data`
 
Boxplot
----

Both `hist()` and `boxplot()` return information in addition to the plot.

 - Decorate the plot more or provide statistics (median, etc)


``` r
bp.data<-boxplot(sleep_total~vore, msleep, plot=F)
str(bp.data)
```

```
## List of 6
##  $ stats: num [1:5, 1:4] 2.7 6.25 10.4 13 19.4 ...
##  $ n    : num [1:4] 19 32 5 20
##  $ conf : num [1:2, 1:4] 7.95 12.85 7.49 13.11 10.26 ...
##  $ out  : num [1:4] 17 14.9 18 15.6
##  $ group: num [1:4] 4 4 4 4
##  $ names: chr [1:4] "carni" "herbi" "insecti" "omni"
```

# `par()`

`par()`
----

 - Access to all graphical **par**ameters
 - The function `par()` returns a special **named list** of values
 

``` r
par()
```

```
## $xlog
## [1] FALSE
## 
## $ylog
## [1] FALSE
## 
## $adj
## [1] 0.5
## 
## $ann
## [1] TRUE
## 
## $ask
## [1] FALSE
## 
## $bg
## [1] "transparent"
## 
## $bty
## [1] "o"
## 
## $cex
## [1] 1
## 
## $cex.axis
## [1] 1
## 
## $cex.lab
## [1] 1
## 
## $cex.main
## [1] 1.2
## 
## $cex.sub
## [1] 1
## 
## $cin
## [1] 0.15 0.20
## 
## $col
## [1] "black"
## 
## $col.axis
## [1] "black"
## 
## $col.lab
## [1] "black"
## 
## $col.main
## [1] "black"
## 
## $col.sub
## [1] "black"
## 
## $cra
## [1] 10.8 14.4
## 
## $crt
## [1] 0
## 
## $csi
## [1] 0.2
## 
## $cxy
## [1] 0.04601227 0.17241379
## 
## $din
## [1] 4.5 3.0
## 
## $err
## [1] 0
## 
## $family
## [1] ""
## 
## $fg
## [1] "black"
## 
## $fig
## [1] 0 1 0 1
## 
## $fin
## [1] 4.5 3.0
## 
## $font
## [1] 1
## 
## $font.axis
## [1] 1
## 
## $font.lab
## [1] 1
## 
## $font.main
## [1] 2
## 
## $font.sub
## [1] 1
## 
## $lab
## [1] 5 5 7
## 
## $las
## [1] 0
## 
## $lend
## [1] "round"
## 
## $lheight
## [1] 1
## 
## $ljoin
## [1] "round"
## 
## $lmitre
## [1] 10
## 
## $lty
## [1] "solid"
## 
## $lwd
## [1] 1
## 
## $mai
## [1] 1.02 0.82 0.82 0.42
## 
## $mar
## [1] 5.1 4.1 4.1 2.1
## 
## $mex
## [1] 1
## 
## $mfcol
## [1] 1 1
## 
## $mfg
## [1] 1 1 1 1
## 
## $mfrow
## [1] 1 1
## 
## $mgp
## [1] 3 1 0
## 
## $mkh
## [1] 0.001
## 
## $new
## [1] FALSE
## 
## $oma
## [1] 0 0 0 0
## 
## $omd
## [1] 0 1 0 1
## 
## $omi
## [1] 0 0 0 0
## 
## $page
## [1] TRUE
## 
## $pch
## [1] 1
## 
## $pin
## [1] 3.26 1.16
## 
## $plt
## [1] 0.1822222 0.9066667 0.3400000 0.7266667
## 
## $ps
## [1] 12
## 
## $pty
## [1] "m"
## 
## $smo
## [1] 1
## 
## $srt
## [1] 0
## 
## $tck
## [1] NA
## 
## $tcl
## [1] -0.5
## 
## $usr
## [1] 0 1 0 1
## 
## $xaxp
## [1] 0 1 5
## 
## $xaxs
## [1] "r"
## 
## $xaxt
## [1] "s"
## 
## $xpd
## [1] FALSE
## 
## $yaxp
## [1] 0 1 5
## 
## $yaxs
## [1] "r"
## 
## $yaxt
## [1] "s"
## 
## $ylbias
## [1] 0.2
```

`par()`
----

 - Like a list, you can index it.


``` r
par()[1:2]
```

```
## $xlog
## [1] FALSE
## 
## $ylog
## [1] FALSE
```

`par()`
----


``` r
par("fg")
```

```
## [1] "black"
```

``` r
par(fg="blue", lwd=3)
boxplot(sleep_total~vore, msleep)
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-16-1} \end{center}

`par()`
----


``` r
par("cex")
```

```
## [1] 1
```

``` r
par(cex=0.7)
boxplot(sleep_total~vore, msleep)
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-17-1} \end{center}

`par()`
----

 - `par()` contains 72 parameters
 

``` r
length(par())
```

```
## [1] 72
```

``` r
head(names(par()), 50)
```

```
##  [1] "xlog"      "ylog"      "adj"       "ann"       "ask"       "bg"       
##  [7] "bty"       "cex"       "cex.axis"  "cex.lab"   "cex.main"  "cex.sub"  
## [13] "cin"       "col"       "col.axis"  "col.lab"   "col.main"  "col.sub"  
## [19] "cra"       "crt"       "csi"       "cxy"       "din"       "err"      
## [25] "family"    "fg"        "fig"       "fin"       "font"      "font.axis"
## [31] "font.lab"  "font.main" "font.sub"  "lab"       "las"       "lend"     
## [37] "lheight"   "ljoin"     "lmitre"    "lty"       "lwd"       "mai"      
## [43] "mar"       "mex"       "mfcol"     "mfg"       "mfrow"     "mgp"      
## [49] "mkh"       "new"
```

`par()` tips
----

 - If changed in `par()`, will be changed **globally** until reset manually or R session terminated
 - Can be specified within plot function to change temporarily (e.g., `plot(y~x, data, col="red")`)
 - **OR**, *always use `knitr` and RMarkdown.* `par()` resets every code chunk, *unless* you tell it not to.

Scatterplots
----

 - `plot()`
 - `legend()`

Scatterplots
----

 - Simply use the generic command `plot()`
 

``` r
plot(sleep_total~bodywt, msleep)
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-19-1} \end{center}

Scatterplots
----

 - `plot()` knows to make a scatterplot with "numeric ~ numeric" input
 

``` r
plot(sleep_total~vore, msleep) 
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-20-1} \end{center}

``` r
# Decides it's a job for boxplot
```

Scatterplots
----

 - Simply use the generic command `plot()`
 

``` r
plot(sleep_total~bodywt, msleep)
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-21-1} \end{center}

Scatterplots
----

 - use `log="x"` and `log="y"` to log transform **axis**, not the data
 - use `log="xy"` to transform both axes
 

``` r
plot(sleep_total~bodywt, msleep, 
     log="x", cex.lab=1.5, lwd=2)
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-22-1} \end{center}

# Colors

Very, very basic R colors
----

 - **Names**: "black", "red", "green", "blue", "cyan", "magenta", "yellow", "grey" (or "gray")
 - **Number**: 1, 2, 3, 4, 5, 6, 7, 8
 - Recycles to infinity
    + i.e., 9 = "black", 10 = "red",  so on
 - Also have "white"
 - 0 = "transparent"

Very, very basic R colors
----


``` r
x<-y<-1:20 # Yes, you can do this
plot(y~x, col=x, pch=16, cex=4)
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-23-1} \end{center}

Scatterplots: Add a Legend based on `vore`
----


``` r
plot(sleep_total~bodywt, msleep, log="x")
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-24-1} \end{center}

Scatterplots: Add a Legend based on `vore`
----


``` r
head(msleep$vore, 10)
```

```
##  [1] carni omni  herbi omni  herbi herbi carni <NA>  carni herbi
## Levels: carni herbi insecti omni
```

``` r
head(as.integer(msleep$vore), 10)
```

```
##  [1]  1  4  2  4  2  2  1 NA  1  2
```

``` r
levels(msleep$vore)
```

```
## [1] "carni"   "herbi"   "insecti" "omni"
```

Scatterplots: Add a Legend based on `vore`
----


``` r
plot(sleep_total~bodywt, msleep, log="x", col=msleep$vore)
legend("topright", legend=levels(msleep$vore), 
       col=1:4, pch=1)
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-26-1} \end{center}

Plotting Exercise
----

1.Using the `rhone` dataset in the `ade4` package, plot a variable of your choice as a function of `air.temp`. Add plain english axis labels and a title for the plot.

2.Increase the expansion factor by 25% and remove the box around the plot.

3.Change data symbols from small circles to triangles.


Plotting Exercise
----

1.Using the `rhone` dataset in the `ade4` package, plot a variable of your choice as a function of `air.temp`. Add plain english axis labels and a title for the plot.


``` r
library(ade4)
data(rhone)
str(rhone)
```

```
## List of 3
##  $ tab  :'data.frame':	39 obs. of  15 variables:
##   ..$ air.temp  : num [1:39] 2 2 10 16 15 10 15 12 16 23 ...
##   ..$ wat.temp  : num [1:39] 5.9 3.4 7.5 9.1 9.6 10.1 11.4 9.5 11 16.3 ...
##   ..$ conduc    : num [1:39] 359 348 260 298 287 277 293 295 299 243 ...
##   ..$ pH        : num [1:39] 8.2 7.9 8 7.9 8.2 8.2 8.2 8.1 8.3 8.1 ...
##   ..$ oxygen    : num [1:39] 93 92 94 101 96 98 98 98 95 93 ...
##   ..$ secchi    : num [1:39] 67 203 176 85 40 28 22 55 22 73 ...
##   ..$ caco3     : num [1:39] 186 176 176 165 167 165 176 170 170 135 ...
##   ..$ totca     : num [1:39] 62.9 57.7 60.1 57.7 58.9 57.3 62.1 58.9 60.1 45.3 ...
##   ..$ mg        : num [1:39] 7.1 7.8 6.3 5.1 4.9 5.3 5.1 5.6 4.9 5.3 ...
##   ..$ so4       : num [1:39] 35 42.1 32.9 32.8 24.4 28.6 22.5 29.8 30.7 33.5 ...
##   ..$ no2       : num [1:39] 0.55 0.78 0.54 0.63 0.48 0.48 0.55 0.5 0.65 0.54 ...
##   ..$ hco3      : num [1:39] 177 159 170 161 177 ...
##   ..$ suspension: num [1:39] 17.3 3.7 4.4 22 44.9 92.4 98 40 29.3 26.6 ...
##   ..$ organique : num [1:39] 2.6 0.9 1.2 3.7 5.6 8.8 9.8 4.4 4.4 5.4 ...
##   ..$ chloro    : num [1:39] 1.4 1.6 5.7 6.2 2.9 9.2 4.4 10.6 1.5 6.4 ...
##  $ date : num [1:39] 33 53 73 109 123 129 138 144 151 158 ...
##  $ disch:'data.frame':	39 obs. of  3 variables:
##   ..$ Geneva: num [1:39] 299 266 113 389 315 254 357 469 435 351 ...
##   ..$ Arve  : num [1:39] 60 30.7 53 99.5 141 312 197 117 119 193 ...
##   ..$ Others: num [1:39] 218 89.3 255 248.5 433 ...
```

Plotting Exercise
----

1.Using the `rhone` dataset in the `ade4` package, plot a variable of your choice as a function of `air.temp`. Add plain english axis labels and a title for the plot.


``` r
rh<-rhone$tab
plot(conduc~air.temp, rh, xlab="Air Temperature",
     ylab="Conductivity",
     main="Rhone River Conductivity vs Air Temperature")
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-28-1} \end{center}

Plotting Exercise
----

2.Increase the size of everything by 25% (a.k.a. expansion factor), double the line thickness of the symbols, and remove the box around the plot.


``` r
par(cex=1.25, lwd=2, bty="n")
plot(conduc~air.temp, rh, xlab="Air Temperature",
     ylab="Conductivity",
     main="Rhone River Conductivity vs Air Temperature")
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-29-1} \end{center}

Plotting Exercise
----

3.Change data symbols from small circles to triangles.


``` r
par(cex=1.25, lwd=2, bty="n", pch=2)
plot(conduc~air.temp, rh, xlab="Air Temperature",
     ylab="Conductivity",
     main="Rhone River Conductivity vs Air Temperature")
```



\begin{center}\includegraphics{Plotting_basics_files/figure-beamer/unnamed-chunk-30-1} \end{center}
