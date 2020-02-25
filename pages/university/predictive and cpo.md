---

layout: page
mathjax: true
title: Predictive distribution and CPO in Bayesian statistics

tagline:
description: Predictive distribution, Conditional Predictive Ordinate (CPO), log pseudo marginal likelihood (LPML) in Bayesian statistics

---

Predictive distributions and Conditional Predictive Ordinates (CPO) appear in statistics for different 
reasons, the first to make predictions on future observations, the latter for checking the 
goodness of fit of a model or rather for selecting a model among many. But they share the same mathematics, and that is
why they are put together in this article. \\
In the following, we are working in a Bayesian setting, that is the setting in which not only the observed data
are assumed to be randomly distributed, according to a certain law, which depends on some
unknown parameters, but also the parameters themselves
are randomly distributed according to a (prior) distribution. In this setting, statisticians "play" around 
the joint distribution of the data and the parameters. Let's see a little bit how.

##### Notation
- $\pi(\boldsymbol{\theta})$ prior distribution for the unknown
 vector of parameters $\boldsymbol{\theta}$
- $\mathbf{Y}$ vector of observed data
- $\mathcal{L}(\mathbf{Y}|\boldsymbol{\theta})$ law of the data $\mathbf{Y}$
given the parameters $\boldsymbol{\theta}$
- $m(\mathbf{Y})$ the marginal law of
$\mathbf{Y}$, that is the law of the data when the parameters of the model get integrated out

$$m(\mathbf{Y})=\int_\boldsymbol\Theta{\mathcal{L}(\boldsymbol{Y}|\boldsymbol{\theta})\pi(\boldsymbol\theta)d\boldsymbol\theta}$$

#### Bayes theorem
Similarly to the Bayes formula for discrete probabilities that is taught in every course in probability, it is
possible to prove that the following formula holds

$$ \pi(\boldsymbol{\theta}|\mathbf{Y})= \frac{\mathcal{L}(\mathbf{Y}|\boldsymbol{\theta})\cdot\pi(\boldsymbol{\theta})}
{m(\mathbf{Y})} $$

At the numerator above you can see the joint law of the data and the parameter. $\pi(\boldsymbol{\theta}\|\mathbf{Y})$ is called the posterior distribution of $\boldsymbol\theta$.	

#### Predictions
Suppose that we have observed $n$ data $Y_1 ... Y_n$, collected in the vector $\mathbf{Y}$, and
that we are interested in deriving the distribution of a new observation
$Y_{new}$. Once we have found the distribution, it will be easy to make predictions: for example,
we can use the mean of the distribution as our guess for the value of $Y_{new}$, or choose the
criterion which we think is the most suitable for the problem.\\
Using the definition of conditional probability

$$\mathcal{L}(Y_{new}|\mathbf{Y})=\frac{m(Y_{new},\mathbf{Y})}{m(\mathbf{Y})}= $$

$$\frac{\int_\boldsymbol\Theta{\mathcal{L}(Y_{new},\boldsymbol{Y}|\boldsymbol{\theta})\pi(\boldsymbol\theta)d\boldsymbol\theta}}
{m(\mathbf{Y})}$$

Since the denominator do not depend
on $\boldsymbol\theta$ it can be brought inside the integral.
In the case that the data are conditionally independent, that is 

$$\mathcal{L}(Y_{new},\mathbf{Y}|\boldsymbol{\theta})= \mathcal{L}(Y_{new}|\boldsymbol\theta)\cdot\prod_{i=1}^n{\mathcal{L}(Y_i|\boldsymbol{\theta})}$$

the quantity above becomes

$$\int_\boldsymbol\Theta{\frac{\mathcal{L}(Y_{new}|\boldsymbol\theta)\cdot
\mathcal{L}(\boldsymbol{Y}|\boldsymbol{\theta})\pi(\boldsymbol\theta)d\boldsymbol\theta}{m(\mathbf{Y})}}$$

Applying Bayes theorem we get 

$$\mathcal{L}(Y_{new}|\mathbf{Y})=\int_\boldsymbol\Theta{\mathcal{L}(Y_{new}|\boldsymbol\theta)\cdot\pi(\boldsymbol{\theta}|\mathbf{Y})d\boldsymbol{\theta}}$$

that is the predictive distribution is the integral of the law of $Y_{new}$ given the parameters $\boldsymbol\theta$ with
respect to the posterior distribution of $\boldsymbol\theta$.

#### Conditional Predictive Ordinate and Log Pseudo Marginal Likelihood 

The Conditional Predictive Ordinate (CPO) is based on the idea that is behind leave-one-out cross-validation: it is in fact the likelihood of observing one
datum $Y_i$ having observed all the remaining data, indicated by $\mathbf{Y_{-i}}$. In formula

$$CPO_i = \mathcal{L}(Y_i|\mathbf{Y_{-i}})$$

By summing over all the values of $i$ it is possible to get an indication of how coherent our model is with the data that have been observed. More commonly
it is used the sum of the logarithms of the CPO, the so-called Log Pseudo Marginal Likelihood (LPML).

Again, using the definition of conditional probability, $CPO_i$ can be written as

$$CPO_i =\mathcal{L}(Y_{i}|\mathbf{Y_{-i}})=\frac{m(\mathbf{Y})}{m(\mathbf{Y_{-i}})}$$

Again, with the hypothesis of conditional independence of the data, we get

$$CPO_i =\frac{\int_\boldsymbol\Theta{\prod_{j}{\mathcal{L}(Y_j)}\cdot\pi(\boldsymbol\theta)d\boldsymbol\theta}}{\int_\boldsymbol\Theta{\prod_{j\ne i}{\mathcal{L}(Y_j)}\cdot\pi(\boldsymbol\theta)d\boldsymbol\theta}}$$

A possible trick to estimate this integrals is considering the reciprocal of the $CPO_i$.

$$\frac{1}{CPO_i}=\frac{\int_\boldsymbol\Theta{\prod_{j\ne i}{\mathcal{L}(Y_j)}\cdot\pi(\boldsymbol\theta)d\boldsymbol\theta}}{\int_\boldsymbol\Theta{\prod_{j}{\mathcal{L}(Y_j)}\cdot\pi(\boldsymbol\theta)d\boldsymbol\theta}}$$

Again, the quantity at the denominator does not depend on $\boldsymbol\theta$ and can be brought inside the integral. Moreover, multiplying and dividing by
$\mathcal{L}(Y_i|\boldsymbol\theta)$ and finally applying again Bayes theorem we get

$$\int_\boldsymbol\Theta{\frac{\prod_{j}{\mathcal{L}(Y_j)}\cdot\pi(\boldsymbol\theta)d\boldsymbol\theta}{\mathcal{L}(Y_i|\boldsymbol\theta)\cdot\int_\boldsymbol\Theta{\prod_{j}{\mathcal{L}(Y_j)}\cdot\pi(\boldsymbol\theta)d\boldsymbol\theta}}}=
\int_\boldsymbol\Theta{\frac{\pi(\boldsymbol\theta|\mathbf{Y})d\boldsymbol\theta}{\mathcal{L}(Y_i|\boldsymbol\theta)}}$$

At this point, using the Monte Carlo (Markov chain) method, having at disposal $m$ simulated values 
$\theta_1 ... \theta_m$ from the posterior distribution $\pi(\boldsymbol\theta\|\mathbf{Y})$ , the estimate $\widehat{CPO}_i$ for the $CPO_i$ will be

$$\widehat{CPO}_i = \frac{1}{\frac{1}{m}\cdot\sum_{j=1}^m{\frac{1}{\mathcal{L}(Y_i|\boldsymbol\theta_j)}}}$$

Summing over $i$ the logarithm of this quantity allows us to compute the LPML. The value of the LPML is not particularly meaningful *per se*, but
if we are asked to choose between two or more possible models, the one with the highest LPML will be the best.