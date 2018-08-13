
/* Drop Tables */

DROP TABLE comments CASCADE CONSTRAINTS;
DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE board
(
	-- 게시판의 일련번호
	idx number NOT NULL,
	title varchar2(500) NOT NULL,
	contents varchar2(5000) NOT NULL,
	postdate date DEFAULT sysdate NOT NULL,
	-- 회원관리 테이블에서 기본키로 사용함
	user_id varchar2(30) NOT NULL,
	PRIMARY KEY (idx)
);


CREATE TABLE comments
(
	com_idx number NOT NULL,
	com_name varchar2(30) NOT NULL,
	com_contents varchar2(2000) NOT NULL,
	com_postdate date DEFAULT sysdate,
	com_pass varchar2(30) NOT NULL,
	-- 게시판의 일련번호
	board_idx number NOT NULL,
	PRIMARY KEY (com_idx)
);


CREATE TABLE member
(
	-- 회원관리 테이블에서 기본키로 사용함
	id varchar2(30) NOT NULL,
	pass varchar2(30) NOT NULL,
	name varchar2(30) NOT NULL,
	tel varchar2(30) NOT NULL,
	mobile varchar2(30) NOT NULL UNIQUE,
	email varchar2(30) NOT NULL UNIQUE,
	zipcode varchar2(30) NOT NULL,
	addr1 varchar2(30) NOT NULL,
	addr2 varchar2(30) NOT NULL,
	PRIMARY KEY (id)
);



/* Create Foreign Keys */

ALTER TABLE comments
	ADD FOREIGN KEY (board_idx)
	REFERENCES board (idx)
;


ALTER TABLE board
	ADD FOREIGN KEY (user_id)
	REFERENCES member (id)
;



