source('./ModelConstruction.R')

########################################
####Load data---- 
########################################
load(file = './data_solvingTime')

################################################################################
###Select 20% fast-solved bounty question and 20% slow-solved bounty questions----  
################################################################################
solving_time_data<-solving_time_data[order(solving_time_data$Q_Delta_Answer_Bounty, decreasing = T), ]
partCut <- round(length(solving_time_data$Q_Delta_Answer_Bounty)/5,digits = 0)
bottom20<-solving_time_data[1:partCut,]
bottom20<-cbind(bottom20,Label=rep(0,partCut))
top20<-solving_time_data[(nrow(solving_time_data)-partCut):nrow(solving_time_data),]
top20<-cbind(top20,Label=rep(1,partCut+1))
solving_speed_data<-rbind(top20,bottom20)
solving_speed_data$Label<-as.factor(solving_speed_data$Label)

set.seed(1)
d <- datadist(solving_speed_data)
options(datadist = "d")


########################################
###Set formular----
########################################
formular_solving_time <-as.formula("
Label ~ B_value + U_Asker_question_num + U_Backer_Reputation + U_Asker_answer_num + Q_Score + Q_Favorite_num + U_Answerer_question_score_median + U_Answerer_answer_score_median + U_Answerer_qustion_num +  T_solved_likelihood_normal_max + B_solved_likelihood_max + B_solved_likelihood_median + B_solved_likelihood_min + T_answerer_num_min + T_answerer_num_sum + T_Age_min + T_Age_sum + T_Age_max + Q_URL_num + B_days_before_bounty + Q_CodeSnippet_Num + Q_Body_len + Q_Code_proportion+ Q_Answer_num+
    rcs(U_Answerer_answer_num, 4)  + 
    rcs(T_solved_likelihood_normal_min, 4) 
"
)
  

################################################################################
###Build one logistic regression model for the analysis of important variables----
################################################################################
solving_speed_fit = lrm(formular_solving_time, data=solving_speed_data,x=T,y=T, se.fit=T, tol=1e-200, penalty =1)
solving_speed_fit_anova <- anova(solving_speed_fit, tol=1e-200)
solving_speed_fit_anova

###############################################################################
###Build 100 logistic regression models for the analysis of performance----
###############################################################################
bootsize=100
perfResult_solving_speed <-bootstrapLRM(boot=bootsize, 
                          data=solving_speed_data,
                          formula=formular_solving_time, 
                          cpun=20)
print(median(perfResult_solving_speed$auc))
print(median(perfResult_solving_speed$optimism))
