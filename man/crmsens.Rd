\name{crmsens}
\alias{crmsens}
\alias{print.dxcrm}
\title{Model Sensitivity in the CRM}
\description{
  Evaluate the model sensitivity in the CRM by indifference intervals.}

\usage{
crmsens(prior, target, model = "empiric", intcpt = 3, eps = 1e-06, 
    maxit = 100, detail = FALSE) 
}

\arguments{
  \item{prior}{A vector of initial guesses of toxicity probabilities
    associated the doses.}

  \item{target}{The target DLT rate.}

  \item{model}{A character string to specify the working model used in
    the method.  The default model is ``empiric''.  A one-parameter
    logistic model is specified by ``logistic''.}
  
  \item{intcpt}{The intercept of the working logistic model.  The
    default is 3.  If \code{model}=``empiric'', this argument will be
    ignored.}

  \item{eps}{Error tolerance in the computation of indifference
    intervals.}

  \item{maxit}{Maximum number of iterations in the computation of
    indifference intervals.}
  
  \item{detail}{If TRUE, the details of the ``H sets'' will be
    displayed.  Default is FALSE.}
  
}

\value{
  The function \code{crmsens} returns the model sensitivity for the
  model specifications given by the user.
  
  \item{Hset}{The ``H sets'' of the model parameter.}
  
  \item{iint}{The indifference intervals of the dose-toxicity model
    associated with the test doses.}
}


\seealso{
  \code{\link{crm}}, \code{\link{getprior}}
}

\references{
  Cheung, Y. K. and Chappell, R. (2002). A simple technique to evaluate
  model sensitivity in the continual reassessment method.  Biometrics
  58:671-674.

  Cheung, Y. K. (2011).  Dose Finding by the Continual Reassessment Method.  New York: Chapman & Hall/CRC Press.
}

\examples{
prior <- c(0.05, 0.10, 0.20, 0.35, 0.50, 0.70)
target <- 0.2
foo <- crmsens(prior, target, model="logistic", intcpt=2, detail=TRUE)
}

\keyword{datasets}

