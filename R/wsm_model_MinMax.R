# Apply the benfical and nonbenfical functions to the correct criteria  
# =============================================================================
# wsm_model.R
# =============================================================================
# Purpose: The Weighted Sum Model (WSM) uses given weights and criteria to evaluate the best decisions for each row. 
#
# Expects: Each row is given a score based on the criteria and weights provided.
#
# Outside this function: The data frame must already contain columns with the criteria in numeric form. 
# Each row represents an observation / individual dam.  
# 
# Required packages: This model uses base R. 
#
# Inline comments: plain-language walkthrough for explaining to a team what each
# step does and why.
# =============================================================================
#' Weighted Sum Model (WSM) for Dam Prioritization
#'
#' Scores and ranks alternatives using a Weighted Sum Model (WSM). Each criterion
#' is Min-Max normalized according to its type, multiplied by its assigned weight,
#' and summed to produce a composite score for each observation.
#'
#' @param dataset A dataframe containing the alternatives to be scored.
#' @param criteria A character vector of column names in \code{dataset} to use as criteria.
#' @param criteria_weights A named numeric vector of weights for each criterion. Must sum to 1.
#' @param criteria_type A named list indicating the type of each criterion.
#'   Accepted values are \code{"beneficial"} (higher values indicate better outcomes)
#'   or \code{"nonbeneficial"} (lower values are preferable).
#'
#' @return The input \code{dataset} with two additional columns:
#'   \describe{
#'     \item{wsm_scores}{A numeric composite score between 0 and 1 for each observation.}
#'     \item{score_letter}{A letter grade (A–D) based on fixed score thresholds:
#'       A (> 0.75), B (0.50–0.75), C (0.25–0.50), D (0–0.25).}
#'   }
#'
#' @examples
#' wsm_model(
#'   dataset = future_dams,
#'   criteria = c("csi", "n_protected_areas", "distance_downstream"),
#'   criteria_weights = c(csi = 0.5, n_protected_areas = 0.3, distance_downstream = 0.2),
#'   criteria_type = list(csi = "beneficial", n_protected_areas = "non-beneficial",
#'                        distance_downstream = "beneficial")
#' )


wsm_model_MinMax <- function(dataset, criteria, criteria_weights, criteria_type) {
  
  # Validate weights 
  if (abs(sum(criteria_weights) - 1) > 1e-9) {stop("Criteria weights must sum to 1.")}
  #if (abs(sum(criteria_weights) != 1)) {stop("Criteria weights must sum to 1.")}
  
  # --- Filter for columns inputted as criteria --- 
  dataset_filter <- dataset %>% select(any_of(criteria))
  
  # ---- Min-Max Normalize data ---- 
  
  # Beneficial and Non beneficial functions
  min_max_ben <- function(x) {
    norm = (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
    return(norm)
  }
  
  min_max_NONben <- function(x) {
    norm = (max(x, na.rm = TRUE) - x) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
    return(norm)
  }
  
  
  # Apply the benfical and nonbenfical functions to the correct criteria  
  for (i in names(criteria_type)) {
    if (criteria_type[[i]] == "beneficial") {
      dataset_filter[[i]] <- min_max_ben(dataset_filter[[i]])
    } else {
      dataset_filter[[i]] <- min_max_NONben(dataset_filter[[i]])
    }
  }
  
  #---- Calculate weighted sum scores --- 
  #wsm_scores <- rowSums(criteria_weights * dataset_filter) # dataset_filter might NOT align with criteria_weights
  wsm_scores <- rowSums(mapply(function(col, w) # iterating over each column (c) of dataset_filter & its corresponding weight
    col * w, dataset_filter, # multiply column & its matching weight 
    criteria_weights[names(dataset_filter)])) # reorders the weights vectors to match dataset_filter order, so everything get multi correctly
  
  # Add scores to dataset 
  dataset$wsm_scores <- wsm_scores
  
  
  # Add letters 
  dataset <- dataset %>% 
    mutate(score_letter = case_when(
      between(wsm_scores, 0, 0.25) ~ 'D',
      between(wsm_scores, 0.25, 0.50) ~ 'C',
      between(wsm_scores, 0.50, 0.75) ~ 'B',
      wsm_scores > 0.75 ~ 'A',
      TRUE ~ NA))
  
  # dataset <- dataset %>% 
  #   mutate(
  #     quartile = ntile(wsm_scores, n = 5), # Higher groups better 
  #     quartile_label = case_when( # Add letters based on quartiles 
  #       quartile == 1 ~ "F", 
  #       quartile == 2 ~ "D",
  #       quartile == 3 ~ "C",
  #       quartile == 4 ~ "B", 
  #       quartile == 5 ~ "A"
  #     )
  #   ) %>% 
  #   select(!quartile) # Remove this column 
  
  # return the dataset 
  
  return(dataset)
  
}
