---

layout: page
mathjax: true
title: Predictive distribution and CPO in bayesian statistics

tagline:
description: Pagina per tenere traccia del mio ipertesto mentale

---

Predictive distributions and Conditional Predictive Ordinates (CPO) appear in statistics for different 
reasons, the first to make predictions on future observations, the latter for checking the 
goodness of fit of a model or rather for selecting a model among many. But they share the same mathematics, and that's
why they are put together in this article. \\
In the following, we are working in a bayesian setting, that is the setting in which not only the observed data
are assumed to be randomly distributed according to a certain law that depends on some
unknown parameters, but also the parameters themselves
are randomly distributed according to a prior distribution. In this setting, statisticians "play" around 
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

$\pi(\boldsymbol{\theta}\|\mathbf{Y})$ is called the posterior distribution of $\boldsymbol\theta$.	

#### Predictions
Suppose that we have observed $n$ data $Y_1 ... Y_n$, collected in the vector $\mathbf{Y}$, and
that we are interested in deriving the distribution of a new observation
$Y_{new}$. Once we have found the distribution, it will be easy to make predictions: for example,
we can use the mean of the distribution as our guess for the value of $Y_{new}$, or choose another
criterion we think is the most suitable for the problem.\\
Using the definition of conditional probability

$$\mathcal{L}(Y_{new}|\mathbf{Y})=\frac{m(Y_{new},\mathbf{Y})}{m(\mathbf{Y})}= $$

$$\frac{\int_\boldsymbol\Theta{\mathcal{L}(Y_{new},\boldsymbol{Y}|\boldsymbol{\theta})\pi(\boldsymbol\theta)d\boldsymbol\theta}}
{m(\mathbf{Y})}$$

Since the denominator don't depend depend
on $\boldsymbol\theta$ it can be brought inside the integral.
In the case that the data are conditionally independent, that is 

$$\mathcal{L}(\mathbf{Y}|\boldsymbol{\theta})= \prod_{i=1}^n{\mathcal{L}(Y_i|\boldsymbol{\theta})}$$

the quantity above becomes

$$\int_\boldsymbol\Theta{\frac{\mathcal{L}(Y_{new}|\boldsymbol\theta)\cdot
\mathcal{L}(\boldsymbol{Y}|\boldsymbol{\theta})\pi(\boldsymbol\theta)d\boldsymbol\theta}{m(\mathbf{Y})}}$$

Applying Bayes theorem we get 

$$\mathcal{L}(Y_{new}|\mathbf{Y})=\int_\boldsymbol\Theta{\mathcal{L}(Y_{new}|\boldsymbol\theta)\cdot\pi(\boldsymbol{\theta}|\mathbf{Y})d\boldsymbol{\theta}}$$

that is the predictive distribution is the integral of the law of $Y_{new}$ given the parameters $\boldsymbol\theta$ with
respect to the posterior distribution of $\boldsymbol\theta$.

#### Conditional Predictive Ordinate


