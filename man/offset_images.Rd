% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/offset_images.R
\name{offset_images}
\alias{offset_images}
\title{Offset multiple Seurat images}
\usage{
offset_images(seurat_obj)
}
\arguments{
\item{seurat_obj}{A Seurat object}
}
\value{
A coordinate data frame
}
\description{
Internal function for defining coordinates with from multi-sample Seurat objects
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
brain <- offset_images(brain)
}

}
\keyword{Bayesian}
\keyword{spatial}
\keyword{transcriptomics}
