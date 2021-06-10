<총 연습문제>
-- 1. 부서명과 사원명을 출력하는 용도의 뷰, DNAME_ENAME_VU 를 작성하시오
CREATE OR REPLACE VIEW EMPv0
    AS SELECT DNAME, ENAME FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO;
SELECT * FROM EMPv0;

-- 2. 사원명과 직속상관명을 출력하는 용도의 뷰,  WORKER_MANAGER_VU를 작성하시오
CREATE OR REPLACE VIEW WORKER_MANAGER_VU
    AS SELECT W.ENAME "부사수", M.ENAME "사수" FROM EMP W, EMP M WHERE W.MGR = M.EMPNO;
SELECT * FROM WORKER_MANAGER_VU;

-- 3. 부서별 급여합계 등수를 출력하시오(부서번호, 급여합계, 등수). ? 친구출제
SELECT DEPTNO, SUM, ROWNUM RANK 
    FROM (SELECT DEPTNO, SUM(SAL) SUM
                FROM EMP GROUP BY DEPTNO ORDER BY SUM DESC);

-- 3-1. 부서별 급여합계 등수가 2~3등인 부서번호, 급여합계, 등수를 출력하시오.
SELECT DEPTNO, SUM, RANK
  FROM (SELECT DEPTNO, SUM, ROWNUM RANK
          FROM (SELECT DEPTNO, SUM(SAL) SUM 
                FROM EMP GROUP BY DEPTNO ORDER BY SUM desc))
                     WHERE RANK>=2 AND RANK<=3;

-- 4. 사원테이블에서 사번, 사원명, 입사일을 입사일이 최신에서 오래된 사원 순으로 정렬하시오
SELECT EMPNO, ENAME, HIREDATE FROM EMP ORDER BY HIREDATE DESC;

-- 5. 사원테이블에서 사번, 사원명, 입사일을 입사일이 최신에서 오래된 사원 5명을 출력하시오
SELECT EMPNO, ENAME, HIREDATE
    FROM (SELECT EMPNO, ENAME, HIREDATE FROM EMP ORDER BY HIREDATE DESC)
            WHERE ROWNUM<=5;
-- 6. 사원 테이블에서 사번, 사원명, 입사일을 최신부터 오래된 순으로 6번째로 늦은 사원부터 10번째 사원까지 출력
SELECT RN, EMPNO, ENAME, ENAME, HIREDATE
  FROM (SELECT ROWNUM RN, A.*
            FROM (SELECT EMPNO, ENAME, HIREDATE FROM EMP ORDER BY HIREDATE DESC) A)
  WHERE RN>=6 AND RN<=10;
