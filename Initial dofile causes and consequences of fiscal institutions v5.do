
import excel "D:\Forskning og undervisning\Ph.d\Causes and Consequences of Expenditure Rules\Causes\Comparative European Politics\Revision\World 1975-2017 v. sovereign debt_rettet.xlsx", sheet("Sheet1") firstrow

destring *, replace

*Generation of central explanatory variables* 
*Generation of log of GDP per capita*
generate loggdpcap= log(gdppercapitaconstant2010US)

*Generation of number of parties*

*Existence of 2. government party*
generate egovparty2=0
replace egovparty2=1 if gov2seat !=.

*Existence of 3. government party*
generate egovparty3=0
replace egovparty3=1 if gov3seat !=.


*Existence of 1. opposition party*
generate eoppparty1=0
replace eoppparty1=1 if opp1seat !=.

*Existence of 2. opposition party*
generate eoppparty2=0
replace eoppparty2=1 if opp2seat !=.

*Existence of 1. opposition party*
generate eoppparty3=0
replace eoppparty3=1 if opp3seat !=.



*Total number of parties (treats independent legislators as parties)*
generate totalnumberofparties= 1+egovparty2 + egovparty3 + eoppparty1 + eoppparty2 + eoppparty3 + govoth + oppoth + ulprty



*Generation of chiefexecutiveelection dummy*
generate chiefexecutiveelection=0
replace chiefexecutiveelection=1 if presidentialsystem==0 & legelec==1
replace chiefexecutiveelection=1 if presidentialsystem==1 & exelec==1
replace chiefexecutiveelection=. if legelec==. | exelec==. 


*Generation of fiscal rules variables* 

*Generation of dummy for expenditure rule with statuary or constitutional basis*
generate statconER=0
replace statconER=1 if er== 1 & legal_n_er==3 |er== 1 & legal_n_er==5
replace statconER=. if er==.

*Generation of dummy for revenue rule with statuary or constitutional basis*
generate statconRR=0
replace statconRR=1 if rr== 1 & legal_n_rr==3 |rr== 1 & legal_n_rr==5
replace statconRR=. if rr==.

*Generation of dummy for balanced budget rule with statuary or constitutional basis*
generate statconBBR=0
replace statconBBR=1 if bbr== 1 & legal_n_bbr==3 |bbr== 1 & legal_n_bbr==5
replace statconBBR=. if bbr==.



*Generation of dummy for debt rule with statuary or constitutional basis*
generate statconDR=0
replace statconDR=1 if dr== 1 & legal_n_dr==3 |dr== 1 & legal_n_dr==5
replace statconDR=. if dr==.

encode countrycode, gen(countrycode_n)

xtset countrycode_n year

*Generation of reform expenditure rule*
generate reformER=0
replace reformER=1 if statconER==1 & l1.statconER==0
replace reformER=. if statconER==.

*Generation of reform revenue rule*
generate reformRR=0
replace reformRR=1 if statconRR==1 & l1.statconRR==0
replace reformRR=. if statconRR==.

*Generation of reform balance budget rule*
generate reformBBR=0
replace reformBBR=1 if statconBBR==1 & l1.statconBBR==0
replace reformBBR=. if statconBBR==.

*Generation of reform debt rule*
generate reformDR=0
replace reformDR=1 if statconDR==1 & l1.statconDR==0
replace reformDR=. if statconDR==.


*Generation of non-expenditure rule years. Some countries with problems*
generate nonERyears=.
replace nonERyears= year-1984 if statconER==0
replace nonERyears= 0 if statconER==1
replace nonERyears= year-1984 if statconER==1 & l.statconER==0

generate nationalfiscalreform=0
replace nationalfiscalreform=1 if reformER==1 | reformRR==1 | reformBBR==1 | reformDR==1
replace nationalfiscalreform=. if reformER==. | reformRR==. | reformBBR==. | reformDR==.




*Generation of IMF national expenditure rules index* 
*Rescale cover of expenditure rule*
generate cover_n_er2= cover_n_er/2

*Rescale legal scope of expenditure rule*
generate legal_n_er2= legal_n_er/5

*generation of Expenditure rules strenght index* 
generate ER_n_strengh = cover_n_er2 + legal_n_er2 + enforce_n_er + suport_ceil_n_a + frl + suport_budg_n + suport_impl_n


*Rescale cover of revenue rule*
generate cover_n_rr2= cover_n_rr/2

*Rescale legal scope of revenue rule*
generate legal_n_rr2= legal_n_rr/5

*generation of revenue rules strenght index*
generate RR_n_strengh= cover_n_rr2 + legal_n_rr2 + enforce_n_rr + frl + suport_budg_n + suport_impl_n

*Rescale cover of balanced budget rule*
generate cover_n_bbr2=cover_n_bbr/2

*Rescale legal scope of balanced budget rule*
generate legal_n_bbr2= legal_n_bbr/5

*generation of balanced budget rules strenght index*
generate BBR_n_strengh= cover_n_bbr2 + legal_n_bbr2 + enforce_n_bbr + suport_ceil_n_a + frl + suport_budg_n + suport_impl_n

*Rescale cover of debt rule*
generate cover_n_dr2= cover_n_dr/2

*Rescale legal scope of debt rule*
generate legal_n_dr2= legal_n_dr/5

*generation of debt rule strenght index*
generate DR_n_strengh= cover_n_dr2 + legal_n_dr2 + enforce_n_dr + suport_ceil_n_a + frl + suport_budg_n + suport_impl_n


*Generation of overal fiscal rules index*
generate nationalfiscalrulesindex=((DR_n_strengh*5/7) + (BBR_n_strengh*5/7) + (RR_n_strengh*5/6) + (ER_n_strengh*5/7))/4


*Generation of majority government dummy*
generate majoritygov=0
replace majoritygov=1 if maj>0.5
replace majoritygov=. if maj==.

*Generation of singlepartygovernment dummy*
generate singlepartygov=0
replace singlepartygov= 1 if herfgov==1
replace singlepartygov=. if herfgov==.

*generation of "strong government" dummy*
generate stronggov=0
replace stronggov= 1 if singlepartygov==1 & majoritygov==1
replace stronggov=. if singlepartygov==. | majoritygov==. 



*Generation of national fiscal rules in place*
generate nationaler=0
replace nationaler=1 if er==1 & er_supra!=2
replace nationaler=. if er==. 

generate nationalrr=0
replace nationalrr=1 if rr==1 & rr_supra!=2
replace nationalrr=. if rr==. 

generate nationalbbr=0
replace nationalbbr=1 if bbr==1 & bbr_supra!=2
replace nationalbbr=. if bbr==. 

generate nationaldr=0
replace nationaldr=1 if dr==1 & dr_supra!=2
replace nationaldr=. if dr==. 


generate nationalfiscalrule=0
replace nationalfiscalrule=1 if nationaler==1 | nationalrr==1 | nationalbbr==1 | nationaldr==1
replace nationalfiscalrule=. if year<1985 | year>2015


*Reform all types of national fiscal rules* 
*Generation of reform expenditure rule*
generate reformER2=0
replace reformER2=1 if nationaler==1 & l1.nationaler==0
replace reformER2=. if nationaler==.

*Generation of reform revenue rule*
generate reformRR2=0
replace reformRR2=1 if nationalrr==1 & l1.nationalrr==0
replace reformRR2=. if nationalrr==.

*Generation of reform balance budget rule*
generate reformBBR2=0
replace reformBBR2=1 if nationalbbr==1 & l1.nationalbbr==0
replace reformBBR2=. if nationalbbr==.

*Generation of reform debt rule*
generate reformDR2=0
replace reformDR2=1 if nationaldr==1 & l1.nationaldr==0
replace reformDR2=. if nationaldr==.

generate nationalfiscalreform2=0
replace nationalfiscalreform2=1 if reformER2==1 | reformRR2==1 | reformBBR2==1 | reformDR2==1
replace nationalfiscalreform2=. if reformER2==. | reformRR2==. | reformBBR2==. | reformDR2==.




*Merging with Fiscal Space Dataset 
rename countrycode ccode 
merge 1:1 ccode year using "D:\Forskning og undervisning\Ph.d\Causes and Consequences of Expenditure Rules\Causes\Comparative European Politics\Revision\Fiscal-space-data.dta"

drop _merge 


* Merging with updated Democracy and development dataset*
rename ccode countrycode 
merge 1:1 countrycode year using "D:\Forskning og undervisning\Ph.d\Causes and Consequences of Expenditure Rules\Causes\Submission International Interactions\Revision\New dataset\D&D_updated.dta"

drop _merge 

*Merging with crises dataaset*

merge 1:1 countrycode year using "D:\Forskning og undervisning\Ph.d\Causes and Consequences of Expenditure Rules\Causes\Comparative European Politics\Revision\crises.dta"

*Merging with continent dataset*
drop _merge

merge m:1 countrycode using "D:\Forskning og undervisning\Ph.d\Causes and Consequences of Expenditure Rules\Causes\Comparative European Politics\Revision\continents.dta"


drop _merge

merge 1:1 countrycode year using "D:\Forskning og undervisning\Ph.d\Causes and Consequences of Expenditure Rules\Causes\Comparative European Politics\Revision\openness_data.dta"


*Generate log of government debt to GDP variable*
generate logdebt= log( gg_gross_debt_pctgdp_imf)

*Figure 1. Plotting the share of countries with  a national fiscal rules in place*
bysort year : egen year_mean = mean(nationalfiscalrule)
twoway (line year_mean year),graphregion(color(white))legend (off) ytitle(Share of countries with national fiscal rules) ylabel(, format(%9.1f)) xlabel(1985 1990 1995 2000 2005 2010 2015), if year > 1984 & year<2016

drop countrycode_n
encode countrycode, gen(countrycode_n)

xtset countrycode_n year


*Test for stationarity of the data*
xtunitroot fisher nationalfiscalrulesindex, dfuller lags(0) trend
xtunitroot fisher nationalfiscalrulesindex, dfuller lags(1) trend
xtunitroot fisher nationalfiscalrulesindex, dfuller lags(2) trend
xtunitroot fisher nationalfiscalrulesindex, dfuller lags(3) trend


generate difindex= d.nationalfiscalrulesindex
xtunitroot fisher difindex , dfuller lags(0) trend
xtunitroot fisher difindex , dfuller lags(1) trend
xtunitroot fisher difindex , dfuller lags(2) trend
xtunitroot fisher difindex , dfuller lags(3) trend

xtunitroot fisher nationalfiscalreform2 , dfuller lags(0) trend
xtunitroot fisher nationalfiscalreform2 , dfuller lags(1) trend
xtunitroot fisher nationalfiscalreform2 , dfuller lags(2) trend
xtunitroot fisher nationalfiscalreform2 , dfuller lags(3) trend


*Descriptive statistics*
xtsum d.nationalfiscalrulesindex  nationalfiscalreform2 nationalfiscalrulesindex logdebt imfprogram  chiefexecutiveelection banking_crisis leftwingchiefexecutive loggdpcap democracy if nationalfiscalrulesindex!=. & logdebt!=. & imfprogram!=. &  chiefexecutiveelection!=.

*Correlation between debt and IMF program (note 7)
corr logdebt imfprogram

*Appendix A Fiscal rules index description*
hist nationalfiscalrulesindex, xtitle (Fiscal rules index) graphregion(color(white))legend (off), if nationalfiscalrulesindex!=. & logdebt!=. & imfprogram!=. &  chiefexecutiveelection!=.


bysort year : egen index_mean = mean(nationalfiscalrulesindex)
twoway (line index_mean year),graphregion(color(white))legend (off) ytitle(Mean World average score on the fiscal rules index) ylabel(, format(%9.1f)) xlabel(1985 1990 1995 2000 2005 2010 2015), if year > 1984 & year<2016

list country if nationalfiscalrulesindex>1.8 &  nationalfiscalrulesindex!=.


list country if nationalfiscalrulesindex>3 &  nationalfiscalrulesindex!=.

xtset countrycode_n year

* Footnote: Results without countries with very high scores on the index*

xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n), if countrycode_n!= 99 &  countrycode_n!= 101 &  countrycode_n!=121

xtreg nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n), if countrycode_n!= 99 &  countrycode_n!= 101 &  countrycode_n!=121

*Table 2 Results for fiscal rule introduction*
xtreg nationalfiscalreform2 l.logdebt l.imfprogram  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  nationalfiscalreform2 l.logdebt l.imfprogram l.banking_crisis    l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  nationalfiscalreform2 l.logdebt l.imfprogram l.banking_crisis l.loggdpcap   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis  l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


*Table 2 alternative: probit estimations
probit nationalfiscalreform2 l.logdebt l.imfprogram  l.chiefexecutiveelection i.year i.countrycode_n, cluster (countrycode_n)
probit  nationalfiscalreform2 l.logdebt l.imfprogram l.banking_crisis    l.chiefexecutiveelection i.year i.countrycode_n,  cluster (countrycode_n)
probit   nationalfiscalreform2 l.logdebt l.imfprogram l.banking_crisis l.loggdpcap   l.chiefexecutiveelection i.year i.countrycode_n,  cluster (countrycode_n)
probit  nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis  l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, cluster (countrycode_n)
probit nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year i.countrycode_n,  cluster (countrycode_n)


*Table 3: results for fiscal indexes*
xtreg d.nationalfiscalrulesindex  l.logdebt l.imfprogram  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.loggdpcap   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


*Table 4: Alternative explanations: Testing for democratization*
generate newdemo=0
replace newdemo=1 if democracy==1 & l.democracy==0
replace newdemo=. if democracy==. 

xtreg nationalfiscalreform2 l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy newdemo  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


xtreg d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy newdemo  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


xtreg  nationalfiscalreform2  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy newdemo l.legelec l.exelec  i.year, fe cluster (countrycode_n)

xtreg d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy newdemo  l.legelec l.exelec i.year, fe cluster (countrycode_n)



*Table 5:  Alternative explanations: Testing for effect of newly elected*

generate newlyelected=0
replace newlyelected=1 if yrsoffc==1
replace newlyelected=. if yrsoffc==.



xtreg  nationalfiscalreform2 l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection  i.year, fe cluster (countrycode_n), if newlyelected==0


xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n), if newlyelected==0

xtreg  nationalfiscalreform2 l.logdebt l.imfprogram l.banking_crisis c.l.leftwingchiefexecutive l.loggdpcap l.democracy  c.l.chiefexecutiveelection##c.newlyelected   i.year, fe cluster (countrycode_n)


xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  c.l.chiefexecutiveelection##c.newlyelected i.year, fe cluster (countrycode_n)






*Table 6: Control for average score on continent*

bysort continent year : egen continent_reform = mean(nationalfiscalreform2 )
bysort continent year : egen continent_ruleindex = mean(nationalfiscalrulesindex)
xtset countrycode_n year

xtreg nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection l.continent_reform  i.year, fe cluster (countrycode_n)


xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection l.continent_ruleindex i.year, fe cluster (countrycode_n)


* Table 7: Currency unions and the European Union*

xtreg nationalfiscalreform2 l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy l.cur l.eu l.chiefexecutiveelection i.year, fe cluster (countrycode_n)

xtreg d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy l.cur l.eu  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


xtreg  nationalfiscalreform2 l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.cur l.eu  l.legelec l.exelec  i.year, fe cluster (countrycode_n)


xtreg d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy l.cur l.eu  l.legelec l.exelec i.year, fe cluster (countrycode_n)


*Table 8: Only European Union*
xtreg nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n), if eu==1

probit nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year i.countrycode_n,  cluster (countrycode_n), if eu==1

xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n),  if eu==1


*Table 9: Democracy split sample*

xtreg nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection   i.year, fe cluster (countrycode_n), if l.democracy==1

 xtreg nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection   i.year, fe cluster (countrycode_n), if l.democracy==0



xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap  l.chiefexecutiveelection i.year, fe cluster (countrycode_n), if l.democracy==1

xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap  l.chiefexecutiveelection i.year, fe cluster (countrycode_n), if l.democracy==0



*Appendix B: Types of fiscal rules *
xtreg  reformER2  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  reformRR2  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  reformBBR2 l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  reformDR2 l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


xtreg  d.ER_n_strengh l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.RR_n_strengh l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.BBR_n_strengh  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.DR_n_strengh  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)



*Appendix C: Ten year moving average debt and percent of average tax revenue 
hist ggdma
generate logggdma= log( ggdma)
hist dfggd

generate logdfggd= log(dfggd)
hist logdfggd

*Fiscal rule introduction*
xtreg nationalfiscalreform2 l.logggdma l.imfprogram  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  nationalfiscalreform2 l.logggdma l.imfprogram l.banking_crisis    l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  nationalfiscalreform2 l.logggdma l.imfprogram l.banking_crisis l.loggdpcap   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg nationalfiscalreform2   l.logggdma l.imfprogram l.banking_crisis  l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg nationalfiscalreform2   l.logggdma l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)

xtreg nationalfiscalreform2 l.logdfggd l.imfprogram  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  nationalfiscalreform2 l.logdfggd l.imfprogram l.banking_crisis    l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  nationalfiscalreform2 l.logdfggd l.imfprogram l.banking_crisis l.loggdpcap   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg nationalfiscalreform2   l.logdfggd l.imfprogram l.banking_crisis  l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg nationalfiscalreform2   l.logdfggd l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)



*Fiscal rules index 
xtreg d.nationalfiscalrulesindex  l.logggdma l.imfprogram  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg d.nationalfiscalrulesindex  l.logggdma l.imfprogram l.banking_crisis   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg d.nationalfiscalrulesindex  l.logggdma l.imfprogram l.banking_crisis l.loggdpcap   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex  l.logggdma l.imfprogram l.banking_crisis l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex  l.logggdma l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


xtreg d.nationalfiscalrulesindex  l.logdfggd l.imfprogram  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg d.nationalfiscalrulesindex  l.logdfggd l.imfprogram l.banking_crisis   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg d.nationalfiscalrulesindex  l.logdfggd l.imfprogram l.banking_crisis l.loggdpcap   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex  l.logdfggd l.imfprogram l.banking_crisis l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex  l.logdfggd l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)





*Appendix C: Preelection index construction*
generate electionmonth=0
replace electionmonth=dateleg if presidentialsystem==0 & chiefexecutiveelection==1 
replace electionmonth=dateexec if presidentialsystem==1 & chiefexecutiveelection==1 

generate preelectionindex=0
replace preelectionindex= (electionmonth-1)/12 if chiefexecutiveelection==1 
replace preelectionindex= (12-f.electionmonth)/12  if f.chiefexecutiveelection==1 

replace preelectionindex=. if chiefexecutiveelection==. 
replace preelectionindex=0 if chiefexecutiveelection==0 & f.chiefexecutiveelection==0  & chiefexecutiveelection!=. 

xtreg  nationalfiscalreform2 l.logdebt  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy l.preelectionindex i.year, fe cluster (countrycode_n)

xtreg  nationalfiscalrulesindex l.logdebt  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy l.preelectionindex i.year, fe cluster (countrycode_n)

xtreg  nationalfiscalreform2 l.logdebt  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy preelectionindex i.year, fe cluster (countrycode_n)

xtreg  nationalfiscalrulesindex l.logdebt  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy preelectionindex i.year, fe cluster (countrycode_n)

generate modpreelectionindex=0
replace modpreelectionindex=preelectionindex if chiefexecutiveelection==1 
replace modpreelectionindex=. if preelectionindex==. 

xtreg  nationalfiscalreform2 l.logdebt  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy l.modpreelectionindex i.year, fe cluster (countrycode_n)

xtreg  nationalfiscalrulesindex l.logdebt  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy l.modpreelectionindex i.year, fe cluster (countrycode_n)

*Appendix C: effect when early elections are removed*

generate earlyelection=0
replace earlyelection=1 if chiefexecutiveelection==1 & l.yrcurnt!=1
replace earlyelection=. if chiefexecutiveelection==. 

generate exoelection=0
replace exoelection=1 if chiefexecutiveelection==1 & earlyelection==0
replace exoelection=. if chiefexecutiveelection==. 


xtreg nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.exoelection i.year, fe cluster (countrycode_n)

xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.exoelection i.year, fe cluster (countrycode_n)

*Appendix D: Controlling for other crises: 
xtreg nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.currency_crisis l.sovereign_debt_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)

xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.currency_crisis l.sovereign_debt_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)



*Appendix D controlling for economic openness*
xtreg nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection l.Trade_to_GDP  i.year, fe cluster (countrycode_n)


xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection l.Trade_to_GDP i.year, fe cluster (countrycode_n)


*Appendix D: government fractionalization and checks included as variables*
xtreg nationalfiscalreform2   l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy l.govfrac l.checks   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)

xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy l.govfrac l.checks l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


*Appendix E: different lag for IMF*
xtreg nationalfiscalreform2   l.logdebt l2.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex  l.logdebt l2.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


*Appendix E: Different lag for debt*
xtreg nationalfiscalreform2   l2.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex  l2.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


*Appendix E: Non-lagged control variables*
xtreg nationalfiscalreform2   l.logdebt l.imfprogram banking_crisis leftwingchiefexecutive loggdpcap democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex  l.logdebt l.imfprogram banking_crisis leftwingchiefexecutive loggdpcap democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)

*Appendix F: Lagged dependent variable*
xtreg nationalfiscalreform2  l.nationalfiscalreform2  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)

xtreg d.nationalfiscalrulesindex l.d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap  l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)



*Appendix G: Controlling for levels and analyzing levels
xtreg d.nationalfiscalrulesindex l.nationalfiscalrulesindex  l.logdebt l.imfprogram  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg d.nationalfiscalrulesindex   l.nationalfiscalrulesindex l.logdebt l.imfprogram l.banking_crisis   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg d.nationalfiscalrulesindex l.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.loggdpcap   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex l.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex l.nationalfiscalrulesindex l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)

xtreg nationalfiscalrulesindex  l.logdebt l.imfprogram  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg nationalfiscalrulesindex l.logdebt l.imfprogram l.banking_crisis   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.loggdpcap   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  nationalfiscalrulesindex l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)





*Other analyzes not in paper* 



* Higher effects of debt in countries with sovereign debt crisis history?
xtreg nationalfiscalreform2  c.laggeddebt##c.previous_sovereign_debt_crisis  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


xtreg d.nationalfiscalrulesindex  c.laggeddebt##c.previous_sovereign_debt_crisis  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy   l.chiefexecutiveelection i.year, fe cluster (countrycode_n)



* Higher effects of elections in countries with sovereign debt crisis history?
generate laggedchiefelection= l.chiefexecutiveelection

xtreg  nationalfiscalreform2 l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.previous_sovereign_debt_crisis##c.laggedchiefelection i.year, fe cluster (countrycode_n)

xtreg  d.nationalfiscalrulesindex l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.previous_sovereign_debt_crisis##c.laggedchiefelection i.year, fe cluster (countrycode_n)


xtreg d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy l.cur  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)

xtreg d.nationalfiscalrulesindex  l.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy l.cur  l.chiefexecutiveelection i.year, fe cluster (countrycode_n)


*Interaction with economic development*

xtreg nationalfiscalreform2  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.l.loggdpcap##c.laggedchiefelection i.year, fe cluster (countrycode_n)

xtreg  d.nationalfiscalrulesindex l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.l.loggdpcap##c.laggedchiefelection i.year, fe cluster (countrycode_n)


*Interaction between debt level and election*
generate laggeddebt= l.logdebt


xtreg  nationalfiscalreform2  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.laggeddebt##c.laggedchiefelection i.year, fe cluster (countrycode_n)

xtreg  d.nationalfiscalrulesindex l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.laggeddebt##c.laggedchiefelection i.year, fe cluster (countrycode_n)

xtreg  nationalfiscalreform2  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.laggeddebt##c.laggedchiefelection##c.l.loggdpcap i.year, fe cluster (countrycode_n)

xtreg  d.nationalfiscalrulesindex l.imfprogram l.banking_crisis l.leftwingchiefexecutive  l.democracy c.laggeddebt##c.laggedchiefelection##c.l.loggdpcap i.year, fe cluster (countrycode_n)


generate highdebt=0
replace highdebt=1 if gg_gross_debt_pctgdp_imf>100
replace highdebt=. if gg_gross_debt_pctgdp_imf==.

xtreg  nationalfiscalreform2  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.l.highdebt##c.laggedchiefelection i.year, fe cluster (countrycode_n)

xtreg  d.nationalfiscalrulesindex  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.l.highdebt##c.laggedchiefelection i.year, fe cluster (countrycode_n)

xtreg  nationalfiscalreform2   l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.democracy c.l.highdebt##c.laggedchiefelection##c.l.loggdpcap  i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.democracy c.l.highdebt##c.laggedchiefelection##c.l.loggdpcap  i.year, fe cluster (countrycode_n)



*Interaction between election and democracy*

generate polityplus10=polity2+10
generate laggedpolity= l.polityplus10
generate laggeddemocracy= l.democracy

xtreg  nationalfiscalreform2 l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap c.laggeddemocracy##c.laggedchiefelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap c.laggeddemocracy##c.laggedchiefelection i.year, fe cluster (countrycode_n)



xtreg  nationalfiscalreform2 l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap c.laggedpolity##c.laggedchiefelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap c.laggedpolity##c.laggedchiefelection i.year, fe cluster (countrycode_n)




generate laggedexecutiveelection= 1.exelec 
xtreg  nationalfiscalreform2  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap c.laggeddemocracy##c.laggedexecutiveelection i.year, fe cluster (countrycode_n)
xtreg  d.nationalfiscalrulesindex l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap c.laggeddemocracy##c.laggedexecutiveelection i.year, fe cluster (countrycode_n)


* Legislative vs. executive elections*
xtreg  nationalfiscalreform2  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.legelec l.exelec  i.year, fe cluster (countrycode_n)

xtreg d.nationalfiscalrulesindex  l.logdebt l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy  l.legelec l.exelec i.year, fe cluster (countrycode_n)



xtreg  nationalfiscalreform2  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.laggeddebt##c.laggedexecutiveelection i.year, fe cluster (countrycode_n)

xtreg  d.nationalfiscalrulesindex l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.laggeddebt##c.laggedexecutiveelection i.year, fe cluster (countrycode_n)


xtreg  nationalfiscalreform2 l.logdebt  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.previous_sovereign_debt_crisis##c.laggedexecutiveelection  i.year, fe cluster (countrycode_n)

xtreg  nationalfiscalrulesindex l.logdebt  l.imfprogram l.banking_crisis l.leftwingchiefexecutive l.loggdpcap l.democracy c.previous_sovereign_debt_crisis##c.laggedexecutiveelection i.year, fe cluster (countrycode_n)

