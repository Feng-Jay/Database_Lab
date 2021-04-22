CREATE TABLE shipper(
	id INT PRIMARY KEY,
	name CHAR(30),
	address CHAR(50)
)

CREATE TABLE carrier(
	id INT PRIMARY KEY,
	name CHAR(30),
	point INT
)

CREATE TABLE waybill(
	id INT PRIMARY KEY,
	goods_name CHAR(30),
	loading_address CHAR(30),
	unloading_address CHAR(30),
	freight INT,
	order_time DATE,
	shipper_id INT REFERENCES shipper(id),
	carrier_id INT REFERENCES carrier(id)
)

CREATE TABLE bid(
	waybill_id INT REFERENCES waybill(id),
	carrier_id INT REFERENCES carrier(id),
	bid_price INT,
	bid_time DATE
)
