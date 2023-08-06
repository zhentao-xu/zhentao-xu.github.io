---
layout: blog
title: 2022-10-04 Paper Reading - Collaboration Alert Ranking for Anomaly Detection
category: [Paper Reading, Anomaly Detection, ML Algorithm]
excerpt: Paper Reading
---


| Infomration             | Value                                                                                                                                                                                                  |
|:------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Paper Title            | [Collaborative Alert Ranking for Anomaly Detection](https://arxiv.org/abs/1612.07736)|
| Read Date                    | 2022-10-04                                                                                                                                                                    |


##### Innovation Point (Why I read this paper)
I recently found this paper as this paper's idea is interesting. The high-level idea is to collaboratively tackle the two problems collaboratively, because the solution of one problem can benefit the other (anomaly filtering clean data and get better pattern, pattern identification can help filter out isolated alerts as false positive.)
1. identify anomaly pattern (which in this paper is defined as a specific temporal sequence of alerts)
2. do anomaly filtering to reduce false alerts.

##### Terminology
- **Heterogeneous Categorical Alert**: a multi-categorical alert represented by `a=(v_1, ..., v_m, t)`, where there are totally `m` dimensions at time `t`.
- **Anomaly Pattern**: a subsequence of alerts that represent multiple steps of abnormal system activity.

##### Problem Statement
- Given multiple 'Heterogenous Caterical Alerts', aim at identifying top `K` ranked alerts that most likely to be true positives and their anomaly aptterns.

##### Methodologies - Part I: Temporal Dependency Modeling
- step-1: build the prefix tree using standard method. The prefix-tree is essentially a Trie tree made from any subsequence of a given sequence. Therefore, each note in this prefix tree is essentially a pattern.
- step-2: hierarchical Bayesian Model Learning: model the predictive distribution using Pitman-Yor prior (can also use Dirichlet priors, which is less effective by research) (The assumption is that the closer alert to current alert can impact predictive distribution more.) (**Note** I may need to search for 'Pitman-Yor process' and 'Hierarchical Bayesian Model Learning')
- step-3: Alert Pattern Searching: goal is estimating the "pattern dependency" (essentially each pattern's probability)

##### Methodoliges - Part II: Content Depency Modeling
the goal of content depency modeling is trying to estimate the similar between each pair of alerts. The approach it's taking is estimating the cosine similar between these two alerts' components' embedding vectors and estimate the alert-level similarity by summation of components' similarities. This paper propose to use the negative sampling **noise constractive estimation (NSE)** to reduce complexity, whose idea is that  instead of finding all pair of items in the denominator, it randomly sample some pairs as representatives.


##### Methodologies - Part III: Collaborative Alert Ranking
Given: 1. the alert-alert pair-wise similarity matrix S and 2. alert-pattern coincidence matrix F, and pattern confidence score `p_l`, we aim at calculating the alert confidence score `t_j` and pattern dependency strength `u_l`
How: there are 3 terms in the finalal optimization equation: 1. pattern with higher pattern termporal dependency strength are more likely to to TP (i.e. have higher `p_l` can lead to higher `u_l`) 2. similar content information --> similar alert confidence score `t_j` 3. coincidence alert and pattern should have similar confidence score.


##### My Take Away
**Pro**
1. This paper innovatively combine the two concept (temporal confidence and patern confidence) into the same optimization problem, and each problem benefit the other. 
**Cons**
1. I believe the "collaborative alert ranking" part's equiation seems purely based on manual definition and this formula's format is a rule-based formula, making it easy to lead to bias. 
