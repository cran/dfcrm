\name{titecrm}
\alias{titecrm}
\alias{crmht}
\alias{crmht2}
\alias{crmht2lgt}
\alias{crmhtlgt}

\title{Executing the TITE-CRM}
\description{
  \code{titecrm} is used to compute a dose for the next patient in a
  phase I trial according to the TITE-CRM.
}

\usage{
titecrm(prior, target, tox, level, n = length(level), weights = NULL,
followup = NULL, entry = NULL, exit = NULL, obswin = NULL, 
scheme = "linear", conf.level = 0.9, dosename = NULL, include = 1:n, 
pid = 1:n, method = "bayes", model = "empiric", var.est = TRUE, 
scale = sqrt(1.34), intcpt = 3, model.detail = TRUE, patient.detail = TRUE, 
tite = TRUE) 
}

\arguments{
  \item{prior}{A vector of initial guesses of toxicity probabilities
    associated the doses.}
  
  \item{target}{The target DLT rate.}
  
  \item{tox}{A vector of patient outcomes; 1 indicates a toxicity, 0
    otherwise.}

  \item{level}{A vector of dose levels assigned to patients.  The length
    of \code{level} must be equal to that of \code{tox}.}
  
  \item{n}{The number of patients enrolled.}

  \item{weights}{A vector of weights assigned to observations.  A
    weight must be between 0 and 1.  If given, the arguments
    \code{followup}, \code{entry}, \code{exit}, \code{obswin},
    and \code{scheme} will be ignored.
    If not supplied, users must provide follow-up information via
    the argument \code{followup} or \code{entry} and \code{exit}, as
    well as the observation window \code{obswin}.  The length of
    \code{weights} must be equal to that of \code{tox}.}
  
  \item{followup}{A vector of follow-up times of patients.  If given,
    the arguments \code{entry} and \code{exit} will be ignored.}
  
  \item{entry}{A vector of entry times of the patients.}
  
  \item{exit}{A vector of exit times of the patients due to either
    end of follow-up or toxicity.}
  
  \item{obswin}{The observation window with respect to which the MTD is
    defined.  If not supplied, users must provide \code{weights}.}
  
  \item{scheme}{A character string to specify the method for assigning
    weights.  Default is ``linear''.  An adaptive weight function is
    specified by ``adaptive''.}
  
  \item{conf.level}{Confidence level for the probability/confidence
    interval of the returned dose-toxicity curve.}
  
  \item{dosename}{A vector containing the names of the regimens/doses
    used.  The length of \code{dosename} must be equal to that of
    \code{prior}.}
  
  \item{include}{A subset of patients included in the dose calculation.}
  
  \item{pid}{Patient ID provided in the study.  Its length must be equal
    to that of \code{level}.}
  
  \item{method}{A character string to specify the method for parameter
    estimation.  The default method ``bayes'' estimates the model
    parameter by the posterior mean.  Maximum likelihood estimation
    is specified by ``mle''.}
  
  \item{model}{A character string to specify the working model used in
    the method.  The default model is ``empiric''.  A one-parameter
    logistic model is specified by ``logistic''.}
  
  \item{var.est}{If TRUE, variance of the estimate of the model parameter and
    probability/confidence interval for the dose-toxicity curve will be
    computed.}
  
  \item{scale}{Standard deviation of the normal prior of the model
    parameter.  Default is sqrt(1.34).}
  
  \item{intcpt}{The intercept of the working logistic model.  The
    default is 3.  If \code{model}=``empiric'', this argument will be
    ignored.}

  \item{model.detail}{If FALSE, the model content of an ``mtd'' object
    will not be displayed.  Default is TRUE.}
  
  \item{patient.detail}{If FALSE, patient summary of an ``mtd'' object
    will not be displayed.  Default is TRUE.}
  
  \item{tite}{If FALSE, the time components in patient summary of an
    ``mtd'' object will be omitted.  Default in TRUE.}
  
}
\value{
  An object of class ``mtd'' is returned, consisting of the summary
  of dose assignments thus far and the recommendation of dose for the
  next patient.
  
  \item{prior}{Initial guesses of toxicity rates.}

  \item{target}{The target probability of toxicity at the MTD.}
  
  \item{ptox}{Updated estimates of toxicity rates.}
  
  \item{ptoxL}{Lower confidence/probability limits of toxicity rates.}
  
  \item{ptoxU}{Upper confidence/probability limits of toxicity rates.}
  
  \item{mtd}{The updated estimate of the MTD.}
  
  \item{prior.var}{The variance of the normal prior.}
  
  \item{post.var}{The posterior variance of the model parameter.}
  
  \item{estimate}{Estimate of the model parameter.}
  
  \item{method}{The method of estimation.}
  
  \item{model}{The working model.}
  
  \item{dosescaled}{The scaled doses obtained via backward substitution.}
  
  \item{tox}{Patients' toxicity indications.}
  
  \item{level}{Dose levels assigned to patients.}

  \item{followup}{Follow-up times of patients.}
  
  \item{obswin}{Observation window with respect to which the MTD is defined.}
  
  \item{weights}{Weights assigned to patients.}
  
  \item{entry}{Entry times of patients.}
  
  \item{exit}{Exit times of patients.}
  
  \item{scheme}{Weighting scheme.}
}
\details{
  For maximum likelihood estimation, the variance of the estimate of
  $\beta$ (\code{post.var}) is approximated by the posterior variance of
  $\beta$ with a dispersed normal prior.
  
  The adaptive weighting scheme is given in Cheung and Chappell (2000)
  given in the reference list.
}

\references{
  Cheung, Y. K. and Chappell, R. (2000). Sequential designs for phase I
  clinical trials with late-onset toxicities.  Biometrics 56:1177-1182.
}

\examples{

# Create a simple data set
prior <- c(0.05,0.10,0.20,0.35,0.50,0.70)
target <- 0.2
level <- c(3,3,3,4,4,3,2,2,2,3)
y <- c(0,0,1,0,1,0,0,0,0,0)
u <- c(178,181,168,181,24,181,179, 102, 42, 3)
tau <- 180
foo <- titecrm(prior,target,y,level,followup=u,obswin=tau)
rec <- foo$mtd  # recommend a dose level for next patient

# An example with adaptive weight
foo2 <- titecrm(prior,target,y,level,followup=u,obswin=tau,scheme="adaptive")
wts <- foo2$weights

# The `weights' argument makes `followup' and `obswin' obsolete
foo3 <- titecrm(prior,target,y,level,weights=wts,followup=u,obswin=tau)
\dontrun{plot(foo3,ask=T)}

# Patient time information via `entry' and `exit' arguments
entry <- c(7, 29, 49, 76, 92, 133, 241, 303, 363, 402) # entry time (days since study begins)
exit <- c(185,210,217,257,116,314,420,405,405,405) # exit time (days since study begins)
foo4 <- titecrm(prior,target,y,level,exit=exit,entry=entry,obswin=tau)
\dontrun{plot(foo4,ask=T)}

}

\keyword{datasets}
