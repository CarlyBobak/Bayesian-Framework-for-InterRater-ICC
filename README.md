# Bayesian-Framework-for-InterRater-ICC
A Bayesian framework for eastimating the inter-rater intra-class correlation coefficient for applications which violate c
ommon assumptions, such as constant variance and study homogeneity.

Note, users will need to download and install JAGS prior to running the framework. For more information regarding the framework methodology,
see our publication entitled Estimation of an inter-rater intra-class correlation coeff cient that overcomes common assumption
violations in the assessment of health measurement scales (publication pending).

To run using our simulated data, start with the R file, and set to your desired working directory. Results should be similar to 
the following:

              mean      lower.bound  upper.bound
ICC.1.    0.217056351  0.1617168447  0.277365530
ICC.2.    0.348962017  0.2355753270  0.530832646
ICC.3.    0.238718787  0.1677602463  0.317530321
be.1.     0.186458404  0.1117214871  0.273445710
be.2.    -0.061140026 -0.0665353420 -0.055754549
be.3.     0.226115726  0.2170482607  0.235257923
sigma.1.  0.017282665  0.0154101607  0.019376120
sigma.2.  0.146974218  0.1281887860  0.168189343
sigma.3.  0.019640983  0.0170851967  0.022620404
tau.1.    0.001149735  0.0008390548  0.001515092
tau.2.    0.017581291  0.0111001046  0.027382321
tau.3.    0.001486164  0.0010083532  0.002092642
taustudy  0.007329847  0.0002915462  0.038408723

For implementation with your own application, you'll need to update the model in the BUGS file. This can be done in R, or any other
text editor.

Forward any questions to either Carly.A.Bobak.GR@dartmouth.edu orJames.OMalley@dartmouth.edu
