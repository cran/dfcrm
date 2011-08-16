\name{getinit}
\alias{getinit}
\title{Calibrating an initial design}
\description{
  Returns an initial design that is compatible with the specified CRM
  setup when used in a two-stage design.
}

\usage{
getinit(prior, target, n, nK = round(n/3), method = "bayes", 
    model = "empiric", intcpt = 3, scale = sqrt(1.34), detail = FALSE) 
}

\arguments{
  \item{prior}{A vector of initial guesses of toxicity probabilities
    associated the doses.}

  \item{target}{The target DLT rate.}

  \item{n}{The sample size of the trial.}

  \item{nK}{The minimum number of subjects required at the highest test
    dose in case of no toxicity throughout the trial.}
  
  \item{method}{A character string to specify the method for parameter
    estimation.  The default method ``bayes'' estimates the model
    parameter by the posterior mean.  Maximum likelihood estimation is
    specified by ``mle''.}
  
  \item{model}{A character string to specify the working model used in
    the method.  The default model is ``empiric''.  A one-parameter
    logistic model is specified by ``logistic''.}

  \item{intcpt}{The intercept of the working logistic model.  The
    default is 3.  If \code{model}=``empiric'', this argument will be
    ignored.}
    
  \item{scale}{Standard deviation of the normal prior of the model
    parameter.  Default is sqrt(1.34).}

  \item{detail}{If TRUE, intermediate designs will be displayed.}
}

\value{
  A non-decreasing sequence of dose levels is returned.
}

\details{
  An initial design will be incompatible to the CRM setup if the
  escalation pace is too conservative, i.e. slow.  The algorithm in
  \code{getinit} starts the search of a compatible design with an
  aggressive initial design that starts a trial at the second highest
  dose.  A more conservative design will be subsequently tested for
  compatibility if the current design is compatible.  The sequence
  returned may be viewed as a conservative compatible initial design.
}

\seealso{
  \code{\link{cohere}}
  }

\references{
  Cheung, Y. K. (2005). Coherence principles in dose-finding studies.
  Biometrika 92:863-873.

  Cheung, Y. K. (2011).  Dose Finding by the Continual Reassessment Method.  New York: Chapman & Hall/CRC Press.  
}

\examples{
prior <- c(0.05, 0.10, 0.20, 0.35, 0.50, 0.70)
target <- 0.2

# Seach stops because it requires at least 8 subjects at the highest dose
getinit(prior, target, 25, nK=8, method="mle", detail=TRUE)

# Search stops because an incompatible design is reached
getinit(prior, 0.3, 25, nK=8, method="mle", detail=TRUE)




}

\keyword{datasets}
