CREATE TABLE addrbook(
    bnum    NUMBER PRIMARY KEY,
    username    VARCHAR2(20) NOT NULL,
    tel         VARCHAR2(20),
    email       VARCHAR2(30) UNIQUE,
    gender      VARCHAR2(6),
    regdate     TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE SEQUENCE seq_bnum NOCACHE;       -- 자동 순번

INSERT INTO addrbook(bnum, username, tel, email, gender)
VALUES (seq_bnum.NEXTVAL, '이상현', '010-1234-5678', 'test@test.com', '남');
-- 이메일 중복체크
INSERT INTO addrbook(bnum, username, tel, email, gender)
VALUES (seq_bnum.NEXTVAL, '우영우', '010-1234-5678', 'test@test.com', '여');


COMMIT;

SELECT * FROM addrbook;

-- 이메일 khit@kh.kr 찾기
SELECT email FROM addrbook
WHERE email = 'khit@kh.kr';