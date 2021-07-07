# flightDF(데이터프레임)에 대해 다음의 R명령어를 작성하시오

# 1. origin이 JFK이고 month가 5월인 모든 행을 result에 얻는다
result <- flightDF[flights$origin=='JFK' & flightDF$month==5,]
result <- subset(flightDF, origin=='JFK' & flightDF$month==5)

result <- flights[origin=='JFK' & month==5,]
result <- flights[origin=='JFK' & month==5]
head(result,2)
# 2. 처음 두 행을 result에 얻는다
result <- flightDF[1:2,]
result <- head(flightDF,2)

result <- flights[1:2]
result
# 3. origin으로 오름차순, dest로 내림차순으로 정렬하여 출력(order사용)

flightDF[order(flightDF$origin),]
flightDF[order(flightDF$dest, decreasing = T),]
# flightDF[order(-flightDF$dest),] #불가
library(dplyr)
flightDF[order(flightDF$origin, desc(flightDF$dest)),]

flights[order(flights$origin, -flights$dest)]
flights[order(origin, -dest)]

# 4. arr_delay열만 출력
flightDF[,'arr_delay'] # 벡터 형태로 출력
flightDF[,'arr_delay', drop=F] # 데이터프레임 형태로 출력
subset(flightDF, select='arr_delay')
subset(flightDF, select=arr_delay)

flights[,arr_delay] # 벡터형태로 출력
flights[, .(arr_delay)] #데이터 프레임(데이터 테이블) 형태로 출력
flights[, c('arr_delay')] #데이터 프레임형태로 출력
flights[, c(arr_delay)] # 벡터형태로 출력
flights[, list(arr_delay)] # 데이터 프레임 형태로 출력

# 5. year열부터 dep_time열까지 출력
colnames(flightDF)
flightDF[,1:4]
flightDF[,c("year","month","day","dep_time")]
# flightDF[,c("year":"dep_time")] 불가
subset(flightDF, select=1:4)
subset(flightDF, select=c("year","month","day","dep_time"))
# subset(flightDF, select=c("year":"dep_time")) 불가

flights[, year:dep_time]
subset(flights, select=c(year:dep_time))

# 6. year열과 dep_time열 출력
flightDF[, c('year','dep_time')]
subset(flightDF, select = c('year','dep_time'))

flights[,c(year, dep_time)] # 행렬형태로 출력(X)
flights[,list(year, dep_time)]
flights[,c('year', 'dep_time')]
flights[, .(year, dep_time)]
flights[, .(년도=year, 실제출발=dep_time)] # 출력되는 header(변수) 변경

# 7. arr_delay열과 dep_delay열을 출력하되 열이름을 delay_arr과 delay_dep로 변경
temp <- flightDF[,c('arr_delay','dep_delay')]
colnames(temp) <- c('delay_arr','delay_dep')
temp

flights[, .(delay_arr = arr_delay, delay_dep = dep_delay)]

# 8. 지연시간(arr_delay, dep_delay모두 0미만인 비행이 몇 번인지 출력
nrow(flightDF[flightDF$arr_delay<0 & flightDF$dep_delay<0,])

flights[arr_delay<0 & dep_delay<0, .(cnt=.N) ]  # .N : 갯수
flights[, sum(arr_delay<0 & dep_delay<0)]

# 8-1 지연시간의 합이 0미만인 비행이 몇 번인지 출력
nrow(flightDF[(flightDF$arr_delay + flightDF$dep_delay) < 0,])

flights[arr_delay+dep_delay<0, .(.N)]
flights[arr_delay+dep_delay<0, .N]

# 9. 6월에 출발 공항이 JFK인 모든 항공편의 도착지연 및 출발지연 시간의 평균을 계산
apply(subset(flightDF, origin=='JFK' & month==6, select = c('arr_delay', 'dep_delay')), 2, mean)
apply(flightDF[flightDF$origin=='JFK'& flightDF$month==6, c('arr_delay', 'dep_delay')], 2, mean)

flights[origin=='JFK'& month==6, .(arr_mean = mean(arr_delay), 
                                   dep_mean = mean(dep_delay))]

# 10. 9번의 결과에 title에 mean_arr, mean_dep로 출력
x <- apply(subset(flightDF, origin=='JFK' & month==6, select = c('arr_delay', 'dep_delay')), 2, mean)
names(x)<- c('mean_arr', 'mean_dep')
x

flights[origin=='JFK'& month==6, .(mean_arr = mean(arr_delay), 
                                   mean_dep = mean(dep_delay))]

# 11. JFK 공항의 6월 운항 횟수
nrow(subset(flightDF,origin=='JFK' & month==6))
nrow(flightDF[flightDF$origin=='JFK' & flightDF$month==6,])

flights[origin=='JFK'&month==6, .(.N)]
flights[origin=='JFK'&month==6, .N]

# 12. JFK 공항의 6월 운항 데이터 중 arr_delay열과 dep_delay열을 출력
subset(flightDF, subset=(origin=='JFK' & month==6), select=c("arr_delay","dep_delay"))

subset(flightDF, origin=='JFK' & month==6, c("arr_delay","dep_delay"))

flightDF[flightDF$origin=='JFK' & flightDF$month==6, c("arr_delay","dep_delay")]

flights[origin=='JFK'&month==6, .(arr_delay, dep_delay)]
flights[origin=='JFK'&month==6, list(arr_delay, dep_delay)]
flights[origin=='JFK'&month==6, c('arr_delay', 'dep_delay')]

# 13. JFK 공항의 6월 운항 데이터 중 arr_delay열과 dep_delay열을 제외한 모든 열 출력
colnames(flightDF) # arr_delay열은 7번째, dep_delay열은 5번째
subset(flightDF, origin=='JFK' & month==6, select=c(-5,-7))
subset(flightDF, origin=='JFK' & month==6, select=-c(5,7))
# subset(flightDF, origin=='JFK' & month==6, select=-c('arr_delay','dep_delay')) # 불가
# subset(flightDF, origin=='JFK' & month==6, select=c(-'arr_delay',-'dep_delay')) # 불가
# flightDF[flightDF$origin=='JFK'&flights$month==6, c(-'arr_delay',-'dep_delay')] #불가
flightDF[flightDF$origin=='JFK'&flights$month==6, c(-5,-7)] 

flights[origin=='JFK'&month==6, -c("arr_delay", "dep_delay")]

# 14. 출발 공항(origin)별 비행 수 출력 (JFK 81483 LGA 84433 EWR 87400)
table(flightDF$origin)

flights[ , .(.N), by=.(origin)]
flights[, .N, by=origin]

# 15. 항공사코드(carrier)가 AA에 대해 출발공항별 비행횟수 계산
table(subset(flightDF, carrier=='AA')$origin)

flights[carrier=='AA', .(.N), by=.(origin)]

# 16. origin, dest별로 비행횟수 출력
table(flightDF$origin, flightDF$dest)

flights[, .(.N), by=.(origin, dest)]

# 17. 항공사코드(carrier)가 AA에 대해 origin, dest별로 비행횟수 출력
temp <- flightDF[flightDF$carrier=='AA',]
table(temp$origin, temp$dest)

flights[carrier=='AA', .(.N), by=.(origin, dest)]

# 18. 항공사 코드가 AA에 대해, origin, dest, 월별 평균arr_delay, 평균 dep_delay 출력
library(doBy)
temp <- flightDF[flightDF$carrier=='AA',]

summaryBy(arr_delay+dep_delay~origin+dest+month, data=temp, FUN=mean)

aggregate(temp[,c('arr_delay','dep_delay')], 
          by=list(temp$origin,temp$dest, temp$month),
          FUN=mean)

flights[carrier=='AA', .(mean_arr = mean(arr_delay), 
                         mean_dep = mean(dep_delay)),
        by=.(origin, dest, month)]

#  19. dep_delay>0가 참이거나 거짓, arr_delay>0가 참이거나 거짓인 각각의 비행횟수
table(flightDF$dep_delay>0, flightDF$arr_delay>0)

flights[, .(.N), by=.(dep_delay>0, arr_delay>0)]

#  20. Origin==“JFK”에 대해 월별 최대 출발 지연 시간 출력(month로 정렬)
temp <- subset(flightDF, origin=='JFK')
tapply(temp$dep_delay, temp$month, max)
result <- aggregate(temp$dep_delay, by=list(temp$month), max)
result
result[order(result$Group.1),]
library(doBy)
result <- summaryBy(dep_delay ~ month, data=temp, FUN=max)
result
result[order(result$month),]

# 지연 시간순으로 정렬
sort(tapply(temp$dep_delay, temp$month, max))

x <- flights[origin=='JFK', .(max=max(dep_delay)), by=.(month)] # x도 데이터테이블
x[order(month)]
