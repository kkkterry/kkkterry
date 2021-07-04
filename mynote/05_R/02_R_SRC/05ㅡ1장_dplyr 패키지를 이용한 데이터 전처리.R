######################################################
##### 5-1장. dplyr 패키지를 이용한 데이터 전처리 #####
######################################################
### 1. 외부파일 read/write
## 1.1 엑셀파일 읽어오기 - neadxl 패키지 이용
install.packages('readxl')
library(readxl)
getwd()
exam <- read_excel("C:/bigdata/src/06_R/inData/exam.xlsx")
head(exam)
exam <- read_excel('inData/exam.xlsx')
head(exam)
class(exam)
exam <- as.data.frame(exam)
class(exam)
head(exam)

exam2 <- read_excel('inData/exam.xlsx',sheet = 2)
exam2 <- as.data.frame(exam2)
exam2

# 데이터 파일에 컬러명이 없는 경우
city <- read_excel('inData/data_ex.xls',col_names = T)
city <- as.data.frame(city)
colnames(city) <- c('id','gender','age','area')
head(city,3)

## 1.2 데이터 쓰기(파일(csv)로 쓰기, 변수로 쓰기)
write.csv(exam, 'outData/exam.csv',row.names = T)

save(exam, file='outData/exam.rda') # exam변수를 파일에 저장
rm(list=ls(all.names=TRUE))
exam
load('outData/exam.rda')
head(exam)

### 2. dplyr 패키지 이용을 위한 데이터 준비 & 데이터 파악하기
# data(mpg, package = "ggplot2")
## 데이터 준비
mpg <- as.data.frame(ggplot2::mpg)
midwest <- as.data.frame(ggplot2::midwest)
## 데이터 파악하기
head(mpg)
tail(mpg,1)
edit(mpg)
View(mpg)
#dim() 차원 str() 구조 summary() 통계치 파악
dim(mpg)
str(mpg)
summary(mpg)

#변수명(열이름) (city->city, hwy->highway)
library(dplyr)
#mpg <- rename(mpg, city=city)
mpg <- rename(mpg, c(city=cty, highway=hwy))
colnames(mpg)

#파생변수 (total = (city+highway)/2)
mpg$total <- (mpg$city+mpg$highway)/2
head(mpg,3)

#파생변수(test = total 연비가 평균보다 높은 pass, 평균보다 낮으면 fail)
boxplot(mpg$total)  #(1)박스플롯(1,2,3사분위수, 이상치)
hist(mpg$total)
library(vioplot)
vioplot(mpg$total)
#violin plot은 boxplot 위에 분포 밀도(kernel density)를 좌우 대칭으로 덮어쓰는 방식으로
#데이터의 분포를 표현합니다. 

mpg$test <- ifelse(mpg$total >= mean(mpg$total),'pass','fail')
table(mpg$test) #빈도표
library(ggplot2)
dev.off()  #qplot이 에러날때
qplot(mpg$test)










