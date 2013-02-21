\name{getn}
\alias{getn}
\alias{nopt}
\alias{print.crmsize}

\title{Sample size calculator for CRM trials}
\description{
  Sample size calculator for a one-stage Bayesian CRM (see Details for design specification).
}


\usage{
getn(apcs, target, nlevel, psi, correction = TRUE, detail = FALSE)
}

\arguments{
  \item{apcs}{The desired average probability of correction selection (PCS) under the logistic calibration set.}
   
  \item{target}{The target DLT rate.}

  \item{nlevel}{The number of test doses.}

  \item{psi}{Effect size, i.e., odds ratio of the logistic dose-toxicity curves.}
  
  \item{correction}{Continuity correction is applied in the sample size calculation if TRUE (default).  Otherwise if FALSE.}
  
  \item{detail}{Print only essential results for trial planning if FALSE (default).  Otherwise if TRUE.}
}

\value{
  An object of class ``crmsize"  is returned, consisting of the following components:
   \item{n}{The calculated sample size.}
   
   \item{astar}{The desired average PCS.}
   
   \item{target}{The target DLT rate.}
   
   \item{nlevel}{The number of test doses.}
   
   \item{psi}{Odds ratio.}
   
   \item{bstar}{An intermediate value used to calculate the sample size.  Shown only if \code{detail}=TRUE.}
   
   \item{efficiency}{Ratio of required sample sizes of the optimal benchmark and the CRM.  Shown only if \code{detail}=TRUE.}
   
   \item{correction}{Whether continuity correction is applied.  Shown only if \code{detail}=TRUE.}
   
   \item{na}{The CRM sample size before rounding up.}
   
   \item{nb}{The sample size lower bound before rounding up.}
   
   \item{messages}{String characters prompt warning messages and caveats regarding the sample size calculation.}
}

\details{
  The sample size calculation is based on empirical approximation for the CRM using the  power (or empiric)
  dose-toxicity function, \eqn{F(d, \beta) = d^{\exp(\beta)}}, where \eqn{\beta} has a normal prior with
  mean 0 and variance 1.34, and the starting dose is the median level.  
  The ``skeleton" is obtained by setting \code{halfwidth} at \eqn{0.25 \times} \code{target}, 
  and \code{nu} at the median level in the function \code{getprior}.
  
  The calculation is intended to serve as an initial sample size for the CRM calibration process
  depicted in Figure 7.1 in Cheung (2011).
}

\seealso{
  \code{\link{getprior}}
}

\references{
   Cheung, Y. K. (2011).  Dose Finding by the Continual Reassessment Method.  New York: Chapman & Hall/CRC Press.
}

\examples{
apcs <- 0.6    
target <- 0.25
nlevel <- 5
psi <- 1.8     

# Sample size calculation with continuity correction
obj = getn(apcs, target, nlevel, psi, correction=TRUE)
obj

N = obj$n
}

\keyword{datasets}


