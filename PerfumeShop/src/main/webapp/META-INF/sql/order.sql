CREATE TABLE if not exists orders(
birth timestamp not null default now(),
orderId VARCHAR(20),
orderName VARCHAR(20),
orderTel VARCHAR(20),
orderAddress text,
orderPerfumes text,
orderPerfumeNum text
orderState int not null default 1,
)default CHARSET=utf8;