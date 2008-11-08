\name{crm}
\alias{crm}
\alias{plot.mtd}
\alias{print.mtd}
\alias{crmh}
\alias{crmhlgt}
\alias{lcrm}
\alias{lcrmlgt}
\alias{myjitter}
\alias{vcrm}
\alias{vcrmlgt}

\title{Executing the CRM}
\description{
  \code{crm} is used to compute a dose for the next patient in a phase I
  trial according to the CRM.
}

\usage{
crm(prior, target, tox, level, n = length(level), dosename = NULL, 
    include = 1:n, pid = 1:n, conf.level = 0.9, method = "bayes", 
    model = "empiric", intcpt = 3, scale = sqrt(1.34), model.detail = TRUE, 
    patient.detail = TRUE, var.est = TRUE) 
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

  \item{dosename}{A vector containing the names of the regimens/doses
    used.  The length of \code{dosename} must be equal to that of
    \code{prior}.}
  
  \item{include}{A subset of patients included in the dose calculation.}
  
  \item{pid}{Patient ID provided in the study.  Its length must be equal
    to that of \code{level}.}

  \item{conf.level}{Confidence level for the probability/confidence
    interval of the returned dose-toxicity curve.}
 
  \item{method}{A character string to specify the method for parameter
    estimation.  The default method ``bayes'' estimates the model
    parameter by the posterior mean.  Maximum likelihood estimation
    is specified by ``mle''.}

  \item{model}{A character string to specify the working model used in
    the method.  The default model is ``empiric''.  A one-parameter
    logistic model is specified by ``logistic''.}

  \item{intcpt}{The intercept of the working logistic model.  The
    default is 3.  If \code{model}=``empiric'', this argument will be
    ignored.}

  \item{scale}{Standard deviation of the normal prior of the model
    parameter.  Default is sqrt(1.34).}

  \item{model.detail}{If FALSE, the model content of an ``mtd'' object
    will not be displayed.  Default is TRUE.}
  
  \item{patient.detail}{If FALSE, patient summary of an ``mtd'' object
    will not be displayed.  Default is TRUE.}
  
  \item{var.est}{If TRUE, variance of the estimate of the model parameter and
    probability/confidence interval for the dose-toxicity curve will be
    computed }
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

}

\details{
  For maximum likelihood estimation, the variance of the estimate of
  $\beta$ (\code{post.var}) is approximated by the posterior variance of
  $\beta$ with a dispersed normal prior.

  The empiric model is specified as $F(d, \beta) = d^{\exp(\beta)}$.
  The logistic model is specified as logit$(F(d,\beta))$ = \code{intcpt}
  $+ \exp(\beta) \times d$.  For method=\code{bayes}, the prior on
  $\beta$ is normal with mean 0.  Exponentiation of $\beta$ ensures an
  increasing dose-toxicity function.
  }

\references{
  O'Quigley, J. O., Pepe, M., and Fisher, L. (1990).  Continual
  reassessment method: A practical design for phase I clinical trials in
  cancer.  Biometrics 46:33-48.
}

\examples{

# Create a simple data set
prior <- c(0.05,0.10,0.20,0.35,0.50,0.70)
target <- 0.2
level <- c(3,4,4,3,3,4,3,2,2,2)
y <- c(0,0,1,0,0,1,1,0,0,0)
foo <- crm(prior,target,y,level)
ptox <- foo$ptox  # updated estimates of toxicity rates

}

\keyword{datasets}
