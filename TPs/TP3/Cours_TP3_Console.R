> library(rpart)
> read.table("C:\HEG\Data-mining\TPs\Project 2020-2021 Predict which investment product a client will buy-20201004", header=TRUE, sep=",")
Error: '\H' is an unrecognized escape in character string starting ""C:\H"
> setwd("C:/HEG/Data-mining/TPs/Project 2020-2021 Predict which investment product a client will buy-20201004")
> 
> myData <- read.table("investing_program_prediction_data.csv", header=TRUE, sep=",")
> 
> load("C:/HEG/Data-mining/TPs/Project 2020-2021 Predict which investment product a client will buy-20201004/.RData")
> install.packages("rpart")
Error in install.packages : Updating loaded packages

Restarting R session...

> install.packages("rpart")
WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:

https://cran.rstudio.com/bin/windows/Rtools/
Installing package into 'C:/Users/mikee/OneDrive/Documents/R/win-library/4.0'
(as 'lib' is unspecified)
trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/rpart_4.1-15.zip'
Content type 'application/zip' length 765853 bytes (747 KB)
downloaded 747 KB

package 'rpart' successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\mikee\AppData\Local\Temp\RtmpqE9wpw\downloaded_packages
> library(rpart)
Warning message:
package 'rpart' was built under R version 4.0.3 
> myData[,2]
   [1] "G29" "G0"  "G0"  "G52" "G10" "G27" "G0"  "G90" "G20" "G10" "G25" "G15" "G0"  "G19" "G0"  "G0"  "G0" 
  [18] "G81" "G51" "G75" "G38" "G22" "G44" "G0"  "G49" "G58" "G49" "G52" "G0"  "G52" "G0"  "G0"  "G29" "G0" 
  [35] "G58" "G0"  "G16" "G0"  "G46" "G47" "G27" "G58" "G0"  "G52" "G44" "G78" "G96" "G0"  "G0"  "G26" "G32"
  [52] "G69" "G51" "G69" "G96" "G0"  "G0"  "G0"  "G0"  "G0"  "G42" "G0"  "G36" "G96" "G30" "G0"  "G60" "G0" 
  [69] "G67" "G93" "G77" "G34" "G46" "G22" "G0"  "G74" "G84" "G16" "G90" "G0"  "G66" "G77" "G0"  "G0"  "G0" 
  [86] "G0"  "G71" "G52" "G0"  "G30" "G34" "G30" "G0"  "G0"  "G75" "G46" "G64" "G21" "G76" "G36" "G0"  "G90"
 [103] "G22" "G38" "G31" "G47" "G30" "G71" "G0"  "G25" "G0"  "G62" "G53" "G10" "G12" "G0"  "G96" "G93" "G76"
 [120] "G71" "G85" "G61" "G0"  "G71" "G91" "G0"  "G97" "G0"  "G93" "G71" "G30" "G19" "G58" "G44" "G64" "G30"
 [137] "G69" "G33" "G0"  "G0"  "G20" "G84" "G0"  "G24" "G49" "G0"  "G0"  "G90" "G27" "G31" "G0"  "G84" "G0" 
 [154] "G42" "G58" "G49" "G46" "G97" "G29" "G97" "G0"  "G0"  "G0"  "G74" "G44" "G70" "G0"  "G46" "G32" "G76"
 [171] "G69" "G86" "G95" "G67" "G0"  "G0"  "G0"  "G52" "G52" "G69" "G60" "G0"  "G20" "G13" "G26" "G64" "G69"
 [188] "G14" "G0"  "G49" "G0"  "G46" "G84" "G0"  "G97" "G0"  "G0"  "G0"  "G17" "G30" "G43" "G30" "G0"  "G74"
 [205] "G90" "G93" "G0"  "G58" "G17" "G42" "G34" "G56" "G97" "G55" "G0"  "G97" "G0"  "G0"  "G32" "G0"  "G68"
 [222] "G36" "G34" "G59" "G58" "G40" "G75" "G73" "G34" "G0"  "G76" "G39" "G0"  "G76" "G0"  "G99" "G20" "G75"
 [239] "G76" "G79" "G71" "G85" "G85" "G0"  "G0"  "G76" "G29" "G0"  "G44" "G0"  "G0"  "G59" "G46" "G71" "G55"
 [256] "G52" "G69" "G99" "G0"  "G69" "G30" "G46" "G70" "G21" "G75" "G44" "G17" "G78" "G97" "G59" "G43" "G88"
 [273] "G75" "G27" "G49" "G93" "G34" "G98" "G19" "G34" "G0"  "G34" "G71" "G10" "G0"  "G36" "G17" "G92" "G49"
 [290] "G78" "G19" "G42" "G26" "G0"  "G36" "G94" "G75" "G76" "G36" "G64" "G52" "G0"  "G49" "G75" "G91" "G99"
 [307] "G73" "G22" "G34" "G55" "G93" "G0"  "G0"  "G34" "G0"  "G75" "G74" "G0"  "G21" "G76" "G0"  "G0"  "G59"
 [324] "G58" "G18" "G44" "G0"  "G46" "G64" "G22" "G93" "G16" "G84" "G0"  "G0"  "G0"  "G93" "G86" "G45" "G67"
 [341] "G44" "G24" "G95" "G17" "G0"  "G44" "G73" "G49" "G49" "G0"  "G76" "G0"  "G0"  "G96" "G20" "G0"  "G0" 
 [358] "G0"  "G29" "G0"  "G90" "G75" "G19" "G75" "G79" "G59" "G0"  "G0"  "G34" "G42" "G12" "G91" "G81" "G32"
 [375] "G42" "G69" "G96" "G0"  "G53" "G24" "G0"  "G78" "G44" "G0"  "G58" "G20" "G42" "G69" "G0"  "G0"  "G46"
 [392] "G46" "G34" "G97" "G76" "G25" "G32" "G0"  "G0"  "G0"  "G17" "G30" "G36" "G0"  "G26" "G76" "G0"  "G0" 
 [409] "G0"  "G0"  "G78" "G49" "G96" "G60" "G58" "G36" "G0"  "G77" "G47" "G0"  "G15" "G96" "G85" "G52" "G0" 
 [426] "G93" "G0"  "G79" "G55" "G0"  "G0"  "G59" "G71" "G71" "G77" "G0"  "G40" "G30" "G56" "G34" "G46" "G0" 
 [443] "G42" "G36" "G29" "G93" "G93" "G20" "G85" "G44" "G27" "G90" "G81" "G21" "G15" "G97" "G69" "G23" "G62"
 [460] "G72" "G76" "G84" "G31" "G74" "G16" "G64" "G67" "G0"  "G44" "G0"  "G93" "G40" "G40" "G97" "G51" "G93"
 [477] "G32" "G63" "G49" "G97" "G97" "G53" "G49" "G53" "G43" "G97" "G64" "G13" "G0"  "G52" "G13" "G0"  "G98"
 [494] "G58" "G43" "G27" "G90" "G32" "G38" "G0"  "G46" "G78" "G0"  "G73" "G75" "G93" "G42" "G44" "G44" "G61"
 [511] "G0"  "G95" "G76" "G36" "G74" "G0"  "G0"  "G62" "G47" "G67" "G52" "G49" "G30" "G62" "G0"  "G21" "G0" 
 [528] "G0"  "G16" "G49" "G45" "G35" "G69" "G97" "G0"  "G43" "G93" "G52" "G0"  "G97" "G0"  "G67" "G16" "G62"
 [545] "G58" "G0"  "G0"  "G71" "G76" "G84" "G43" "G88" "G95" "G0"  "G0"  "G52" "G0"  "G26" "G60" "G14" "G0" 
 [562] "G0"  "G65" "G97" "G78" "G22" "G0"  "G64" "G64" "G49" "G93" "G69" "G90" "G2"  "G97" "G0"  "G55" "G0" 
 [579] "G0"  "G0"  "G63" "G25" "G93" "G0"  "G69" "G93" "G70" "G0"  "G34" "G72" "G79" "G0"  "G0"  "G0"  "G0" 
 [596] "G43" "G45" "G23" "G86" "G66" "G30" "G0"  "G67" "G52" "G10" "G55" "G55" "G0"  "G69" "G51" "G76" "G69"
 [613] "G0"  "G99" "G53" "G90" "G34" "G44" "G19" "G20" "G30" "G55" "G0"  "G90" "G27" "G75" "G0"  "G66" "G0" 
 [630] "G49" "G28" "G74" "G75" "G10" "G76" "G58" "G37" "G75" "G37" "G58" "G0"  "G0"  "G0"  "G47" "G36" "G49"
 [647] "G76" "G42" "G71" "G0"  "G91" "G0"  "G58" "G0"  "G32" "G97" "G52" "G65" "G44" "G47" "G0"  "G90" "G0" 
 [664] "G44" "G78" "G81" "G93" "G0"  "G48" "G29" "G80" "G77" "G24" "G34" "G53" "G52" "G63" "G38" "G0"  "G77"
 [681] "G20" "G0"  "G34" "G34" "G96" "G0"  "G69" "G0"  "G42" "G30" "G15" "G62" "G71" "G90" "G42" "G42" "G0" 
 [698] "G34" "G75" "G94" "G45" "G44" "G23" "G21" "G0"  "G30" "G90" "G32" "G90" "G95" "G76" "G0"  "G58" "G69"
 [715] "G34" "G0"  "G53" "G73" "G53" "G78" "G70" "G15" "G77" "G20" "G58" "G0"  "G26" "G22" "G58" "G47" "G22"
 [732] "G76" "G43" "G90" "G25" "G0"  "G16" "G34" "G99" "G30" "G30" "G73" "G0"  "G20" "G90" "G31" "G0"  "G13"
 [749] "G30" "G12" "G0"  "G48" "G93" "G0"  "G43" "G76" "G98" "G45" "G46" "G0"  "G76" "G35" "G93" "G0"  "G0" 
 [766] "G51" "G16" "G29" "G69" "G52" "G78" "G96" "G67" "G24" "G52" "G37" "G30" "G46" "G0"  "G0"  "G99" "G46"
 [783] "G59" "G0"  "G99" "G0"  "G0"  "G78" "G93" "G93" "G44" "G96" "G0"  "G51" "G75" "G0"  "G0"  "G26" "G0" 
 [800] "G52" "G20" "G11" "G0"  "G0"  "G84" "G49" "G58" "G0"  "G91" "G77" "G76" "G53" "G58" "G69" "G26" "G90"
 [817] "G58" "G22" "G59" "G58" "G34" "G22" "G42" "G11" "G46" "G23" "G55" "G40" "G79" "G0"  "G0"  "G46" "G22"
 [834] "G0"  "G34" "G90" "G93" "G47" "G0"  "G93" "G44" "G36" "G24" "G90" "G55" "G96" "G44" "G76" "G38" "G0" 
 [851] "G63" "G22" "G90" "G27" "G93" "G0"  "G21" "G97" "G0"  "G0"  "G0"  "G15" "G0"  "G34" "G63" "G26" "G69"
 [868] "G44" "G45" "G85" "G0"  "G75" "G74" "G14" "G0"  "G51" "G42" "G0"  "G21" "G76" "G0"  "G40" "G56" "G92"
 [885] "G49" "G84" "G0"  "G16" "G18" "G11" "G59" "G0"  "G44" "G32" "G54" "G0"  "G44" "G21" "G26" "G15" "G10"
 [902] "G93" "G75" "G0"  "G10" "G49" "G13" "G97" "G0"  "G0"  "G25" "G0"  "G53" "G30" "G58" "G0"  "G91" "G69"
 [919] "G99" "G36" "G64" "G90" "G16" "G0"  "G34" "G0"  "G37" "G0"  "G69" "G71" "G69" "G74" "G55" "G51" "G90"
 [936] "G67" "G40" "G72" "G81" "G0"  "G78" "G0"  "G76" "G52" "G18" "G0"  "G37" "G0"  "G0"  "G12" "G90" "G91"
 [953] "G45" "G99" "G50" "G25" "G55" "G75" "G97" "G60" "G0"  "G42" "G74" "G44" "G51" "G20" "G24" "G59" "G0" 
 [970] "G93" "G99" "G10" "G85" "G25" "G46" "G0"  "G28" "G97" "G49" "G24" "G34" "G33" "G76" "G79" "G14" "G40"
 [987] "G93" "G76" "G13" "G71" "G90" "G96" "G49" "G42" "G25" "G44" "G42" "G38" "G0"  "G36"
 [ reached getOption("max.print") -- omitted 3734 entries ]
> setwd("C:/HEG/Data-mining")
> myDataIris <- read.table("iris.csv", header=TRUE, sep=",")
> myDataIrirs
Error: object 'myDataIrirs' not found
> myDataIris
    sepal_length sepal_width petal_length petal_width           type.
1            5.1         3.5          1.4         0.2     Iris_setosa
2            4.9         3.0          1.4         0.2     Iris_setosa
3            4.7         3.2          1.3         0.2     Iris_setosa
4            4.6         3.1          1.5         0.2     Iris_setosa
5            5.0         3.6          1.4         0.2     Iris_setosa
6            5.4         3.9          1.7         0.4     Iris_setosa
7            4.6         3.4          1.4         0.3     Iris_setosa
8            5.0         3.4          1.5         0.2     Iris_setosa
9            4.4         2.9          1.4         0.2     Iris_setosa
10           4.9         3.1          1.5         0.1     Iris_setosa
11           5.4         3.7          1.5         0.2     Iris_setosa
12           4.8         3.4          1.6         0.2     Iris_setosa
13           4.8         3.0          1.4         0.1     Iris_setosa
14           4.3         3.0          1.1         0.1     Iris_setosa
15           5.8         4.0          1.2         0.2     Iris_setosa
16           5.7         4.4          1.5         0.4     Iris_setosa
17           5.4         3.9          1.3         0.4     Iris_setosa
18           5.1         3.5          1.4         0.3     Iris_setosa
19           5.7         3.8          1.7         0.3     Iris_setosa
20           5.1         3.8          1.5         0.3     Iris_setosa
21           5.4         3.4          1.7         0.2     Iris_setosa
22           5.1         3.7          1.5         0.4     Iris_setosa
23           4.6         3.6          1.0         0.2     Iris_setosa
24           5.1         3.3          1.7         0.5     Iris_setosa
25           4.8         3.4          1.9         0.2     Iris_setosa
26           5.0         3.0          1.6         0.2     Iris_setosa
27           5.0         3.4          1.6         0.4     Iris_setosa
28           5.2         3.5          1.5         0.2     Iris_setosa
29           5.2         3.4          1.4         0.2     Iris_setosa
30           4.7         3.2          1.6         0.2     Iris_setosa
31           4.8         3.1          1.6         0.2     Iris_setosa
32           5.4         3.4          1.5         0.4     Iris_setosa
33           5.2         4.1          1.5         0.1     Iris_setosa
34           5.5         4.2          1.4         0.2     Iris_setosa
35           4.9         3.1          1.5         0.1     Iris_setosa
36           5.0         3.2          1.2         0.2     Iris_setosa
37           5.5         3.5          1.3         0.2     Iris_setosa
38           4.9         3.1          1.5         0.1     Iris_setosa
39           4.4         3.0          1.3         0.2     Iris_setosa
40           5.1         3.4          1.5         0.2     Iris_setosa
41           5.0         3.5          1.3         0.3     Iris_setosa
42           4.5         2.3          1.3         0.3     Iris_setosa
43           4.4         3.2          1.3         0.2     Iris_setosa
44           5.0         3.5          1.6         0.6     Iris_setosa
45           5.1         3.8          1.9         0.4     Iris_setosa
46           4.8         3.0          1.4         0.3     Iris_setosa
47           5.1         3.8          1.6         0.2     Iris_setosa
48           4.6         3.2          1.4         0.2     Iris_setosa
49           5.3         3.7          1.5         0.2     Iris_setosa
50           5.0         3.3          1.4         0.2     Iris_setosa
51           7.0         3.2          4.7         1.4 Iris_versicolor
52           6.4         3.2          4.5         1.5 Iris_versicolor
53           6.9         3.1          4.9         1.5 Iris_versicolor
54           5.5         2.3          4.0         1.3 Iris_versicolor
55           6.5         2.8          4.6         1.5 Iris_versicolor
56           5.7         2.8          4.5         1.3 Iris_versicolor
57           6.3         3.3          4.7         1.6 Iris_versicolor
58           4.9         2.4          3.3         1.0 Iris_versicolor
59           6.6         2.9          4.6         1.3 Iris_versicolor
60           5.2         2.7          3.9         1.4 Iris_versicolor
61           5.0         2.0          3.5         1.0 Iris_versicolor
62           5.9         3.0          4.2         1.5 Iris_versicolor
63           6.0         2.2          4.0         1.0 Iris_versicolor
64           6.1         2.9          4.7         1.4 Iris_versicolor
65           5.6         2.9          3.6         1.3 Iris_versicolor
66           6.7         3.1          4.4         1.4 Iris_versicolor
67           5.6         3.0          4.5         1.5 Iris_versicolor
68           5.8         2.7          4.1         1.0 Iris_versicolor
69           6.2         2.2          4.5         1.5 Iris_versicolor
70           5.6         2.5          3.9         1.1 Iris_versicolor
71           5.9         3.2          4.8         1.8 Iris_versicolor
72           6.1         2.8          4.0         1.3 Iris_versicolor
73           6.3         2.5          4.9         1.5 Iris_versicolor
74           6.1         2.8          4.7         1.2 Iris_versicolor
75           6.4         2.9          4.3         1.3 Iris_versicolor
76           6.6         3.0          4.4         1.4 Iris_versicolor
77           6.8         2.8          4.8         1.4 Iris_versicolor
78           6.7         3.0          5.0         1.7 Iris_versicolor
79           6.0         2.9          4.5         1.5 Iris_versicolor
80           5.7         2.6          3.5         1.0 Iris_versicolor
81           5.5         2.4          3.8         1.1 Iris_versicolor
82           5.5         2.4          3.7         1.0 Iris_versicolor
83           5.8         2.7          3.9         1.2 Iris_versicolor
84           6.0         2.7          5.1         1.6 Iris_versicolor
85           5.4         3.0          4.5         1.5 Iris_versicolor
86           6.0         3.4          4.5         1.6 Iris_versicolor
87           6.7         3.1          4.7         1.5 Iris_versicolor
88           6.3         2.3          4.4         1.3 Iris_versicolor
89           5.6         3.0          4.1         1.3 Iris_versicolor
90           5.5         2.5          4.0         1.3 Iris_versicolor
91           5.5         2.6          4.4         1.2 Iris_versicolor
92           6.1         3.0          4.6         1.4 Iris_versicolor
93           5.8         2.6          4.0         1.2 Iris_versicolor
94           5.0         2.3          3.3         1.0 Iris_versicolor
95           5.6         2.7          4.2         1.3 Iris_versicolor
96           5.7         3.0          4.2         1.2 Iris_versicolor
97           5.7         2.9          4.2         1.3 Iris_versicolor
98           6.2         2.9          4.3         1.3 Iris_versicolor
99           5.1         2.5          3.0         1.1 Iris_versicolor
100          5.7         2.8          4.1         1.3 Iris_versicolor
101          6.3         3.3          6.0         2.5  Iris_virginica
102          5.8         2.7          5.1         1.9  Iris_virginica
103          7.1         3.0          5.9         2.1  Iris_virginica
104          6.3         2.9          5.6         1.8  Iris_virginica
105          6.5         3.0          5.8         2.2  Iris_virginica
106          7.6         3.0          6.6         2.1  Iris_virginica
107          4.9         2.5          4.5         1.7  Iris_virginica
108          7.3         2.9          6.3         1.8  Iris_virginica
109          6.7         2.5          5.8         1.8  Iris_virginica
110          7.2         3.6          6.1         2.5  Iris_virginica
111          6.5         3.2          5.1         2.0  Iris_virginica
112          6.4         2.7          5.3         1.9  Iris_virginica
113          6.8         3.0          5.5         2.1  Iris_virginica
114          5.7         2.5          5.0         2.0  Iris_virginica
115          5.8         2.8          5.1         2.4  Iris_virginica
116          6.4         3.2          5.3         2.3  Iris_virginica
117          6.5         3.0          5.5         1.8  Iris_virginica
118          7.7         3.8          6.7         2.2  Iris_virginica
119          7.7         2.6          6.9         2.3  Iris_virginica
120          6.0         2.2          5.0         1.5  Iris_virginica
121          6.9         3.2          5.7         2.3  Iris_virginica
122          5.6         2.8          4.9         2.0  Iris_virginica
123          7.7         2.8          6.7         2.0  Iris_virginica
124          6.3         2.7          4.9         1.8  Iris_virginica
125          6.7         3.3          5.7         2.1  Iris_virginica
126          7.2         3.2          6.0         1.8  Iris_virginica
127          6.2         2.8          4.8         1.8  Iris_virginica
128          6.1         3.0          4.9         1.8  Iris_virginica
129          6.4         2.8          5.6         2.1  Iris_virginica
130          7.2         3.0          5.8         1.6  Iris_virginica
131          7.4         2.8          6.1         1.9  Iris_virginica
132          7.9         3.8          6.4         2.0  Iris_virginica
133          6.4         2.8          5.6         2.2  Iris_virginica
134          6.3         2.8          5.1         1.5  Iris_virginica
135          6.1         2.6          5.6         1.4  Iris_virginica
136          7.7         3.0          6.1         2.3  Iris_virginica
137          6.3         3.4          5.6         2.4  Iris_virginica
138          6.4         3.1          5.5         1.8  Iris_virginica
139          6.0         3.0          4.8         1.8  Iris_virginica
140          6.9         3.1          5.4         2.1  Iris_virginica
141          6.7         3.1          5.6         2.4  Iris_virginica
142          6.9         3.1          5.1         2.3  Iris_virginica
143          5.8         2.7          5.1         1.9  Iris_virginica
144          6.8         3.2          5.9         2.3  Iris_virginica
145          6.7         3.3          5.7         2.5  Iris_virginica
146          6.7         3.0          5.2         2.3  Iris_virginica
147          6.3         2.5          5.0         1.9  Iris_virginica
148          6.5         3.0          5.2         2.0  Iris_virginica
149          6.2         3.4          5.4         2.3  Iris_virginica
150          5.9         3.0          5.1         1.8  Iris_virginica
> sample(1:100, 20)
 [1] 70 35 32 42  4 94 30 63 80 78 54 43 92 69 27 67 57 73 16 37
> sample(1:100, 20)
 [1] 21 17 68 28 34 30  4 97 95 32 49 59 40 18 46 22 86 64 75 29
> sample(1:100, 20)
 [1] 26 43 28  9 57 69 29 88 72  2 80  6 23 21 34 38 37 32  1 36
> dim(myDataIris[1])
[1] 150   1
> sample(1:dim(myDataIris[1]), 10)
 [1]   1 128  62  81  37  83   3  92  84  85
Warning message:
In 1:dim(myDataIris[1]) :
  numerical expression has 2 elements: only the first used
> sample(1:dim(myDataIris)[1], 10)
 [1]  65  63 123 117  56   1  39  62  18  87
> trainingIndeces <- sample(1:dim(myDataIris)[1], 10)
> myDataIris[trainingIndeces]
Error in `[.data.frame`(myDataIris, trainingIndeces) : 
  undefined columns selected
> myDataIris[trainingIndeces, ]
    sepal_length sepal_width petal_length petal_width           type.
14           4.3         3.0          1.1         0.1     Iris_setosa
128          6.1         3.0          4.9         1.8  Iris_virginica
79           6.0         2.9          4.5         1.5 Iris_versicolor
60           5.2         2.7          3.9         1.4 Iris_versicolor
63           6.0         2.2          4.0         1.0 Iris_versicolor
109          6.7         2.5          5.8         1.8  Iris_virginica
95           5.6         2.7          4.2         1.3 Iris_versicolor
113          6.8         3.0          5.5         2.1  Iris_virginica
42           4.5         2.3          1.3         0.3     Iris_setosa
9            4.4         2.9          1.4         0.2     Iris_setosa
> myDataIris[trainingIndeces, 0.5 * dim(myDataIris)[1]]
NULL
> myDataIris[trainingIndeces, 0.5 * dim(myDataIris)[1])
Error: unexpected ')' in "myDataIris[trainingIndeces, 0.5 * dim(myDataIris)[1])"
> sample(1:myDataIris[1], 0.5 * dim(myDataIris)[1])
Error in 1:myDataIris[1] : NA/NaN argument
> sample(1 : dim(myDataIris)[1], 0.5 * dim(myDataIris)[1])
 [1]  93  33  68 137   4   9 122 106  99 145  14  24 115  96  61  39  59  80  20  15   3  42  31 126  34   8  58
[28]  95 143  57 116  56  69  77  49  47  44 129 141  85 123  90  36 100  75  55  45 103 138  50 120  98  28  18
[55]  97  26 101 146  62 148   6  10 127  65 109 147   5  25 139  19  43 144 136  78  30
> trainingIndeces <- sample(1 : dim(myDataIris)[1], 0.5 * dim(myDataIris)[1])
> length(trainingIndeces)
[1] 75
> trainingData <- myData[trainingIndeces, ]
> rpart(formula=type.~., trainingData)
Error in eval(predvars, data, env) : object 'type.' not found
> trainingData <- myDataIris[trainingIndeces, ]
> rpart(formula=type.~., trainingData)
n= 75 

node), split, n, loss, yval, (yprob)
      * denotes terminal node

1) root 75 46 Iris_versicolor (0.2933333 0.3866667 0.3200000)  
  2) petal_length< 2.35 22  0 Iris_setosa (1.0000000 0.0000000 0.0000000) *
  3) petal_length>=2.35 53 24 Iris_versicolor (0.0000000 0.5471698 0.4528302)  
    6) petal_length< 4.75 26  0 Iris_versicolor (0.0000000 1.0000000 0.0000000) *
    7) petal_length>=4.75 27  3 Iris_virginica (0.0000000 0.1111111 0.8888889) *
> rpart(formula=type.~sepal_width+petal_length, trainingData)
n= 75 

node), split, n, loss, yval, (yprob)
      * denotes terminal node

1) root 75 46 Iris_versicolor (0.2933333 0.3866667 0.3200000)  
  2) petal_length< 2.35 22  0 Iris_setosa (1.0000000 0.0000000 0.0000000) *
  3) petal_length>=2.35 53 24 Iris_versicolor (0.0000000 0.5471698 0.4528302)  
    6) petal_length< 4.75 26  0 Iris_versicolor (0.0000000 1.0000000 0.0000000) *
    7) petal_length>=4.75 27  3 Iris_virginica (0.0000000 0.1111111 0.8888889) *
> rpart(formula=type.~., trainingData)
n= 75 

node), split, n, loss, yval, (yprob)
      * denotes terminal node

1) root 75 46 Iris_versicolor (0.2933333 0.3866667 0.3200000)  
  2) petal_length< 2.35 22  0 Iris_setosa (1.0000000 0.0000000 0.0000000) *
  3) petal_length>=2.35 53 24 Iris_versicolor (0.0000000 0.5471698 0.4528302)  
    6) petal_length< 4.75 26  0 Iris_versicolor (0.0000000 1.0000000 0.0000000) *
    7) petal_length>=4.75 27  3 Iris_virginica (0.0000000 0.1111111 0.8888889) *
> dt <- rpart(formula=type.~., trainingData)
> plot(dt, compress=T, uniform=T, margin=0.2)
> text(dt, digits=3, use.n=T)
> set.seed(1)
> sample(1:100, 10)
 [1] 68 39  1 34 87 43 14 82 59 51
> set.seed(1)
> sample(1:100, 10)
 [1] 68 39  1 34 87 43 14 82 59 51
> set.seed(2)
> sample(1:100, 10)
 [1] 85 79 70  6 32  8 17 93 81 76
> set.seed(2)
> sample(1:100, 10)
 [1] 85 79 70  6 32  8 17 93 81 76
> sample(1:100, 10)
 [1] 41 50 75 65  3 80 99 55 63  8
> set.seed(777)
> sample(1 : 10, 5)
[1] 8 1 2 4 6
> sample(1 : 10, 5)
[1] 3 9 1 4 7
> set.seed(777)
> set.seed(777)
> sample(1 : 10, 5)
[1] 8 1 2 4 6
> sample(1 : 10, 5)
[1] 3 9 1 4 7
> sample(1 : 10, 5)
[1] 10  7  6  5  4
> set.seed(1)
> testData <- myDataIris[-trainingIndeces, 1:4]
> testData
    sepal_length sepal_width petal_length petal_width
1            5.1         3.5          1.4         0.2
2            4.9         3.0          1.4         0.2
3            4.7         3.2          1.3         0.2
4            4.6         3.1          1.5         0.2
5            5.0         3.6          1.4         0.2
7            4.6         3.4          1.4         0.3
10           4.9         3.1          1.5         0.1
11           5.4         3.7          1.5         0.2
12           4.8         3.4          1.6         0.2
13           4.8         3.0          1.4         0.1
14           4.3         3.0          1.1         0.1
19           5.7         3.8          1.7         0.3
20           5.1         3.8          1.5         0.3
21           5.4         3.4          1.7         0.2
23           4.6         3.6          1.0         0.2
24           5.1         3.3          1.7         0.5
25           4.8         3.4          1.9         0.2
28           5.2         3.5          1.5         0.2
36           5.0         3.2          1.2         0.2
37           5.5         3.5          1.3         0.2
38           4.9         3.1          1.5         0.1
40           5.1         3.4          1.5         0.2
41           5.0         3.5          1.3         0.3
42           4.5         2.3          1.3         0.3
43           4.4         3.2          1.3         0.2
45           5.1         3.8          1.9         0.4
49           5.3         3.7          1.5         0.2
50           5.0         3.3          1.4         0.2
56           5.7         2.8          4.5         1.3
65           5.6         2.9          3.6         1.3
66           6.7         3.1          4.4         1.4
67           5.6         3.0          4.5         1.5
70           5.6         2.5          3.9         1.1
72           6.1         2.8          4.0         1.3
74           6.1         2.8          4.7         1.2
77           6.8         2.8          4.8         1.4
78           6.7         3.0          5.0         1.7
79           6.0         2.9          4.5         1.5
81           5.5         2.4          3.8         1.1
82           5.5         2.4          3.7         1.0
84           6.0         2.7          5.1         1.6
87           6.7         3.1          4.7         1.5
89           5.6         3.0          4.1         1.3
90           5.5         2.5          4.0         1.3
94           5.0         2.3          3.3         1.0
95           5.6         2.7          4.2         1.3
96           5.7         3.0          4.2         1.2
97           5.7         2.9          4.2         1.3
98           6.2         2.9          4.3         1.3
101          6.3         3.3          6.0         2.5
103          7.1         3.0          5.9         2.1
105          6.5         3.0          5.8         2.2
107          4.9         2.5          4.5         1.7
112          6.4         2.7          5.3         1.9
115          5.8         2.8          5.1         2.4
116          6.4         3.2          5.3         2.3
117          6.5         3.0          5.5         1.8
118          7.7         3.8          6.7         2.2
119          7.7         2.6          6.9         2.3
121          6.9         3.2          5.7         2.3
123          7.7         2.8          6.7         2.0
124          6.3         2.7          4.9         1.8
125          6.7         3.3          5.7         2.1
126          7.2         3.2          6.0         1.8
131          7.4         2.8          6.1         1.9
132          7.9         3.8          6.4         2.0
133          6.4         2.8          5.6         2.2
136          7.7         3.0          6.1         2.3
140          6.9         3.1          5.4         2.1
141          6.7         3.1          5.6         2.4
143          5.8         2.7          5.1         1.9
145          6.7         3.3          5.7         2.5
147          6.3         2.5          5.0         1.9
148          6.5         3.0          5.2         2.0
150          5.9         3.0          5.1         1.8
> predict(dt, testData, type=class)
Error in match.arg(type) : 'arg' must be NULL or a character vector
> predict(dt, testData, type="class")
              1               2               3               4               5               7              10 
    Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa 
             11              12              13              14              19              20              21 
    Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa 
             23              24              25              28              36              37              38 
    Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa 
             40              41              42              43              45              49              50 
    Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa 
             56              65              66              67              70              72              74 
Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor 
             77              78              79              81              82              84              87 
 Iris_virginica  Iris_virginica Iris_versicolor Iris_versicolor Iris_versicolor  Iris_virginica Iris_versicolor 
             89              90              94              95              96              97              98 
Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor 
            101             103             105             107             112             115             116 
 Iris_virginica  Iris_virginica  Iris_virginica Iris_versicolor  Iris_virginica  Iris_virginica  Iris_virginica 
            117             118             119             121             123             124             125 
 Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica 
            126             131             132             133             136             140             141 
 Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica 
            143             145             147             148             150 
 Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica 
Levels: Iris_setosa Iris_versicolor Iris_virginica
> predictedResults <- predict(dt, testData, type="class")
> predictedResults
              1               2               3               4               5               7              10 
    Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa 
             11              12              13              14              19              20              21 
    Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa 
             23              24              25              28              36              37              38 
    Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa 
             40              41              42              43              45              49              50 
    Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa     Iris_setosa 
             56              65              66              67              70              72              74 
Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor 
             77              78              79              81              82              84              87 
 Iris_virginica  Iris_virginica Iris_versicolor Iris_versicolor Iris_versicolor  Iris_virginica Iris_versicolor 
             89              90              94              95              96              97              98 
Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor Iris_versicolor 
            101             103             105             107             112             115             116 
 Iris_virginica  Iris_virginica  Iris_virginica Iris_versicolor  Iris_virginica  Iris_virginica  Iris_virginica 
            117             118             119             121             123             124             125 
 Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica 
            126             131             132             133             136             140             141 
 Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica 
            143             145             147             148             150 
 Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica  Iris_virginica 
Levels: Iris_setosa Iris_versicolor Iris_virginica
> length(predictedResults)
[1] 75
> trueLabelsTestData <- myDataIris[-trainingIndeces, 5]
> trueLabelsTestData
 [1] "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"    
 [7] "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"    
[13] "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"    
[19] "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"    
[25] "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_setosa"     "Iris_versicolor" "Iris_versicolor"
[31] "Iris_versicolor" "Iris_versicolor" "Iris_versicolor" "Iris_versicolor" "Iris_versicolor" "Iris_versicolor"
[37] "Iris_versicolor" "Iris_versicolor" "Iris_versicolor" "Iris_versicolor" "Iris_versicolor" "Iris_versicolor"
[43] "Iris_versicolor" "Iris_versicolor" "Iris_versicolor" "Iris_versicolor" "Iris_versicolor" "Iris_versicolor"
[49] "Iris_versicolor" "Iris_virginica"  "Iris_virginica"  "Iris_virginica"  "Iris_virginica"  "Iris_virginica" 
[55] "Iris_virginica"  "Iris_virginica"  "Iris_virginica"  "Iris_virginica"  "Iris_virginica"  "Iris_virginica" 
[61] "Iris_virginica"  "Iris_virginica"  "Iris_virginica"  "Iris_virginica"  "Iris_virginica"  "Iris_virginica" 
[67] "Iris_virginica"  "Iris_virginica"  "Iris_virginica"  "Iris_virginica"  "Iris_virginica"  "Iris_virginica" 
[73] "Iris_virginica"  "Iris_virginica"  "Iris_virginica" 
> table(predictedResults, trueLabelsTestData)
                 trueLabelsTestData
predictedResults  Iris_setosa Iris_versicolor Iris_virginica
  Iris_setosa              28               0              0
  Iris_versicolor           0              18              1
  Iris_virginica            0               3             25
> diag(table(predictedResults, trueLabelsTestData))
    Iris_setosa Iris_versicolor  Iris_virginica 
             28              18              25 
> sum(diag(table(predictedResults, trueLabelsTestData)))
[1] 71
> sum(diag(table(predictedResults, trueLabelsTestData))) / sum(sum(diag(table(predictedResults, trueLabelsTestData))))
[1] 1
> sum(diag(table(predictedResults, trueLabelsTestData))) / sum(sum(table(predictedResults, trueLabelsTestData)))
[1] 0.9466667
> sum(diag(table(predictedResults, trueLabelsTestData))) / (sum(table(predictedResults, trueLabelsTestData))
+ sum(diag(table(predictedResults, trueLabelsTestData))) / (sum(table(predictedResults, trueLabelsTestData)))
Error: unexpected symbol in:
"sum(diag(table(predictedResults, trueLabelsTestData))) / (sum(table(predictedResults, trueLabelsTestData))
                                                           sum"
> sum(diag(table(predictedResults, trueLabelsTestData))) / (sum(table(predictedResults, trueLabelsTestData)))
[1] 0.9466667