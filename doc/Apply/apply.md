Une introduction à “apply” in R
==============================

source: http://nsaunders.wordpress.com/2010/08/20/a-brief-introduction-to-apply-in-r/

At any R Q&A site, you’ll frequently see an exchange like this one:

    Q: How can I use a loop to [...insert task here...] ?
    A: Don’t. Use one of the apply functions. 

So, what are these wondrous apply functions and how do they work? I think the best way to figure out anything in R is to learn by experimentation, using embarrassingly trivial data and functions.

If you fire up your R console, type “??apply” and scroll down to the functions in the base package, you’ll see something like this:

base::apply             Apply Functions Over Array Margins
base::by                Apply a Function to a Data Frame Split by Factors
base::eapply            Apply a Function Over Values in an Environment
base::lapply            Apply a Function over a List or Vector
base::mapply            Apply a Function to Multiple List or Vector Arguments
base::rapply            Recursively Apply a Function to a List
base::tapply            Apply a Function Over a Ragged Array

Let’s examine each of those.

1. apply
--------
Description: “Returns a vector or array or list of values obtained by applying a function to margins of an array or matrix.”

OK – we know about vectors/arrays and functions, but what are these “margins”? Simple: either the rows (1), the columns (2) or both (1:2). By “both”, we mean “apply the function to each individual value.” An example:

```r
# create a matrix of 10 rows x 2 columns
m <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)
# mean of the rows
apply(m, 1, mean)
```

```
##  [1]  6  7  8  9 10 11 12 13 14 15
```

```r
# mean of the columns
apply(m, 2, mean)
```

```
## [1]  5.5 15.5
```

```r
# divide all values by 2
apply(m, 1:2, function(x) x/2)
```

```
##       [,1] [,2]
##  [1,]  0.5  5.5
##  [2,]  1.0  6.0
##  [3,]  1.5  6.5
##  [4,]  2.0  7.0
##  [5,]  2.5  7.5
##  [6,]  3.0  8.0
##  [7,]  3.5  8.5
##  [8,]  4.0  9.0
##  [9,]  4.5  9.5
## [10,]  5.0 10.0
```

That last example was rather trivial; you could just as easily do “m[, 1:2]/2″ – but you get the idea.

2. by
------
Updated 27/2/14: note that the original example in this section no longer works; use colMeans now instead of mean.
Description: “Function ‘by’ is an object-oriented wrapper for ‘tapply’ applied to data frames.”

The by function is a little more complex than that. Read a little further and the documentation tells you that “a data frame is split by row into data frames subsetted by the values of one or more factors, and function ‘FUN’ is applied to each subset in turn.” So, we use this one where factors are involved.

To illustrate, we can load up the classic R dataset “iris”, which contains a bunch of flower measurements:

```r
attach(iris)
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

```r
# get the mean of the first 4 variables, by species
by(iris[, 1:4], Species, colMeans)
```

```
## Species: setosa
## Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
##        5.006        3.428        1.462        0.246 
## -------------------------------------------------------- 
## Species: versicolor
## Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
##        5.936        2.770        4.260        1.326 
## -------------------------------------------------------- 
## Species: virginica
## Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
##        6.588        2.974        5.552        2.026
```


Essentially, by provides a way to split your data by factors and do calculations on each subset. It returns an object of class “by” and there are many, more complex ways to use it.

3. eapply
---------
Description: “eapply applies FUN to the named values from an environment and returns the results as a list.”

This one is a little trickier, since you need to know something about environments in R. An environment, as the name suggests, is a self-contained object with its own variables and functions. To continue using our very simple example:

```r
# a new environment
e <- new.env()
# two environment variables, a and b
e$a <- 1:10
e$b <- 11:20
# mean of the variables
eapply(e, mean)
```

```
## $a
## [1] 5.5
## 
## $b
## [1] 15.5
```


I don’t often create my own environments, but they’re commonly used by R packages such as Bioconductor so it’s good to know how to handle them.

4. lapply
---------
Description: “lapply returns a list of the same length as X, each element of which is the result of applying FUN to the corresponding element of X.”

That’s a nice, clear description which makes lapply one of the easier apply functions to understand. A simple example:

```r
# create a list with 2 elements
l <- list(a = 1:10, b = 11:20)
# the mean of the values in each element
lapply(l, mean)
```

```
## $a
## [1] 5.5
## 
## $b
## [1] 15.5
```

```r
# the sum of the values in each element
lapply(l, sum)
```

```
## $a
## [1] 55
## 
## $b
## [1] 155
```


The lapply documentation tells us to consult further documentation for sapply, vapply and replicate. Let’s do that.

    4.1 sapply
    ----------
Description: “sapply is a user-friendly version of lapply by default returning a vector or matrix if appropriate.”

That simply means that if lapply would have returned a list with elements $a and $b, sapply will return either a vector, with elements [['a']] and [['b']], or a matrix with column names “a” and “b”. Returning to our previous simple example:

```r
# create a list with 2 elements
l <- list(a = 1:10, b = 11:20)
# mean of values using sapply
l.mean <- sapply(l, mean)
# what type of object was returned?
class(l.mean)
```

```
## [1] "numeric"
```

```r
# it's a numeric vector, so we can get element 'a' like this
l.mean[["a"]]
```

```
## [1] 5.5
```


    4.2 vapply
    -----------
Description: “vapply is similar to sapply, but has a pre-specified type of return value, so it can be safer (and sometimes faster) to use.”

A third argument is supplied to vapply, which you can think of as a kind of template for the output. The documentation uses the fivenum function as an example, so let’s go with that:

```r
l <- list(a = 1:10, b = 11:20)
# fivenum of values using vapply
l.fivenum <- vapply(l, fivenum, c(Min. = 0, `1st Qu.` = 0, Median = 0, `3rd Qu.` = 0, 
    Max. = 0))
class(l.fivenum)
```

```
## [1] "matrix"
```

```r

# let's see it
l.fivenum
```

```
##            a    b
## Min.     1.0 11.0
## 1st Qu.  3.0 13.0
## Median   5.5 15.5
## 3rd Qu.  8.0 18.0
## Max.    10.0 20.0
```


So, vapply returned a matrix, where the column names correspond to the original list elements and the row names to the output template. Nice.

    4.3 replicate
    -------------
Description: “replicate is a wrapper for the common use of sapply for repeated evaluation of an expression (which will usually involve random number generation).”

The replicate function is very useful. Give it two mandatory arguments: the number of replications and the function to replicate; a third optional argument, simplify = T, tries to simplify the result to a vector or matrix. An example – let’s simulate 10 normal distributions, each with 10 observations:

```r
replicate(10, rnorm(10))
```

```
##           [,1]    [,2]     [,3]    [,4]    [,5]    [,6]    [,7]    [,8]
##  [1,] -1.61216  2.4135 -0.63429  1.0692 -1.0276  1.4250 -0.3813 -1.2755
##  [2,] -0.08217  0.2226  0.70225  0.7409 -1.5667  0.2318 -1.5941 -0.4001
##  [3,] -1.88433  2.1060 -0.62838 -1.2015  1.6868  0.5612 -0.5139 -0.2693
##  [4,] -0.56366 -0.1698  1.40035  0.5357  0.4151  0.1034 -1.0760 -0.4197
##  [5,]  1.06011  0.1812  0.55333  0.6288 -1.0681  1.0111  1.5814 -0.4744
##  [6,] -0.61775  0.8535  0.21791  0.8281 -2.9412  0.6995  1.2432  0.1883
##  [7,]  0.98996 -1.0046 -0.14792 -0.4550  0.4042 -0.4322 -0.9746 -0.2277
##  [8,]  1.53377 -0.6002  0.60405 -0.3759 -0.1683 -1.2682  0.3630  0.1456
##  [9,]  0.33232  0.8685  0.29591  0.6727 -2.7605 -0.4139 -0.4098  0.9131
## [10,]  0.17398  1.4212  0.09452 -3.4987 -1.0469  0.2582  0.8206  0.4694
##           [,9]   [,10]
##  [1,]  1.63776 -1.8111
##  [2,]  0.60047 -0.2523
##  [3,] -1.00599 -0.7878
##  [4,]  0.04986 -0.8009
##  [5,]  0.39480 -0.5229
##  [6,]  0.68287  1.2724
##  [7,] -0.20719 -0.7930
##  [8,]  0.17602 -0.3586
##  [9,] -0.49357  0.2685
## [10,] -1.18379  0.1372
```


5. mapply
----------

Description: “mapply is a multivariate version of sapply. mapply applies FUN to the first elements of each (…) argument, the second elements, the third elements, and so on.”

The mapply documentation is full of quite complex examples, but here’s a simple, silly one:

```r
l1 <- list(a = c(1:10), b = c(11:20))
l2 <- list(c = c(21:30), d = c(31:40))
# sum the corresponding elements of l1 and l2
mapply(sum, l1$a, l1$b, l2$c, l2$d)
```

```
##  [1]  64  68  72  76  80  84  88  92  96 100
```


Here, we sum l1$a[1] + l1$b[1] + l2$c[1] + l2$d[1] (1 + 11 + 21 + 31) to get 64, the first element of the returned list. All the way through to l1$a[10] + l1$b[10] + l2$c[10] + l2$d[10] (10 + 20 + 30 + 40) = 100, the last element.

6. rapply
---------

Description: “rapply is a recursive version of lapply.”

I think “recursive” is a little misleading. What rapply does is apply functions to lists in different ways, depending on the arguments supplied. Best illustrated by examples:

```r
# let's start with our usual simple list example
l <- list(a = 1:10, b = 11:20)
# log2 of each value in the list
rapply(l, log2)
```

```
##    a1    a2    a3    a4    a5    a6    a7    a8    a9   a10    b1    b2 
## 0.000 1.000 1.585 2.000 2.322 2.585 2.807 3.000 3.170 3.322 3.459 3.585 
##    b3    b4    b5    b6    b7    b8    b9   b10 
## 3.700 3.807 3.907 4.000 4.087 4.170 4.248 4.322
```

```r
# log2 of each value in each list
rapply(l, log2, how = "list")
```

```
## $a
##  [1] 0.000 1.000 1.585 2.000 2.322 2.585 2.807 3.000 3.170 3.322
## 
## $b
##  [1] 3.459 3.585 3.700 3.807 3.907 4.000 4.087 4.170 4.248 4.322
```

```r
# what if the function is the mean?
rapply(l, mean)
```

```
##    a    b 
##  5.5 15.5
```

```r
rapply(l, mean, how = "list")
```

```
## $a
## [1] 5.5
## 
## $b
## [1] 15.5
```


So, the output of rapply depends on both the function and the how argument. When how = “list” (or “replace”), the original list structure is preserved. Otherwise, the default is to unlist, which results in a vector.

You can also pass a “classes=” argument to rapply. For example, in a mixed list of numeric and character variables, you could specify that the function act only on the numeric values with “classes = numeric”.

7. tapply
---------- 

Description: “Apply a function to each cell of a ragged array, that is to each (non-empty) group of values given by a unique combination of the levels of certain factors.”

Woah there. That sounds complicated. Don’t panic though, it becomes clearer when the required arguments are described. Usage is “tapply(X, INDEX, FUN = NULL, …, simplify = TRUE)”, where X is “an atomic object, typically a vector” and INDEX is “a list of factors, each of same length as X”.

So, to go back to the famous iris data, “Species” might be a factor and “iris$Petal.Width” would give us a vector of values. We could then run something like:

```r
attach(iris)
```

```
## Les objets suivants sont masqués from iris (position 3):
## 
##     Petal.Length, Petal.Width, Sepal.Length, Sepal.Width, Species
```

```r
# mean petal length by species
tapply(iris$Petal.Length, Species, mean)
```

```
##     setosa versicolor  virginica 
##      1.462      4.260      5.552
```


Summary
-------
I’ve used very simple examples here, with contrived data and standard functions (such as mean and sum). For me, this is the easiest way to learn what a function does: I can look at the original data, then the result and figure out what happened. However, the “apply” family is a much more powerful than these illustrations – I encourage you to play around with it.

The things to consider when choosing an apply function are basically:

    What class is my input data? – vector, matrix, data frame…
    On which subsets of that data do I want the function to act? – rows, columns, all values…
    What class will the function return? How is the original data structure transformed?

It’s the usual input-process-output story: what do I have, what do I want and what lies inbetween?
