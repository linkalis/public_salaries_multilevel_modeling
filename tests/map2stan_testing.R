library(rethinking)
library(rstan)
data(reedfrogs)
d <- reedfrogs

d$tank <- 1:nrow(d)


dat <- list( S = d$surv, N=d$density, tank = d$tank)

m13.1 <- ulam(
  alist(
    S ~ dbinom(N, p),
    logit(p) <- a[tank],
    a[tank] ~ dnorm(0, 1.5)
  ), data=dat, chains=4, log_lik = TRUE
)

precis(m13.1, depth=2)



# 1) Mess around with R 4.0 for a while, then realize it's missing the a library called:
# /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libc++abi.1.dylib 
# 2) Give up, and install R 3.6.3 instead of 4.0
# 3) Follow these instructions to install rstan: https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
# 4) It worked!




# Fix involved:
# Update old Xcode: https://stackoverflow.com/questions/12444656/error-during-xcode-component-installation

# https://discourse.mc-stan.org/t/error-in-sink-type-output-invalid-connection/8911/5
# https://discourse.mc-stan.org/t/error-bug-in-brms-models/6276/42
# https://discourse.mc-stan.org/t/dealing-with-catalina-ii/11802/60

# Install Rcpp:
# install.packages("Rcpp", repos = "https://rcppcore.github.io/drat")

# Try installing from source: 
# https://github.com/stan-dev/rstan/wiki/Installing-RStan-from-source-on-a-Mac#prerequisite--c-toolchain-and-configuration
# don't worry about warnings that show up

# Get an error, then do this to fix the MacOS header files:
# https://donatstudios.com/MojaveMissingHeaderFiles
# sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /

# Remove the StanHeaders package from R by clicking the "X" icon next to it in the Packages window

# Try this version of the R toolchain instead:
# https://github.com/rmacoslib/r-macos-rtools/releases/tag/v3.2.1
# Check that /linkalis/.r/Makevars shows the settings in the thread

# libc++abi.1.dylib is missing from R 4.0, but not 3.5. Look in:
# /Library/Frameworks/R.framework/Versions/4.0/Resources/lib
# /Library/Frameworks/R.framework/Versions/3.5/Resources/lib

# To fix this, let's try: 
# https://thecoatlessprofessor.com/programming/cpp/r-compiler-tools-for-rcpp-on-macos/
# https://github.com/stan-dev/rstan/wiki/Using-RStan-with-the-R-4.0-Prerelease-on-Windows