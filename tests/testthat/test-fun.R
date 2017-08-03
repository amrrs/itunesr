library(itunesr)
context("getReviews Output DF Check")

test_that("The output dataframe Type is ",{

        expect_equal(class(getReviews(370901726,'gb',1)),"data.frame")
        expect_equal(class(getReviews('297606951','in',2)),"data.frame")

})
