### Repreducible Research Videos :: Week 1
## PART 1
not much chop

## PART 2
Less chop

## PART 3
literate programming
weaved to produced human readable
tangled to produce computer language

Sweave -> uses LaTeX

knitr

## PART 4
Script everything

## PART 5
Structure of Data Analysis PART 1

SPAM emails
Descriptive - a whole population
exploratory - random sample, many variables
inferential - right population, randomly sampled
predictive - training and test data set from same population
causal - data from randomised study
mechanistic - data about all components of a system



R kernlab package



library(kernlab)
data(spam)
str(spam[,1:5])




## PART 6
Structure of Data Analysis PART 2

# perfrorm sub sampling
set.seed(3435)
trainIndicator = rbinom(4601, size=1, prob=0.5)

table(trainIndicator)

trainSpam = spam[ trainIndicator == 1, ]
testSpam = spam[ trainIndicator == 0, ]

head(trainSpam)

plot(log10(trainSpam$capitalAve+1) ~ trainSpam$type)

plot(log10(trainSpam[,1:4]+1))

hCluster = hclust(dist(t(trainSpam[,1:57])))
plot(hCluster)

#####

trainSpam$numType = as.numeric(trainSpam$type) - 1
costFunction = function(x,y) sum( x != (y>0.5) )
cvError = rep(NA, 55)

library(boot)

for(i in 1:55)
{
      lmFormula = reformulate(names(trainSpam)[i], response = "numType")
      glmFit = glm(lmFormula, family = "binomial", data = trainSpam )
      cvError[i] = cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}

## Which predictor has minum cross-validated error?
names(trainSpam)[which.min(cvError)]
# Best predictor
"charDollar" = number of dollar signs in email



predictionModel = glm(numType ~ charDollar, family="binomial", data = trainSpam)

# Get predictions on the test set
predictionTest = predict(predictionModel, testSpam)
predictionSpam = rep("nonspam", dim(testSpam)[1])

## Classify as 'spam' for those with prob > 0.5
predictionSpam[predictionModel$fitted > 0.5] = "spam"

## classification table
table(predictionSpam, testSpam$type)

## Interpret language
language
describes
corrolates
associated with
leads to / causes
predicts

measures of uncertainty

## fractions of characters with dollar signs predicts spam
more dollar signs = more spam
test set error was 22.4%

alternative analysis

## Synthesise and Write up results

lead with question
describe approach
interpret result
challenge results

## PART 7
## Organising a Data Analysis
key files
DATA
- RAW
- PROCESSED
FIGURES
- EXPLORATORY
- FINAL
R CODE
- RAW / UNUSED SCRIPTS
- FINAL SCRIPTS
- R MARKDOWN FILES
TEXT
- README
- TEXT OF ANALYSIS / REPORT


Store data in analysis folder
url 
where you got the data
date, time

Processed data mapping should be in the read me

Final figures:
Make them pretty
colours
axes

USe R markdown

include 
- title
- introduction
- methods
- results
- conculsions





















