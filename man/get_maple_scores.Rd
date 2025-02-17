% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_maple_scores.R
\name{get_maple_scores}
\alias{get_maple_scores}
\title{Get posterior probability scores}
\usage{
get_maple_scores(fit)
}
\arguments{
\item{fit}{A list returned by fit_maple()}
}
\value{
A fit object (list)
}
\description{
This function allows you to compute posterior uncertainty and continuous phenotype scores
}
\examples{
\dontrun{
brain1 <- LoadData("stxBrain", type = "anterior1")
brain2 <- LoadData("stxBrain", type = "anterior2")
brain1 <- SCTransform(brain1, assay = "Spatial", verbose = FALSE)
brain2 <- SCTransform(brain2, assay = "Spatial", verbose = FALSE)
brain <- merge(brain1,brain2)
DefaultAssay(brain) <- "SCT"
VariableFeatures(brain) <- c(VariableFeatures(brain1),VariableFeatures(brain2))
brain <- RunPCA(brain)
brain_fit_PCs <- fit_maple(brain,K = 6,emb = "PCs")
brain_fit_scores <- get_maple_scores(brain_fit_PCs)
}
}
\keyword{Bayesian}
\keyword{spatial}
\keyword{transcriptomics}
