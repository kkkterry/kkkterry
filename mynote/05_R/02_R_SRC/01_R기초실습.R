################################
##### 2장. R Language 기초 #####
################################
iris
################################
##### 2장. R Language 기초 #####
################################
# 1. 도움말 기능
# 1.1 도움말
iris
edit(iris)   #데이터 편집기에 iris나온다.
? iris      
help(iris)# isis 도움말 출력
# 1.2 검색기능
??iris
help.search('iris')
help.search("iris")
################################
##### 2장. R Language 기초 #####
################################
# 1. 도움말 기능
# 1.1 도움말
iris
help.search('iris')
# 1.3 패키지 도움말
library(help="datasets")
# 1.4 함수 도움말
methods(as)   #함수목록 출력
args(data)    #함수의 인자 출력
as.integer(1.25)
?as.integer
x <- -1:1
x
x <- c(1,2,3)
x
x <- pi * c(-1:1, 10)
x
as.integer(x)
example("as.integer") #예제 출력력
data <- c(10,20,30)
mean(data)
?mean
example(mean)
# 1.5 주석
# 주석
# 자동완성 : Tab
R.version
# 1.6 정보
iris
edit(iris)
attributes(iris)      #개체 속성 조회
edit(iris)
dim(available.packages()) # CRAN site에 업로드된 패키지 갯수
available.packages()
install.packages("stringr")
library(stringr)
? str_extract
data <- '홍길동35이순신45김말똥12'
data
str_extract(data, '[1-9]{2}')
str_extract_all(data, '[1-9]{2}')
detach("package:stringr", unload = TRUE)
str_extract(data, '[1-9]{2}')
iris
?iris
detach("package:datasets", unload = TRUE)
iris
# 메모리에 로드 없이 데이터 사용
data(iris, package="datasets")
# 메모리에 로드 없이 데이터 사용
rm(data)
data(iris, package="datasets")
iris2 <- data(iris, package="datasets")
iris2
iris
detach("package:datasets", unload = TRUE)
iris
source("C:/bigdata/src/06_R/2장_R Language 기초.R", encoding = 'UTF-8')
