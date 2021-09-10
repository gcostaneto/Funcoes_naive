#define Jaccard Similarity function
jaccard <- function(a, b) {
    intersection = length(intersect(a, b))
    union = length(a) + length(b) - intersection
    return (intersection/union)
}


a <- c(0, 1, 2, 5, 6, 8, 9)
b <- c(0, 2, 3, 4, 5, 7, 9)

#find Jaccard Similarity between the two sets 
jaccard(a, b)

# 0.4
