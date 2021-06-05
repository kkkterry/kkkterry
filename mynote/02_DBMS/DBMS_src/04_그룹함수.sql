-- ★<총 연습문제>

-- 1. 사원 테이블에서 인원수,최대 급여,최소 급여,급여의 합을 계산하여 출력
SELECT COUNT(*), MAX(SAL), MIN(SAL), SUM(SAL)
    FROM EMP;
-- 2. 사원테이블에서 업무별 인원수를 구하여 출력하는 SELECT 문장을 작성하여라.
SELECT JOB, COUNT(*)
    FROM EMP
    GROUP BY JOB;
--- 3. 사원테이블에서 최고 급여와 최소 급여의 차이는 얼마인가 출력하는 SELECT문장을 작성하여라.
SELECT MAX(SAL)-MIN(SAL)
    FROM EMP;
-- 4. 각 부서별로 인원수, 급여 평균, 최저 급여, 최고 급여, 급여의 합을 출력하되 급여의 합이 많은 순으로 출력하라.
SELECT DEPTNO, COUNT(*), TRUNC(AVG(SAL)), MIN(SAL), MAX(SAL), SUM(SAL)
    FROM EMP
    GROUP BY DEPTNO
    ORDER BY DEPTNO;
-- 5. 부서별, 업무별 그룹하여 결과를 부서번호, 업무, 인원수, 급여의 평균, 급여의 합을 
    --구하여 출력하라(출력결과는 부서번호, 업무순으로 오름차순 정렬)
SELECT DEPTNO, JOB, COUNT(*), AVG(SAL), SUM(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
-- 6. 업무별, 부서별 그룹하여 결과를  업무, 부서번호, 인원수, 급여의 평균, 급여의 합을 구하여 
-- 출력하라.(출력결과는 업무순, 부서번호 순 오름차순 정렬)
SELECT JOB, DEPTNO, COUNT(*), AVG(SAL), SUM(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
--7. 사원수가 5명이상 넘는 부서번호와 사원수를 출력하시오.
SELECT DEPTNO, COUNT(*)
    FROM EMP
    GROUP BY DEPTNO
    HAVING COUNT(*)>=5;
-- 8. 사원수가 5명이상 넘는 부서명과 사원수를 출력하시오
SELECT DNAME, COUNT(*)
    FROM EMP W, DEPT D
    WHERE W.DEPTNO=D.DEPTNO
    GROUP BY DNAME
    HAVING COUNT(*)>=5;
--9. 사원 테이블에서 업무별 급여의 평균이 3000이상인 업무에 대해서 업무명, 평균 급여, 
--급여의 합을 구하여 출력하라
SELECT JOB, AVG(SAL), SUM(SAL)
    FROM EMP
    GROUP BY JOB
    HAVING AVG(SAL)>=3000;
--10. 사원테이블에서 급여합이 5000을 초과하는 각 업무에 대해서 업무와 급여합계를 출력하라 
        --단, 급여 합계로 내림차순 정렬하라.
SELECT JOB, SUM(SAL)
    FROM EMP
    GROUP BY JOB
    HAVING SUM(SAL)>5000
    ORDER BY SUM(SAL) DESC;
--11. 부서별 급여평균, 부서별 급여합계, 부서별 최소급여를 출력하라.
SELECT TRUNC(AVG(SAL)), SUM(SAL), MIN(SAL)
    FROM EMP
    GROUP BY DEPTNO;
    
--12. 위의 11번을 수정하여, 부서별 급여평균 최대치, 부서별 급여합의 최대치, 
            --부서별 최소급여의 최대치를 출력하라.
SELECT MAX(TRUNC(AVG(SAL))), MAX(SUM(SAL)), MIN(MIN(SAL))
    FROM EMP
    GROUP BY DEPTNO; 

--13. 사원 테이블에서 아래의 결과를 출력하는 SELECT 문장을 작성하여라.(년도별 연봉합)
--   H_YEAR	COUNT(*)	MIN(SAL)	MAX(SAL)	AVG(SAL)	SUM(SAL)
--     80	  1		    800		    800		    800		    800
--	   81	 10		    950		    5000	    2282.5	  22825
--	   82	  2		    1300	    3000	   2150		   4300
--	   83	  1		    1100	    1100	    1100	   1100
SELECT TO_CHAR(HIREDATE, 'YY') "H_YEAR", COUNT(*), MIN(SAL), MAX(SAL), AVG(SAL), SUM(SAL)
    FROM EMP
    GROUP BY TO_CHAR(HIREDATE, 'YY')
    ORDER BY TO_CHAR(HIREDATE, 'YY');

-- 14.  사원테이블에서 아래의 결과를 출력하는 SELECT 문 작성
--  1980     1	
--  1981     10
--  1982     2
--  1983     1
--  total    14	
SELECT NVL(TO_CHAR(HIREDATE, 'YYYY'),'TOTAL'), COUNT(*)
    FROM EMP
    GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'));

--15. 사원테이블에서 최대급여, 최소급여, 전체급여합, 평균을 구하시오
SELECT MAX(SAL), MIN(SAL), SUM(SAL), TRUNC(AVG(SAL))
    FROM EMP;
    
--16. 사원테이블에서 부서별 인원수를 구하시오
SELECT DEPTNO, COUNT(*)
    FROM EMP
    GROUP BY DEPTNO;

--17. 사원 테이블에서 부서별 인원수가 6명이상인 부서코드를 구하시오
SELECT DEPTNO 
    FROM EMP
    GROUP BY DEPTNO
    HAVING COUNT(*)>=6;

--18. 사원테이블에서 급여가 높은 순서대로 등수를 부여하여 다음과 같은 결과가 나오게 하시오. 
-- (힌트 self join, group by, count사용)
--ENAME	    등수
--________________________
--KING		1
--SCOTT		2

SELECT E1.ENAME, E1.SAL, E2.ENAME, E2.SAL
    FROM EMP E1, EMP E2
    WHERE E1.SAL<E2.SAL(+); -- 1단계 : SELF JOIN
  
  SELECT E1.ENAME, COUNT(E2.ENAME)+1 "RANK"
    FROM EMP E1, EMP E2
    WHERE E1.SAL<E2.SAL(+)
    GROUP BY E1.ENAME
    ORDER BY RANK; -- 완성단계 : GROUP BY, COUNT