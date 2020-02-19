--���̺�
drop table vue_user;

create table vue_user(
idx number(8) primary key, --ȸ����ȣ
name varchar2(30), --ȸ�� �̸�
id varchar2(20), --ȸ�� ���̵�
pwd varchar2(20), --��й�ȣ
email varchar2(100), --�̸���,
indate timestamp default systimestamp
);

--������
drop sequence  vue_user_seq;
create sequence vue_user_seq nocache;

-- test data
insert into vue_user (idx,name,id,pwd,email,indate)
values (vue_user_seq.nextval,'��浿','Kim01','1111','kim01@a.b.c',sysdate);
commit;

/*

delete from vue_user;
commit;

-- ȸ�� ���̺� id �÷��� unique ���� ���� �߰�
ALTER table vue_user ADD CONSTRAINT vue_user_id_uk UNIQUE (id);
*/