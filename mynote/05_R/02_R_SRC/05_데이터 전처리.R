##############################
##### 5장. 데이터 전처리 #####
##############################

### 1. 파일 입출력
## 1.1 시스템 인코딩 조회
Sys.getlocale() # Windows는 CP949

## 1.2 write.table : 데이터를 파일에 저장
iris
class(iris)
getwd()
write.table(iris, file='outData/iris.csv', sep=',')
write.table(iris, file='outData/iris.csv', sep=',', row.names = FALSE)
InsectSprays
summary(InsectSprays)
str(InsectSprays)
write.table(InsectSprays, file='outData/insect.csv', sep=',', row.names = F)

## 1.3 read.table : 파일의 내용을 데이터프레임 형태로 읽어옴
irisData <- read.table('outData/iris.csv', sep=',') # 첫번째 행도 데이터로 읽어들임
head(irisData)
irisData <- read.table('outData/iris.csv', sep=',', header = TRUE,
                       encoding = 'utf-8')
head(irisData)
str(irisData) # Species가 문자형으로 읽어들임
irisData <- read.table('outData/iris.csv', sep=',', header=TRUE, 
                       stringsAsFactors = TRUE)
str(irisData)

emp <- read.table('inData/emp.csv', sep=',', header = TRUE,
                  stringsAsFactors = TRUE)
str(emp)

## 1.4 write.csv
write.csv(iris, file='outData/iris1.csv')
write.csv(iris, file='outData/iris1.csv', quote = T, row.names = F)

## 1.5 read.csv
newIris <- read.csv('outData/iris1.csv', header = TRUE)
head(newIris)
str(newIris)
?read.csv
newIris$Species <- as.factor(newIris$Species)
str(newIris)
newIris$Species <- as.character(newIris$Species)
newIris$Species <- factor(newIris$Species, 
                          levels = c('setosa', 'versicolor','virginica'))
str(newIris)
summary(newIris)

## 1.6 cat을 이용한 text 출력
cat('Hi, R', '\n',  file='outData/irisSummary.txt', append = TRUE)

irisSummary <- summary(iris)
class(irisSummary)
dim(irisSummary)
irisSummary[1,]
irisSummary[2,]
?cat
cat('iris 통계 요약치','\n',file='outData/irisSummary.txt')
for(i in 1:nrow(irisSummary)){
  cat(irisSummary[i,], '\n', file='outData/irisSummary.txt', append = TRUE)
}

### 2. apply 계열 함수 적용

## 2.1 apply
# iris데이터의 열별 평균(합계, 표준편차, 최소값, 최대값, 중앙값)
# apply(대상자료, 1또는2, 함수)
iris[, -5]
iris[, 1:4]
apply(iris[,1:4], 2, mean) # 열별 평균
apply(iris[,1:4], 1, mean) # 행별 평균
# apply계열을 이용한 집계함수 : 평균, 합계, 표준편차, 최소값, 최대값, 중앙값
apply(iris[,1:4], 2, FUN=mean) #열별 평균
apply(iris[,1:4], 2, FUN=sum)  #열별 합계
apply(iris[,1:4], 2, FUN=sd)  #열별 표준편차
apply(iris[,1:4], 2, FUN=min)  #열별 최소값
apply(iris[,1:4], 2, FUN=max)  #열별 최대값
apply(iris[,1:4], 2, FUN=median) # 열별 중앙값

unique(iris$Species) # Species의 종류
levels(iris$Species) # Species의 종류
# 종별(setosa, versicolor, virginica) 열별 평균 구하기
setosa_m     <- apply(iris[iris$Species=='setosa',-5], 2, FUN=mean)
setosa_s     <- apply(iris[iris$Species=='setosa',-5], 2, FUN=sd)
versicolor_m <- apply(iris[iris$Species=='versicolor',-5], 2, FUN=mean)
versicolor_s <- apply(iris[iris$Species=='versicolor',-5], 2, FUN=sd)
virginica_m  <- apply(iris[iris$Species=='virginica',-5], 2, FUN=mean)
virginica_s  <- apply(iris[iris$Species=='virginica',-5], 2, FUN=sd)
data.frame(setosa_m, setosa_s, versicolor_m, versicolor_s, virginica_m, virginica_s)

# 학생 데이터 #
name <- c('김','홍','박','이','윤')
kor  <- c(90,95,97,96,80)
eng  <- c(80,90,95,97,100)
mat  <- c(70,75,86,91,100)
student <- data.frame(name, kor, eng, mat)
student
rownames(student) <- name
apply(student[,-1], 1, mean)
# 학생별 평균
m <- apply(student[,-1], 1, mean)
names(m) <- name
m
# 과목별 평균
apply(student[,-1], 2, mean)

## 2.2 lapply : list apply (결과도 list)
lapply(iris[1:4], mean)  # (1)
list.iris <- as.list(iris[1:4])
lapply(list.iris, mean)  # (2)
exp(-3:3) # e의 -3승부터 3까지 7개 데이터
x <- list(a=1:10, beta=exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE,TRUE))
lapply(x, mean)
lapply(x, quantile)
lapply(x, quantile, 1:3/4)
quantile(c(1:10), probs = 1:3/4)
quantile(exp(-3:3))

## 2.3 sapply : lapply와 유사하나 결과가 행렬이나 벡터로 반환
sapply(iris[1:4], mean)
sapply(x, mean)
sapply(x, quantile)
sapply(x, quantile, 1:3/4)

fivenum(1:100)
seq(1, 100, length.out=5)
i39 <- sapply(c(3:9), seq)
i39
lapply(i39, fivenum)
sapply(i39, fivenum)

## 2.4 vapply : sapply와 유사하나 FUN의 결과값이 FUN.VALUE와 호환되는지 
vapply(i39, FUN=fivenum, FUN.VALUE=c(numeric(1),numeric(1),numeric(1),numeric(1),numeric(1) ))

sapply(iris[1:4], mean)
vapply(iris[1:4], mean, FUN.VALUE = numeric(1))


