######################################
##### 7장. 데이터 처리 성능 향상 #####
######################################
# 이장의 내용 : ① plyr패키지(apply계열 함수 대치) ② 데이터 구조변경(melt, cast) ③ 데이터테이블
#### 1. plyr 패키지 ####
install.packages("plyr")
library(plyr)
apply(iris[,1:4], 2, FUN=mean)
apply(iris[,1:4], 2, FUN=function(col){mean(col)})

x <- data.frame(v1=c(4,9,16),    # 2의제곱, 3의 제곱, 4의제곱
                v2=c(16,81,196)) # 4의제곱, 9의제곱, 14의제곱곱
x
apply(x, 2, sum)
apply(x, 2, FUN=function(col){sum(sqrt(col))})
adply(.data=x, .margins = 2, .fun = function(col){sum(sqrt(col))})

# 종별 Sepal.Length평균, Sepal.Width평균
library(doBy)
summaryBy(Sepal.Length+Sepal.Width ~ Species, data=iris, FUN=mean)
ddply(.data=iris, .(Species), function(group){
  data.frame(SL.mean=mean(group$Sepal.Length),
             SW.mean=mean(group$Sepal.Width))
})
# summarise : 명시된 변수들만 출력
# transform : 기존의 iris뒤에 명시된 변수가 추가되서 출력
ddply(.data=iris, .(Species), summarise, SL.mean=mean(Sepal.Length),
      SW.mean=mean(Sepal.Width))
ddply(.data=iris, .(Species), transform, SL.mean=mean(Sepal.Length),
      SW.mean=mean(Sepal.Width))

#### 2. 데이터 구조 변경 (melt, cast함수) ####
View(airquality)
install.packages("reshape2")
library(reshape2)
airquality.melt <- melt(airquality, id=c('Month','Day'), value.name = "val")
head(airquality.melt)
# melt를 통해 바뀐 구조(5월5일 데이터)
subset(airquality, Month==5&Day==5)
subset(airquality.melt, Month==5&Day==5)

airquality.melt <- melt(airquality, id=c('Month','Day'), na.rm = TRUE)
# melt를 통해 바뀐 구조(5월5일 데이터)
subset(airquality, Month==5&Day==5)
subset(airquality.melt, Month==5&Day==5)

# melt된 데이터를 원상 복구 : dcast vs. acast
airquality.dc <- dcast(airquality.melt, Month+Day~variable)
head(airquality.dc, 2)
head(airquality,2)
airquality.dc[airquality.dc$Month==5 & airquality.dc$Day==1,] # 5월 1일 대기정보 데이터
airquality.ac <- acast(airquality.melt, Month+Day ~ variable)
head(airquality.ac,2)
airquality.ac['5_1',] # 5월 1일 대기정보 데이터
?acast
### 데이터 구조 변경 예

df1 <- read.csv('C:\\bigdata\\Download\\sharedBigdata\\전국 평균 평당 분양가격(2013년 9월부터 2015년 8월까지).csv')
df1
table(is.na(df1))
df1.melt <- melt(df1, id=c('지역'), value.name='price')
head(df1.melt)
str(df1.melt)
df1.melt$variable <- as.character(df1.melt$variable)

# variable에서 년도 뽑기
variable = 'X2013년12월'
as.integer(substr(variable, 2, 5))
df1.melt$연도 <- as.integer(substr(df1.melt$variable, 2, 5))
edit(df1.melt)

# variable에서 월 뽑기
variable <- 'X13년12월'
monthStr <- strsplit(variable, '년')[[1]][2]
monthStr <- substr(monthStr, 1, nchar(monthStr)-1)
as.integer(monthStr)

getMonth <- function(variable){
  monthStr <- strsplit(variable, '년')[[1]][2]
  monthStr <- substr(monthStr, 1, nchar(monthStr)-1)
  return(as.integer(monthStr))
}
getMonth('X2013년12월')
df1.melt$월 <- sapply(df1.melt$variable, getMonth)
edit(df1.melt)
df1.melt$variable <- NULL
head(df1.melt)

df2 <- read.csv('C:/bigdata/Download/sharedBigdata/주택도시보증공사_전국 신규 민간아파트 분양가격 동향_20210531.csv')
dim(df2) # 5780행 5열
head(df2)
df2 <- df2[df2$규모구분=='모든면적',]
head(df2)
df2$규모구분 <- NULL # 필요없는 변수 삭제제
head(df2)

str(df2)
colnames(df2) <- c('지역','연도','월','price_per_meter')
str(df2$price_per_meter)
df2[df2$price_per_meter=='',]
colSums(is.na(df2))
df2$price_per_meter <- as.integer(df2$price_per_meter) # 형변환
colSums(is.na(df2)) # 빈스트링등 정수형으로 변환할 수 없는 것은 NA로 처리
df2$price <- df2$price_per_meter * 3.3

head(df1.melt,2)
head(df2[,c('지역','연도','월','price')],2)
df <- rbind(df1.melt, df2[,c('지역','연도','월','price')])
edit(df)

#### 3. 데이터 테이블 : 짧고 유연한 빠른 구문을 사용하기 위해 데이터 프레임에서 상속 받음 ####
flightDF <- read.csv('inData/flights14.csv', header=T)
dim(flightDF)
edit(flightDF)
head(flightDF,2)
tail(flightDF,2)
class(flightDF)

install.packages("data.table") #데이터 테이블 사용을 위한 패키지
library("data.table")
flights <- fread('inData/flights14.csv') #csv파일을 데이터테이블로 받는 함수
class(flights)

# flightsDF 데이터프레임에 대해 작성 제출(yisy0703@naver.com)
# 1. origin이 JFK이고 month가 5월인 모든 행을 result에 얻는다
result <- flightDF[(flightDF$origin=='JFK' & flightDF$month==5),]
result
result <- subset(flightDF, flightDF$origin=='JFK' & flightDF$month==5 )
result


# 2. 처음 두 행을 result에 얻는다
result <- head(flightDF,2)
result

# 3. origin으로 오름차순, desc로 내림차순으로 정렬하여 출력
library(dplyr)
flightDF[order(flightDF$origin, desc(flightDF$dest)),]

# 4. arr_delay열만 출력
flightDF[,c("arr_delay")] #벡터로 출력
flightDF[,'arr_delay',drop=F]
subset(flightDF,select = arr_delay)
subset(flightDF,select = 'arr_delay')

# 5. year열부터 dep_time열까지 출력
flightDF[,c('year','month','day','dep_time')]
flightDF[,c(1:4)]

# 6. year열과 dep_time열 출력
flightDF[,c('year','dep_time')]
subset(flightDF,select = c('year','dep_time'))
?subset

# 7. arr_delay열과 dep_delay열을 출력하되 열이름을 delay_arr과 delay_dep로 변경
temp <- flightDF[,c('year','dep_time')]
temp <- subset(flightDF,select = c('year','dep_time'))
colnames(temp) <- c('delay_arr','delay_dep')
temp

# 8. 지연시간(arr_delay, dep_delay모두 0미만인 비행이 몇 번인지 출력
nrow(flightDF[flightDF$arr_delay<0 & flightDF$dep_delay<0,])

#   8-1 지연시간의 합이 0미만인 비행이 몇 번인지 출력
nrow(flightDF[(flightDF$dep_delay+flightDF$arr_delay)<0,])

# 9. 6월에 출발 공항이 JFK인 모든 항공편의 도착지연 및 출발지연 시간의 평균을 계산
apply(subset(flightDF,origin=='JFK' & month==6, select = c('arr_delay', 'dep_delay')),2,mean)
apply(flightDF[flightDF$origin=='JFK'& flightDF$month==6, c('arr_delay', 'dep_delay')], 2, mean)

# 10. 9번의 결과에 title에 mean_arr, mean_dep로 출력
x<-apply(flightDF[flightDF$origin=='JFK'& flightDF$month==6, c('arr_delay', 'dep_delay')], 2, mean)
names(x) <- c('mean_arr','mean_dep')
x

# 11. JFK 공항의 6월 운항 횟수
nrow(flightDF[flightDF$month==6 & flightDF$origin=='JFK',])

# 12. JFK 공항의 6월 운항 데이터 중 arr_delay열과 dep_delay열을 출력
flightDF[flightDF$month==6 & flightDF$origin == 'JFK',c('arr_delay','dep_delay')]

# 13. JFK 공항의 6월 운항 데이터 중 arr_delay열과 dep_delay열을 제외한 모든 열 출력
flightDF[flightDF$month==6 & flightDF$origin == 'JFK',-c(5,7)]

# 14. 출발 공항(origin)별 비행 수 출력 (JFK 81483 LGA 84433 EWR 87400)
table(flightDF$origin)
?table #데이터의 빈도를 보여준다

# 15. 항공사코드(carrier)가 AA에 대해 출발공항별 비행횟수 계산
table(flightDF[flightDF$carrier=='AA',]$origin)

# 16. origin, dest별로 비행횟수 출력
table(flightDF$origin, flightDF$dest) #교차표

# 17. 항공사코드(carrier)가 AA에 대해 origin, dest별로 비행횟수 출력
temp <- flightDF[flightDF$carrier=='AA',]
table(temp$origin, temp$dest)

# 18. 항공사 코드가 AA에 대해, origin, dest, 월별 평균arr_delay, 평균 dep_delay 출력
library(doBy)
temp <- flightDF[flightDF$carrier=='AA']
summaryBy(arr_delay+dep_delay~origin+dest+month, data=temp,FUN=mean)
aggregate(temp[,c('arr_delay','dep_delay')],by=list(temp$origin,temp$dest,temp$month),FUN=mean)


# 19. dep_delay>0가 참이거나 거짓, arr_delay>0가 참이거나 거짓인 각각의 비행횟수
table(flightDF$dep_delay>0,flightDF$arr_delay>0)


# 20. Origin==“JFK”에 대해 월별 최대 출발 지연 시간 출력(month로 정렬)
temp <- subset(flightDF, origin=='JFK')
tapply(temp$dep_delay, temp$month, max)

result <- aggregate(temp$dep_delay, by=list(temp$month), max)
result
result[order(result$Group.1),]

library(doBy)
result <- summaryBy(dep_delay ~ month, data=temp, FUN=max)
result
result[order(result$month),]











































