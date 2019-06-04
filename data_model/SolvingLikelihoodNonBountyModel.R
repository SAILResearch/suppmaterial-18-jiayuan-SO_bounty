source('./ModelConstruction.R')

#############################
####None-bounty questions####----
#############################

########################################
#Load data---- 
########################################
load(file = './data_solvingLikelihood_nonBounty')
d <- datadist(nonBountyPost_solving_likelihood_data)
options(datadist = "d")


########################################
###Set formular----
########################################
formular_non_bounty_solving_likelihood <-as.formula("
                             Label ~ Q_Score + Q_Favorite_num  + U_Asker_question_num  + U_Asker_answer_num + Q_URL_num  + Q_CodeSnippet_Num + Q_Body_len + Q_Code_proportion + T_Age_min + T_Age_sum + T_Age_max +  T_answerer_num_min+
                             rcs(T_solved_likeliihood_normal_min, 5)+
                             rcs(T_solved_likeliihood_normal_max, 4) + 
                             rcs(T_answerer_num_sum, 5) 
                             "
)

################################################################################
###Build one logistic regression model for the analysis of important variables----
################################################################################
set.seed(1)
nonBountyPost_solving_likelihood_fit = lrm(formular_non_bounty_solving_likelihood, data=nonBountyPost_solving_likelihood_data,x=T,y=T, se.fit=T, tol=1e-200, penalty =1)
nonBountyPost_solving_likelihood_fit_anova <- anova(nonBountyPost_solving_likelihood_fit, tol=1e-200)
nonBountyPost_solving_likelihood_fit_anova

###############################################################################
###Build 100 logistic regression models for the analysis of performance----
###############################################################################
set.seed(1)
bootsize=100
perfResult_solving_likelihood_nonBounty <-bootstrapLRM(boot=bootsize, 
                                             data=nonBountyPost_solving_likelihood_data,
                                             formula=formular_non_bounty_solving_likelihood, 
                                             cpun=20)
print(median(perfResult_solving_likelihood_nonBounty$auc))
print(median(perfResult_solving_likelihood_nonBounty$optimism))


##############################################
###Bounty questions without bounty factors####----
##############################################

########################################
#Load data---- 
########################################
load(file = '../so_publish_data/solving_likelihood_data')
d <- datadist(solving_likelihood_data)
options(datadist = "d")

################################################################################
###Build one logistic regression model for the analysis of important variables----
################################################################################
bountyPostWithoutBountyFactor_solving_likelihood_fit<- lrm(formular_non_bounty_solving_likelihood, data=solving_likelihood_data,x=T,y=T, se.fit=T, tol=1e-200, penalty =1)
bountyPostWithoutBountyFactor_solving_likelihood_fit <- anova(bountyPostWithoutBountyFactor_solving_likelihood_fit, tol=1e-200)

###############################################################################
###Build 100 logistic regression models for the analysis of performance----
###############################################################################
set.seed(1)
bootsize=100
perfResult_solving_likelihood_bountyWithoutBountyFactor <-bootstrapLRM(boot=bootsize,
                                                       data=solving_likelihood_data,
                                                       formula=formular_non_bounty_solving_likelihood,
                                                       cpun=20)
print(median(perfResult_solving_likelihood_bountyWithoutBountyFactor$auc))
print(median(perfResult_solving_likelihood_bountyWithoutBountyFactor$optimism))