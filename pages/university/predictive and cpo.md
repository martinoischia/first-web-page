---

layout: page
mathjax: true
title: Predictive distribution and CPO in bayesian statistics

tagline:
description: Pagina per tenere traccia del mio ipertesto mentale

---

Predictive distribution and Conditional Predictive Ordinate (CPO), appear in statistics for different 
reasons, the first one to make predictions on a future observation, the latter for checking the 
goodness of fit of a model or rather for selecting a model among many. But they share the same mathematics, and that's
why they are put together in this article. \\
In the following, we are working in a bayesian setting, that is the setting in which not only the observed data
are assumed to have a random distribution that depends on a set of parameters, but also the parameters themselves
are randomly distributed according to a prior distribution; in this way, bayesian statisticians "play" around 
the joint distribution of the data and the parameters.\\
Let's suppose we have observed n data $Y_1 ... Y_n$ and we want to derive the distribution of a new observation,
$Y_{new}$. We denote with $\mathbf{Y}$ the vector of observed data and with $m$ the marginal law of
this data, that is the law of the data when the parameters of the model get integrated out:
$$m(mathbf{Y})=\int


For univariate y the function implements both a location and location-scale mixture model. The former assumes

$$\tilde f(y) = \int φ(y; μ, σ^2) \tilde p (d μ) π(σ^2),
$$
where φ(y; μ, σ^2) is a univariate Gaussian kernel function with mean μ and variance σ^2, and π(σ^2) is an inverse gamma prior. The base measure is specified as

P_0(d μ) = N(d μ; m0, s20),

and σ^2 ~ IGa(a0, b0). Optional hyperpriors for the base measure's parameters are

(m0,s20) ~ N(m1, s20 / k_1) IGa(a1, b1).

The location-scale mixture model, instead, assumes

$$ \tilde f(y) = \int φ(y; μ, σ^2) \tilde p (d μ, d σ^2)
$$
with normal-inverse gamma base measure

P_0 (d μ, d σ^2) = N(d μ; m0, σ^2 / k0) IGa(d σ^2; a0, b0)

and (optional) hyperpriors

m0 ~ N(m1, σ12 ), k0 ~ Ga(τ1, ζ2), b0 ~ Ga(a1, b1).


Multivariate data

For multivariate y (p-variate) the function implements a location mixture model (with full covariance matrix) and two different location-scale mixture models, with either full or diagonal covariance matrix. The location mixture model assumes
$$
\tilde f(y) = \int φ_p(y; μ, Σ) \tilde p (d μ) π(Σ)
$$
where φ_p(y; μ, Σ) is a p-dimensional Gaussian kernel function with mean vector μ and covariance matrix Σ. The prior on Σ is inverse Whishart with parameters Σ_0 and ν_0, while the base measure is

P_0 (d μ) = N(d μ; m0, S0),

with optional hyperpriors

m0 ~ N(m1, S0 / k1), S0 ~ IW(λ1, Λ1).

The location-scale mixture model assumes
$$
\tilde f(x) = \int φ_p(y; μ, Σ) \tilde p (d μ, d Σ).
$$
Two possible structures for Σ are implemented, namely full and diagonal covariance. For the full covariance mixture model, the base measure is the normal-inverse Wishart

P_0 (d μ, d Σ) = N(d μ; m0, Σ / k0) IW(d Σ; ν, Σ0),

with optional hyperpriors

m_0 ~ N(m1, S12), k0 ~ Ga(τ1, ζ1), b_0 ~ W(ν1, Σ1).

The second location-scale mixture model assumes a diagonal covariance structure. This is equivalent to write the mixture model as a mixture of products of univariate normal kernels, i.e.
$$
\tilde f(y) = \int ∏_{r=1}^p φ(y_r; μ_r, σ^2_r) \tilde p (d μ_1,…,d μ_p, d σ_1^2,…,d σ_p^2).
$$
For this specification, the base measure is assumed defined as the product of p independent normal-inverse gamma distributions, that is
$$
P_0 = ∏_{r=1}^p P_{0r}
$$
where
$$
P_{0r}(d μ_r, d σ_r^2) = N(d μ_r; m_{0j}, σ^2_r / k_{0r}) Ga(d σ^2_r; a_{0r}, b_{0r}).
$$
Optional hyperpriors can be added, and, for each component, correspond to the set of hyperpriors considered for the univariate location-scale mixture model.