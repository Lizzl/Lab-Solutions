#Bank Data

"""
Problem # 2 =  bad/good customers - loan status 
Let’s find out month to month, how many customers were doing transactions. 
Can we predict the status of a loan based on the fields we have from the loan
 table and the transactions?
Approach - develop a classification model to predict the status of the loan.
Tool = logistic regression


Logistic regression is a technique for modelling the probability of an event. 
Just like linear regression, it helps you understand the relationship between 
one or more variables and a target variable
Except that our target variable is binary: its value is either 0 or 1. 

Example: 
It’s possible to say that “smoking can increase your risk of having lung cancer
 by 20%”, since having lung cancer 
is a binary variable: you either have it or not.
 From that, we can infer classification probability based on other factors
like whether someone will have lung cancer given that he/she does not smoke, 
lives in a polluted city and has a family history of lung cancer.

Can we predict the status of a loan based on the fields we have from the loan
table and the transactions?
Approach - develop a classification model to predict the status of the loan.
Tool = logistic regression

When to use logistic regression?

When linear regression makes no sense for our data - eg if we follow a line the linear approach would take us > 100%
Logistic ensures a curve cannot exceed 100% or go below 0
Where response variable is a proportion
When we want a model to predict probabilities of different possible outcomes of a 
categorically distributed response variable, given a set of independent variables

"""

