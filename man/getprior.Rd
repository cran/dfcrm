\name{getprior}
\alias{getprior}
\title{Calibrating prior DLT rates}
\description{
  Returns a vector of initial guesses of toxicity probabilities
  associated the doses for a given model sensitivity (set of
  indifference intervals).}

\usage{
getprior(halfwidth, target, nu, nlevel, model = "empiric", intcpt = 3)
}

\arguments{
  \item{halfwidth}{The desired halfwidth of the indifference intervals.}
  
  \item{target}{The target DLT rate.}

  \item{nu}{The prior guess of MTD.}

  \item{nlevel}{The number of test doses.}
  
  \item{model}{A character string to specify the working model used in
    the method.  The default model is ``empiric''.  A one-parameter
    logistic model is specified by ``logistic''.}
  
  \item{intcpt}{The intercept of the working logistic model.  The
    default is 3.  If \code{model}=``empiric'', this argument will be
    ignored.}
}

\value{
  A vector of length \code{nlevel} is returned.
}

\details{
  \code{getprior} is an ``inverse'' function of \code{crmsens} which
  gives the indifference intervals for a given set of initial guesses.
}

\seealso{
  \code{\link{crmsens}}
}

\references{
  Cheung, Y. K. and Chappell, R. (2002). A simple technique to evaluate
  model sensitivity in the continual reassessment method.  Biometrics
  58:671-674.
}

\examples{
target <- 0.25
delta <- 0.10
mtd0 <- 3

# initial DLT rates with indifference intervals [0.15, 0.35].
prior <- getprior(delta, target, mtd0,nlevel=6, model="logistic")
}

\keyword{datasets}

