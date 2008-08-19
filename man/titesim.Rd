\name{titesim}
\alias{titesim}
\alias{onetite}
\alias{mtite}
\title{TITE-CRM Simulator}
\description{
  \code{titesim} is used to generate simulation replicates of phase I
  trial using the TITE-CRM under a specified dose-toxicity
  configuration.
}

\usage{
titesim(PI, prior, target, n, x0, nsim = 1, restrict = TRUE, obswin = 1,
tgrp = obswin, rate = 1, accrual = "fixed", surv = "uniform", scheme =
"linear", count = TRUE, method = "bayes", model = "empiric", intcpt = 3,
scale = sqrt(1.34), seed = 1009)
}

\arguments{
  \item{PI}{A vector of the true toxicity probabilites associated with
    the doses.}
  
  \item{prior}{A vector of initial guesses of toxicity probabilities
    associated with the doses.  Must be of same length as \code{PI}.}
  
  \item{target}{The target DLT rate.}
  
  \item{n}{Sample size of the trial.}
  
  \item{x0}{The initial design.  For one-stage TITE-CRM, it is a
    single numeric value indicating the starting dose.  For two-stage
    TITE-CRM, it is a non-decreasing sequence of dose levels of length
    \code{n}.}

  \item{nsim}{The number of simulations.  Default is set at 1.}
  
  \item{restrict}{If TRUE, restrictions apply during the trials to avoid
    (1) skipping doses in escalation and (2) escalation immediately
    after a toxic outcome (i.e., incoherent escalation).  If FALSE, dose
    assignments are purely model-based.}
 
  \item{obswin}{The observation window with respect to which the MTD is
    defined.}
  
  \item{tgrp}{The minimum waiting time between two dose cohorts at the
    initial stage.  Default is set as \code{obswin}, i.e., complete
    follow-up in all current patients is required before escalation to
    the next dose group.  This argument is used only in two-stage TITE-CRM.}
  
  \item{rate}{Patient arrival rate: Expected number of arrivals per
    observation window.  Example: obswin=6 and rate=3 means expecting 3
    patients arrive in 6 time units.}
  
  \item{accrual}{Patient accrual scheme.  Default is ``fixed'' whereby
    inter-patient arrival is fixed.  Alternatively, use ``poisson'' to
    simulate patient arrivals by the Poisson process.}
  
  \item{surv}{Distribution for time-to-toxicity.  Default is ``uniform''
    where toxicity, if occurs, occurs uniformly on the interval
    [0,\code{obswin}].  Other survival distributions including exponential and
    Weibull are to be made available.}
  
  \item{scheme}{A character string to specify the method for assigning
    weights.  Default is ``linear''.  An adaptive weight is specified by
    ``adaptive''.}
  
  \item{count}{If TRUE, the number of the current simulation replicate
    will be displayed.}
  
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
  
  \item{seed}{Seed of the random number generator.}
}

\value{
  An object of class ``sim'' is returned, consisting of the operating
  characteristics of the design specified.
  
  For a ``sim'' object with \code{nsim}=1, the time component of
  individual subjects in the simulated trial is available via the
  values \code{arrival}, \code{toxicity.time}, and
  \code{toxicity.study.time} which respectively contain patients'
  arrival times, times-to-toxicity, and the times-to-toxicity per study time.
  
  For a ``sim'' object with \code{nsim}>1, the time component of the
  design is summarized via the value \code{Duration}, which is the
  duration of the simulated trials, computed by adding the arrival time
  of the last patient and \code{obswin}.

  All ``sim'' objects contain at least the following components:
    
  \item{PI}{True toxicity rates.}
  
  \item{prior}{Initial guesses of toxicity rates.}

  \item{target}{The target probability of toxicity at the MTD.}

  \item{n}{Sample size.}

  \item{x0}{The initial design.}

  \item{MTD}{Distribution of the MTD estimates.  If \code{nsim}=1, this
    is a single numeric value of the recommended MTD of in simulated
    trial.}
    
  \item{level}{Average number of patients treated at the test doses.  If
    \code{nsim}=1, this is a vector of length \code{n} indicating the
    doses assigned to the patients in the simulated trial.}

  \item{tox}{Average number of toxicities seen at the test doses.  If
    \code{nsim}=1, this is a vector of length \code{n} indicating the
    toxicity outcomes of the patients in the simulated trial.}
  
  \item{beta.hat}{The estimates of the model parameter throughout the
    simulated trial(s).  The dose assignment of the jth patient in each
    trial corresponds to the jth element in each row.}

  \item{final.est}{The final estimates of the model parameter of the
    simulated trials.}

  
}


\seealso{
  \code{\link{crmsim}}, \code{\link{titecrm}}.
}

\references{
  Cheung, Y. K. and Chappell, R. (2000). Sequential designs for phase I
  clinical trials with late-onset toxicities.  Biometrics 56:1177-1182.

  Cheung, Y. K. (2005). Coherence principles in dose-finding studies.
  Biometrika 92:863-873.
}

\examples{
PI <- c(0.10,0.20,0.40,0.50,0.60,0.65)
prior <- c(0.05,0.10,0.20,0.35,0.50,0.70)
target <- 0.2
x0 <- c(rep(1,3),rep(2,3),rep(3,3),rep(4,3),rep(5,3),rep(6,9))

# Generate a single replicate of two-stage TITE-CRM trial of size 24
foo <- titesim(PI,prior,target,24,x0, obswin=6,rate=4,accrual="poisson")
\dontrun{plot(foo,ask=T)}  # summarize trial graphically

# Generate 10 replicates of TITE-CRM trial of size 24
foo10 <- titesim(PI,prior,target,24,3,nsim=10,obswin=6,rate=4,accrual="poisson")

foo10
}

\keyword{datasets}
