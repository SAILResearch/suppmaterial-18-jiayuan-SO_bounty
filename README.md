# Online Appendix and Replication Package for "Bounties on Technical Q\&A Sites: A Case Study of Stack Overflow Bounties"

* [Appendix](https://github.com/SAILResearch/supportmaterial-18-jiayuan-SO_bounty/blob/master/appendix.pdf)
* Data: 
  * [data_solvingLikelihood](https://github.com/SAILResearch/supportmaterial-18-jiayuan-SO_bounty/blob/master/data_model/data_solvingLikelihood) data (r object) for studying the sovling-likelihood of bounty questions (i.e., Section  5).
  * [data_solvingLikelihood_nonBounty](https://github.com/SAILResearch/supportmaterial-18-jiayuan-SO_bounty/blob/master/data_model/data_solvingLikelihood_nonBounty) data (r object) for studying the sovling-likelihood of sampled non-bounty questions (i.e., Section 5.3).
  * [data_solvingTime](https://github.com/SAILResearch/supportmaterial-18-jiayuan-SO_bounty/blob/master/data_model/data_solvingTime) data (r object) for studying the solving-speed of bounty questions (i.e., Section 6).

Note that the r object data could be imported directly into R using the scripts we provided below. 

* Model:
  * [SolvingLikelihoodModel.R](https://github.com/SAILResearch/supportmaterial-18-jiayuan-SO_bounty/blob/master/data_model/SolvingLikelihoodModel.R) script for building the model to understand the association between the studied factors and the solving-likelihood of bounty questions (i.e., Section 5)
  * [SolvingLikelihoodNonBountyModel.R](https://github.com/SAILResearch/supportmaterial-18-jiayuan-SO_bounty/blob/master/data_model/SolvingLikelihoodNonBountyModel.R) script for building models to understand the important factors for the solving-likelihood of non-bounty and bounty questions(i.e., Section 5.3).
  * [SolvingSpeedModel.R](https://github.com/SAILResearch/supportmaterial-18-jiayuan-SO_bounty/blob/master/data_model/SolvingSpeedModel.R) script for building the model to understand the association between the studied factors and the solving-speed of bounty questions (i.e., Section 6)
