--테이블
drop table vue_user;

create table vue_user(
idx number(8) primary key, --회원번호
name varchar2(30), --회원 이름
id varchar2(20), --회원 아이디
pwd varchar2(20), --비밀번호
email varchar2(100), --이메일,
indate timestamp default systimestamp
);

--시퀀스
drop sequence  vue_user_seq;
create sequence vue_user_seq nocache;

-- test data
insert into vue_user (idx,name,id,pwd,email,indate)
values (vue_user_seq.nextval,'김길동','Kim01','1111','kim01@a.b.c',sysdate);
commit;

/*

delete from vue_user;
commit;

-- 회원 테이블에 id 컬럼에 unique 제약 조건 추가
ALTER table vue_user ADD CONSTRAINT vue_user_id_uk UNIQUE (id);
*/