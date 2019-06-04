source('./ModelConstruction.R')

########################################
###Load data----
########################################
load(file = './data_solvingLikelihood')
d <- datadist(solving_likelihood_data)
options(datadist = "d")


########################################
###Set formular----
########################################
formular_solving_likelihood <-as.formula("
                             Label ~ Q_Score + Q_Favorite_num + B_value + U_Asker_question_num + U_Backer_Reputation + U_Asker_answer_num + Q_URL_num + B_days_before_bounty + Q_CodeSnippet_Num + Q_Body_len + Q_Code_proportion + T_Age_min + T_Age_sum + T_Age_max + T_answerer_num_min+ Q_Answer_num+
                             rcs(B_solved_likelihood_median, 5) + 
                             rcs(T_solved_likeliihood_normal_min, 5)+
                             rcs(B_solved_likelihood_min, 4) + 
                             rcs(B_solved_likelihood_max, 4) + 
                             rcs(T_solved_likeliihood_normal_max, 4) + 
                             rcs(T_answerer_num_sum, 5) 
                             "
)

################################################################################
###Build one logistic regression model for the analysis of important variables----
################################################################################
set.seed(1)
solving_likelihood_fit = lrm(formular_solving_likelihood, data=solving_likelihood_data,x=T,y=T, se.fit=T, tol=1e-200, penalty =1)
solving_likelihood_fit_anova <- anova(solving_likelihood_fit, tol=1e-200)
solving_likelihood_fit_anova
  
###############################################################################
###Build 100 logistic regression models for the analysis of performance----
###############################################################################
bootsize=100
perfResult_solving_likelihood <-bootstrapLRM(boot=bootsize, 
                          data=solving_likelihood_data,
                          formula=formular_solving_likelihood, 
                          cpun=20)
print(median(perfResult_solving_likelihood$auc))
print(median(perfResult_solving_likelihood$optimism))



