## Overall the functions demonstrate the use of <<- operator to assign values to objects from across environments
## The code also demonstrates the use of "get" and "set" operations and how use of caching helps avoid peformance issues in computing intensive operations

## This function creates a matrix object which caches its inverse. The object also returns a list of "set" and "get" functions  

makeCacheMatrix <- function(x = matrix()) {


	invmat = NULL  # initialize the inverse matrix object

	set = function(y) {
		x <<- y
		invmat <<- NULL  ## <<- is used to assign value to an object in an environment, that is different from the environment it is used in

	}

	get = function() x 
	setinvmat = function(inverse) invmat <<- inverse
	getinvmat = function() invmat
        list(set=set, get=get, setinvmat=setinvmat, getinvmat=getinvmat)

}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## takes the matrix object "x" set in the makeCacheMatrix 
	## Return a matrix that is the inverse of 'x'
	
	invmat = x$getinvmat()  ## call the getinvmat function in the matrix object to obtain the inversematrix of "x"														

	if (!is.null(invmat)){  ## if invmat already exists in cache
		message("reading inverse matrix from cache") 
		return(invmat)
	}

	## if invmat not found in cache, then create one

	invmat = solve(x$get(), ...) ## inverting the matrix "x"
	x$setinvmat(invmat) ## set the inversematrix by calling "setinvmat" function in the "makeCacheMatrix" function
	return(invmat)


}
