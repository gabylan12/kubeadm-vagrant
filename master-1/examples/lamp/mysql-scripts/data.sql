CREATE TABLE MyGuests (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
firstname VARCHAR(30) NOT NULL,
lastname VARCHAR(30) NOT NULL,
email VARCHAR(50),
reg_date TIMESTAMP
) ;

insert into MyGuests values (0,"benny","hill","yeha",now());
insert into MyGuests values (0,"guybrush","threepwood","yeha",now());

