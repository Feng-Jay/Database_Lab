CREATE TABLE shipper(
	id INT PRIMARY KEY,
	name CHAR(30),
	address CHAR(50)
);

CREATE TABLE carrier(
	id INT PRIMARY KEY,
	name CHAR(30),
	point INT
);

CREATE TABLE waybill(
	id INT PRIMARY KEY,
	goods_name CHAR(30),
	loading_address CHAR(30),
	unloading_address CHAR(30),
	freight INT,
	order_time DATE,
	shipper_id INT REFERENCES shipper(id),
	carrier_id INT REFERENCES carrier(id)
);

CREATE TABLE bid(
	waybill_id INT REFERENCES waybill(id),
	carrier_id INT REFERENCES carrier(id),
	bid_price INT,
	bid_time DATE
);

INSERT INTO shipper(id, name, address) VALUES(1, 'one', '1one');
INSERT INTO shipper(id,name,address) VALUES(2,'two','2two');
INSERT INTO shipper(id, name, address) VALUES(3,'three','3three');
INSERT INTO shipper(id, name, address) VALUES(4,'four','4four');
INSERT INTO shipper(id, name, address) VALUES(5,'five','5five');

INSERT INTO carrier(id, name, point) VALUES(1, 'SF', 100);
INSERT INTO carrier(id, name, point) VALUES(2,'ZT',99);
INSERT INTO carrier(id, name, point)VALUES(3,'YD',98);
INSERT INTO carrier(id, name, point) VALUES(4,'JD',99);
INSERT INTO carrier(id, name, point) VALUES(5,'ST',96);

INSERT INTO waybill(id, goods_name, loading_address,unloading_address,freight,order_time,shipper_id,carrier_id)
VALUES(1,'SWITCH','TJU','NKU',100,'2021-6-6',1,2);
INSERT INTO waybill(id, goods_name, loading_address,unloading_address,freight,order_time,shipper_id,carrier_id)
VALUES(2,'SWITCH1','TJU','NKU',100,'2021-6-7',2,3);
INSERT INTO waybill(id, goods_name, loading_address,unloading_address,freight,order_time,shipper_id,carrier_id)
VALUES(3,'SWITCH2','TJU','NKU',100,'2021-6-8',3,5);
INSERT INTO waybill(id, goods_name, loading_address,unloading_address,freight,order_time,shipper_id,carrier_id)
VALUES(4,'SWITCH3','TJU','NKU',100,'2021-6-9',2,2);
INSERT INTO waybill(id, goods_name, loading_address,unloading_address,freight,order_time,shipper_id,carrier_id)
VALUES(5,'SWITCH4','TJU','NKU',100,'2021-6-10',4,2);

INSERT INTO bid(waybill_id, carrier_id,bid_price,bid_time) VALUES(1,2,100,'2021-6-9');
INSERT INTO bid(waybill_id, carrier_id,bid_price,bid_time) VALUES(2,3,110,'2021-6-9');
INSERT INTO bid(waybill_id, carrier_id,bid_price,bid_time) VALUES(3,4,100,'2021-6-9');
INSERT INTO bid(waybill_id, carrier_id,bid_price,bid_time) VALUES(4,1,100,'2021-6-9');
INSERT INTO bid(waybill_id, carrier_id,bid_price,bid_time) VALUES(5,5,100,'2021-6-9');