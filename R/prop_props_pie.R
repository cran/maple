#' Plot grouped pie charts of cell type proportions
#'
#' This function allows you to visualize the relative abundance of sub-populations after running fit_maple()
#' @param fit A list returned by fit_maple()
#' @param group A column name of fit$W or a grouping vector of length N (nrow(fit$W))
#'
#' @keywords spatial transcriptomics Bayesian
#' @import dplyr
#' @import ggplot2
#' @importFrom rlang .data
#' @export
#' @return A ggplot object
#' @examples 
#' \dontrun{
#' brain1 <- LoadData("stxBrain", type = "anterior1")
#' brain2 <- LoadData("stxBrain", type = "anterior2")
#' brain1 <- SCTransform(brain1, assay = "Spatial", verbose = FALSE)
#' brain2 <- SCTransform(brain2, assay = "Spatial", verbose = FALSE)
#' brain <- merge(brain1,brain2)
#' DefaultAssay(brain) <- "SCT"
#' VariableFeatures(brain) <- c(VariableFeatures(brain1),VariableFeatures(brain2))
#' brain <- RunPCA(brain)
#' brain_fit_PCs <- fit_maple(brain,K = 6,emb = "PCs")
#' plot_props_pie(brain_fit_PCs, group = brain$orig.ident)
#' } 
plot_props_pie <- function(fit, group)
{
  if(length(group) == 1)
  {
    al_df = data.frame(z = fit$z,group = fit$W[,group])
  }
  else if(length(group) == nrow(fit$W))
  {
    group = as.factor(group)
    al_df = data.frame(z = fit$z,group = group)
  }
  else
  {
    message("Error: group should be either a column name of fit$W, a column index of fit$W, or a length N categorical vector coercible to a factor.")
    return()
  }
  
  al_df_sum = al_df %>%
    group_by(.data$z,.data$group) %>%
    summarize(Freq = n())
  
  al_df_group = al_df %>%
    group_by(.data$group) %>%
    summarize(n_group = n())
  
  al_df_sum = inner_join(al_df_sum,al_df_group,by = "group") %>%
    mutate(prop = .data$Freq/.data$n_group) %>%
    mutate(z = as.factor(.data$z), group = as.factor(.data$group))
  
  g <- ggplot(al_df_sum, aes(x = "", y = .data$prop, fill = .data$z)) + 
    geom_bar(stat = "identity", width = 1, color = "black") + 
    theme_void() + 
    coord_polar("y",start = 0) + 
    facet_wrap(~group)
  
  return(g)
}