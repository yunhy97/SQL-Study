create table users (
    userID varchar(20) primary key,
    userPassword varchar(20) not null,
    userName varchar(20) not null,
    userGender varchar(20) not null,
    userEmail varchar(50)
);

insert into users values
('hong','zxcv1234','ȫ�浿','��','hong@gmail.com');

select * from users;

commit;