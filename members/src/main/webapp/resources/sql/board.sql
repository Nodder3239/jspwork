-- 게시판
CREATE TABLE board (
    bno         NUMBER PRIMARY KEY,
    title       VARCHAR2(100),
    content     CLOB,
    createdate  TIMESTAMP DEFAULT SYSTIMESTAMP,
    modifydate  TIMESTAMP,
    hit         NUMBER DEFAULT 0,
    filename    VARCHAR2(50),
    id          VARCHAR2(20) NOT NULL,
    FOREIGN KEY(id) REFERENCES member(id) ON DELETE CASCADE    
);

CREATE SEQUENCE seq_bno NOCACHE;

INSERT INTO board(bno, title, content, id)
VALUES (seq_bno.NEXTVAL, '글제목', '글내용입니다.', 'khit');

SELECT * FROM board ORDER BY bno;

COMMIT;

-- 번호가 1번인 게시글의 조회수를 1 증가
UPDATE board SET hit = hit+1 WHERE bno = 1;