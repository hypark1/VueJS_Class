--테이블
drop table vue_user;

create table board(
idx number(8) primary key,
name varchar2(30),
subject varchar2(100),
content varchar2(500),
filename varchar2(100) default 'noimage.png',
filesize number(8) default 0,
wdate timestamp default systimestamp
);

--시퀀스
drop sequence  board_seq;
create sequence board_seq nocache;

-- test data
insert into board (idx,name,subject,content)
values (board_seq.nextval,'김길동','테스트 입니다','Vue Board Test입니다');
commit;