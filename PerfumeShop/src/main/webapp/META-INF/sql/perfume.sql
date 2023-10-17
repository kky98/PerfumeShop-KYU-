create table if not exists perfume(
	p_id varchar(10) not null,
	p_brand varchar(20),
	p_unitName varchar(30),
	p_unitPrice int,
	p_unitVolume int,
	p_unitsInStock long,
	p_gender varchar(10),
	p_note varchar(40),
	p_topNote varchar(40),
	p_middleNote varchar(40),
	p_baseNote varchar(40),
	p_fileName varchar(20),
	p_concept text,
	primary key(p_id)
)default CHARSET=utf8;