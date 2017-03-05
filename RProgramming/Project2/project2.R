###########################################################################################
# Matrix Invertibility Example

makeCacheMatrix <- function(x = matrix()) {
    # initialize the inverse to NULL
    i <- NULL
    # the set() method overwrites x with the input arg of this method is when called
    set <- function(y) {
        x <<- y
        i <<- NULL
    }
    # the get() method just prints out the latest input of x when this function was called
    get <- function() x
    # setinv calculates the value by mapping i to inverse calculation; getinv returns it
    setinv <- function(inv) i <<- inv
    getinv <- function() i
    # function returns a list of these methods that can be acted on it
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}

cacheSolve <- function(x, ...) {
    # go into the getinv attribute of the pseudo-matrix object to find the inverse
    i <- x$getinv()
    # if the inverse has already been calculated, make note that it is cached and return it
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    # if inverse is not cached, get the matrix representation...
    data <- x$get()
    # ...perform the inverse operation on it and set the inverse as the setinv attribute
    i <- solve(data, ...)
    x$setinv(i)
    # return the inverse
    i
}

# create a cached matrix with the given dimensions, and print it out with the get() method
myMatrix = makeCacheMatrix(matrix(1:4, 2, 2))
myMatrix$get()

# solve the inverse value and cache it, printing it out with getinv() method
cacheSolve(myMatrix)
myMatrix$getinv()

# redefine myMatrix; print out its content using the get() method
myMatrix$set(matrix(3:6, 2, 2))
myMatrix$get()

# note that calling getinv() returns NULL since it hasn't been cached
myMatrix$getinv()
# cacheSolve the inverse; now calling the getinv() method returns the new inverse value 
cacheSolve(myMatrix)
myMatrix$getinv()

###########################################################################################
# Vector Mean Example

makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}

### Application Example:
# create a vector and return the entries
myVector = makeVector(c(1, 2, 6)) 
myVector$get() 

# calculate and cache the mean; return it
cachemean(myVector) 
myVector$getmean() 

# redefine myVector using the set command
myVector$set(c(4, 1, 1)) 
myVector$get() 

# calling getMean() returns NULL since it was redefined, caching the mean changes it to 2
myVector$getmean() # NULL (we have redefined the vector)
cachemean(myVector) 
myVector$getmean() 

