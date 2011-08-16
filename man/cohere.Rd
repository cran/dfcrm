\name{cohere}
\alias{cohere}
\title{Coherence of two-stage CRM}
\description{
  Returns a message on the coherence status of a two-stage CRM
  design.}

\usage{
cohere(prior, target, x0, method = "bayes", model = "empiric", 
    intcpt = 3, scale = sqrt(1.34), detail = TRUE)
}

\arguments{
  \item{prior}{A vector of initial guesses of toxicity probabilities
    associated the doses.}

  \item{target}{The target DLT rate.}
  
  \item{x0}{The initial design containing a non-decreasing sequence of
    dose levels.  The length of the initial design is the sample size.}

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

  \item{detail}{If TRUE, details about incoherent escalations
    will be displayed.}
}
\value{
  \item{message}{A string character giving a message regarding the
    coherence status of a two-stage CRM design.}
}

\seealso{
  \code{\link{crm}}
}

\references{
  Cheung, Y. K. (2005). Coherence principles in dose-finding studies.
  Biometrika 92:863-873.
  
  Cheung, Y. K. (2011).  Dose Finding by the Continual Reassessment Method.  New York: Chapman & Hall/CRC Press.
}

\examples{
prior <- c(0.05, 0.10, 0.20, 0.35, 0.50, 0.70)
x0 <- c(rep(1,3), rep(2,3), rep(3,3), rep(4,3), rep(5,3), rep(6,9))

# The above design is coherent when target rate = 0.20
foo <- cohere(prior, target=0.2, x0)
foo

# The design is incoherent if a larger target DLT rate is used.
foo2 <- cohere(prior, target=0.3, x0)
}

\keyword{datasets}
