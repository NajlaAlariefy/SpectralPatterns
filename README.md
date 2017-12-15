# Pattern Detection of Single Spectra on their Multi-components


## Documentation
This is a package developed for R that will detect patterns of multi-component spectra and visualizes them for proof of concept. 

### Description
This function will take in a set of spectra (single components, and their respective multi-components) and return patterns detected based on correlation results of three extracted features (means, variance, and turn-points).

### Usage
```
spectralPatterns(spectra)
```

### Arguments
*spectralPatterns* accepts a dataframe of spectra, this version accepts three-bases only. They should be organized as follows: C1, C2, C3, C1+C2, C1+C3, C2+C3, C1+C2+C3}


## Definition & Scope
Infrared spectroscopy-the study of interaction between infrared light and matter[11]- has played an important role in the progress of biological analysis of cells in recent years. It permits the detection of molecules and their concentrations through the analysis of the spectrum. Fourier Transform Infrared spectroscopy (FTIR) is a technique of infrared spectroscopy that registers the absorption or emission of infrared light from a solid, liquid or gas with the advantages of high wavenumber precision, shorter scanning time (due to its multiplexing technique), and a high signal-to-noise ratio[11][9].  

FTIR spectroscopy is deemed a reliable tool of bio-analysis [9] mainly due to its capacity to detect signatures of the composition of the component [7], enabling the inference of components from biological samples. Despite the existence of artifacts and noise in the sample[11] it is widely used for its noninvasiveness, low cost and ease of sample preparation [2]. In recent years, FTIR has been used in many applications for detecting cancer [13] [3], classifying or exploring the bio- diversity of a sample [5] [4] (detecting healthy/diseased in citrus greening)[10], and the study of biological fluids (i.e. blood, urine, etc.)[1][8].  
Spectral searching is a powerful approach that enables the prompt recognition of a spectrum with unknown components using a database of spectra. Its goal is to analyze a given spectrum to try to determine the most similar spectra – hence discerning its most probable composition. 

[Ghada Badr and Najla Al-Ariefy. Top-Down Correlation-Based Pattern Analysis and Feature Selection for multi-component FTIR Spectra. 9h International Conference on Bioinformatics and Computational Biology (BICOB), Honolulu, Hi, USA, March 20-27, 2017.]()
## Method 
For detecting patterns made by single component spectra on their multicomponent(s) spectra, there are three main phases after data acquisition (Fig 1.): preprocessing, feature extraction, and feature selection using correlation for pattern detection.






## References

1. Brian Smith. Fundamentals of Fourier Transform Infrared Spectroscopy. CRC Press, Boca Raton, FL, 2011.
2. Halida Rahmania, Sudjadi, and Abdul Rohman. The employment of FTIR spec- troscopy in combination with chemometrics for analysis of rat meat in meatball formulation. Meat Science, 100:301–305, 2015.
3. Feride Severcan, Nihal Simsek Ozek, and Seher Gok. Fourier transform infrared spectroscopy and imaging in cancer diagnosis and characterization. Biophysical Journal, 108(2):479a–480a, 2015.
4. Alix Mignolet, Allison Derenne, Margarita Smolina, Bayden R. Wood, and Erik Goormaghtigh. FTIR spectral signature of anticancer drugs. can drug mode of action be identified? Biochimica et Biophysica Acta (BBA) - Proteins and Pro- teomics, 1864(1):85–101, 2016.
5. Jian-xiong Cai, Yuan-feng Wang, Xiong-gang Xi, Hui Li, and Xin-lin Wei. Using FTIR spectra and pattern recognition for discrimination of tea varieties. Interna- tional Journal of Biological Macromolecules, 78:439–446, 2015.
6. Udi Zelig, Eyal Barlev, Omri Bar, Itai Gross, Felix Flomen, Shaul Mordechai, Joseph Kapelushnik, Ilana Nathan, Hanoch Kashtan, and Nir et al. Wasserberg. Early detection of breast cancer using total biochemical analysis of peripheral blood components: a preliminary study. BMC Cancer, 15(1), 2015.
7. Cun-Gui Cheng, Yu-Mei Tian, and Wen-Ying Jin. A study on the early detec- tion of colon cancer using the methods of wavelet feature extraction and SVM classifications of FTIR. Spectroscopy, 22(5):397–404, 2008.
8. Kanjana Thumanu, Suleeporn Sangrajrang, Thiravud Khuhaprema, Anant Kalalak, Waraporn Tanthanuch, Siwatt Pongpiachan, and Philip Heraud. Diagno- sis of liver cancer from blood sera using FTIR microspectroscopy: a preliminary study. Journal of biophotonics, 7(3-4):222–231, 2014.
9. Ahmad Salman, Gilbert Sebbag, Shmuel Argov, Shaul Mordechai, and Ranjit K Sahu. Early detection of colorectal cancer relapse by infrared spectroscopy in normal anastomosis tissue. Journal of biomedical optics, 20(7):075007–075007, 2015.
10. Cdric Grangeteau, Daniel Gerhards, Sebastien Terrat, Samuel Dequiedt, Herv Alexandre, Michle Guilloux-Benatier, Christian Von Wallbrunn, and Sandrine Rousseaux. FT-IR spectroscopy: A powerful tool for studying the inter- and in- traspecific biodiversity of cultivable non-saccharomyces yeasts isolated from grape must. Journal of Microbiological Methods, 121:5058, 2016.
11. Cungui Cheng, Jia Liu, Wenqing Cao, Renwei Zheng, Hong Wang, and Changjiang Zhang. Classification of two species of bidens based on discrete stationary wavelet transform extraction of FTIR spectra combined with probability neural network. Vibrational Spectroscopy, 54(1):50–55, 2010.
12 -
12. Reza Sankaran, SindhujaEhsani. Visible-near infrared spectroscopy based citrus greening detection: Evaluation of spectral feature extraction techniques. Crop Protection, 30(11):1508–1513, 2011.
13. Matthew J Baker, Julio Trevisan, Paul Bassan, Rohit Bhargava, Holly J Butler, Konrad M Dorling, Peter R Fielden, Simon W Fogarty, Nigel J Fullwood, Kelly A Heys, and et al. Using fourier transform IR spectroscopy to analyze biological materials. Nat Protoc Nature Protocols, 9(8):1771–1791, Mar 2014.
14. Julian Ollesch, Margot Heinze, H. Michael Heise, Thomas Behrens, Thomas Brun- ing, and Klaus Gerwert. It’s in your blood: spectral biomarker candidates for urinary bladder cancer from automated FTIR spectroscopy. J. Biophoton., 7(3- 4):210–221, 2014.
15. Xiao-Li CHU, Jing-Yan LI, Pu CHEN, and Yu-Peng XU. Algorithms, strategies and application progress of spectral searching methods. Chinese Journal of Ana- lytical Chemistry, 42(9):1379–1386, 2014.
16. Julio Trevisan, Plamen P. Angelov, Paul L. Carmichael, Andrew D. Scott, and Francis L. Martin. Extracting biological information with computational analysis of fourier-transform infrared (FTIR) biospectroscopy datasets: current practices to future perspectives. The Analyst, 137(14):3202, 2012.
17. Meta Kokalj, Metka Rihtaric, and Samo Kreft. Commonly applied smoothing of IR spectra showed unappropriate for the identification of plant leaf samples. Chemometrics and Intelligent Laboratory Systems, 108(2):154–161, 2011.
18. Limin Gri ths, Peter R.Shao. Self-weighted correlation coe cients and their ap- plication to measure spectral similarity. Applied Spectroscopy, 63(8):916–919, 2009.
