1. What should we be considering when selecting appropriate covariates to generate propensity scores?
Solution: 
  A Propensity score is the probablity that a participant would be assigned to a perticular study group based ona set of covariates, But most often, propensity scores are estimated
as teh likelihood that a person woould be assigned ot self-selct into a treatement condition. As probabilites, propensit scores range from 0 to 1 ( scores above 0.5 predict that a 
participant will be in the treatment groiup, and those below 0.5 predict that a participant will be in the control or comparision group. 
  1.	Firstly, we need to get the data ready:
    a.	Select relevant covariates (True Confounders and Outcome Proxies).
    b.	Decide how to deal with missing data (imputation or removal)
    c.	Understand if a complex sampling method was used and adjust as necessary.
  2.	Then we need to determine the appropriate method for calculating our propensity scores (logit regression and beyond).
  3.	Once we have propensity scores we decide how to minimize the imbalance in covariates:
    a.	Matching ( which pairs participants from treatment and control groups based on the Proximity of thier Propensity scores)
    b.	Stratification or (Sub-Classification) (which groups participants who are matched on severalstrta based on thier propensity scores)
    c.	Weighting (which multiplies outcome observations by a weight based on the propensity score)
    d.  Covariate adjustment (which uses propensity scores as a covariate in a ANCOVA or regression)
  4.	We then estimate the treatment effect (must select appropriate analysis technique).
  5.	Lastly we should perform sensitivity analysis to see how big of an exclusion we would have had to make to change the treatment effects significance.

  
  
2. Conceptually, what is the problem with comparison of groups when assignment to the groups was not random?
Solution:
  When assignment to the groups was not random,  however, the resulting groups are likely to be dissimilar in some ways. For example, if participants self-select into treatment grop,
  They may be more motivated, more conscientious, or more ambitious than those in teh control group. When participants are randomly assigned to groups, this bias
  usually reduced. On ecpectations, participants who are randomly assigned will have similar distribution of characteristics between teh froups(i.e., those in teh control group are just 
  ust as motivated, conscientious, and ambitious as those in teh treatment group. 
  
  when assignment to the groups was not random, the covariantes are not balanced, as is often the case in teh observation studies, the preexisting differences between the groups may be 
  responsible for any differences that we see in teh outcome variables, resulting ina spurious treatment effect. 
  For example, Let’s compare two scenarios involving our hypothetical vitamin study. We’ll assume that the study obtains statistically significant results.
  When the assignment of groups are not random, subjects with healthier habits disproportionately end up in the supplement treatment group. The experimental groups differ by both healthy habits 
  and vitamin consumption. Consequently, we can’t determine whether it was the habits or vitamins that improved the outcomes.
  

  3. Describe a few matching methods and indicate what we hope to find once we have performed matching.
  solution:
    a.	Greedy matching – attempts to match to nearest neighbor without accounting for aggregate match quality and we can control matching in a few ways:
    with or without replacement/One-to-one or many to one / Nearest neighbor with/out caliper (constraint)
  b.	Genetic matching – attempts to balance covariates after matching and can be done without a PS being estimated first using the covariates alone.
  c.	Optimal matching – attempts to match to nearest neighbor while accounting for the aggregate match quality.
  d.	Full matching – forces matches between each observation in each group allowing for multiple matches (results in no data loss).