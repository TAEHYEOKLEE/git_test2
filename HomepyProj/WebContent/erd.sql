
/* Drop Tables */

DROP TABLE board CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE board
(
	-- 게시판의 일련번호입니다.
	idx number NOT NULL,
	title varchar2(200) NOT NULL,
	PRIMARY KEY (idx)
);



/* Comments */

COMMENT ON COLUMN board.idx IS '게시판의 일련번호입니다.';



