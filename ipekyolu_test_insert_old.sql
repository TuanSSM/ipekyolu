 -- Install pgcrypto
CREATE EXTENSION pgcrypto; 

 -- Insert Customer Data
INSERT INTO "Customers"
    ("tr_id","email","joined_at","name","surname","cryptpwd","md5pwd")
VALUES
    (32165498710,'mehmet.karaca@mail.com','2020/05/01','Mehmet','Karaca', crypt('test', gen_salt('md5')), md5('test')),
    (32165498712,'hakan.karabatan@mail.com','2020/05/19','Hakan','Karabatan', crypt('test', gen_salt('md5')), md5('test')),
    (32165498714,'kazim.korhan@mail.com','2020/05/29','Kazim','Korhan', crypt('test', gen_salt('md5')), md5('test')),
    (32165498716,'asim.cakar@mail.com','2020/05/18','Asim','Cakar', crypt('test', gen_salt('md5')), md5('test')),
    (32165498718,'mehmet.ekici@mail.com','2020/05/26','Mehmet','Ekici', crypt('test', gen_salt('md5')), md5('test')),
    (32165498720,'jale.karaca@mail.com','2020/05/09','Jale','Karaca', crypt('test1', gen_salt('md5')), md5('test1')),
    (32165498722,'feriha.aslan@mail.com','2020/04/04','Feriha','Aslan', crypt('test1', gen_salt('md5')), md5('test1')),
    (32165498724,'ayca.korhan@mail.com','2020/03/03','Ayca','Korhan', crypt('test1', gen_salt('md5')), md5('test1')),
    (32165498726,'sinem.cakir@mail.com','2020/02/01','Sinem','Cakir', crypt('test1', gen_salt('md5')), md5('test1')),
    (32165498728,'jale.yilmaz@mail.com','2020/05/06','Jale','Yilmaz', crypt('test1', gen_salt('md5')), md5('test1')),
    (32165498730,'furkan.hasim@mail.com','2020/05/02','Furkan','Hasim', crypt('test2', gen_salt('md5')), md5('test2')),
    (32165498732,'fehmi.aslan@mail.com','2020/05/02','Fehmi','Aslan', crypt('test2', gen_salt('md5')), md5('test2')),
    (32165498734,'furkan.korhan@mail.com','2020/11/06','Furkan','Korhan', crypt('test2', gen_salt('md5')), md5('test2')),
    (32165498736,'ferruh.cakar@mail.com','2020/02/13','Ferruh','Cakar', crypt('test2', gen_salt('md5')), md5('test2')),
    (32165498738,'furkan.hazine@mail.com','2020/03/12','Furkan','Hazine', crypt('test2', gen_salt('md5')), md5('test2')),
    (32165498740,'selen.karaca@mail.com','2020/12/22','Selen','Karaca', crypt('test3', gen_salt('md5')), md5('test3')),
    (32165498742,'hilal.aslan@mail.com','2020/03/18','Hilal','Aslan', crypt('test3', gen_salt('md5')), md5('test3')),
    (32165498744,'selen.korhan@mail.com','2020/05/07','Selen','Korhan', crypt('test3', gen_salt('md5')), md5('test3')),
    (32165498746,'selen.cakar@mail.com','2020/05/29','Selen','Cakar', crypt('test3', gen_salt('md5')), md5('test3')),
    (32165498748,'aydin.ayan@mail.com','2020/05/26','Aydin','Ayan', crypt('test3', gen_salt('md5')), md5('test3')),
    (32165498750,'aysu.karaca@mail.com','2020/05/30','Aysu','Karaca', crypt('test4', gen_salt('md5')), md5('test4')),
    (32165498752,'feride.aslan@mail.com','2020/02/06','Feride','Aslan', crypt('test4', gen_salt('md5')), md5('test4')),
    (32165498754,'feride.korhan@mail.com','2020/01/26','Feride','Korhan', crypt('test4', gen_salt('md5')), md5('test4')),
    (32165498756,'sema.sarikaya@mail.com','2018/03/11','Sema','Sarikaya', crypt('test4', gen_salt('md5')), md5('test4')),
    (32165498758,'betul.yilmaz@mail.com','2019/01/01','Betul','Yilmaz', crypt('test4', gen_salt('md5')), md5('test4'));
  

 -- Insert Suppliers Data
INSERT INTO "Suppliers"
(supplier_id, supplier_name, owner_name, company_type, company_profile, stars, points, contact_info, bank_account, tax_office_no, registry_records)
VALUES
(1, 'Sasmung Digital', 'Idea Sasmung', 'Sasmung Digital', 'supplier', 4.8, 7.7, 'sasmung@sasmung.com', 'TR145478969852145698785236', 04789, 111111 ),
(2, 'Magical Transports', 'Albus Ronald Potter', 'Magical Transports', 'producer', 2.4, 5.1, 'potter@hogsmade.com', 'TR787412569878969998745414', 16587, 222222),
(3, 'Beautiful Diamonds', 'Kin Kirdishian', 'beautiful Diamonds', 'distributor', 4.7, 8.1, 'diamond@diamond.com', 'TR457896321474125896321478', 81715, 333333),
(4, 'Satan Komputer', 'Anton Danton', 'Teknoloji firmasi', 'satici', 6.6, 6.6, 'antondanton@mail.com', 'TR176523469852145698785236', 04789, 184121 ),
(5, 'Medya Kart', 'Trak Aydem', 'diger', 'satici', 5.2, 4.6, 'trak@aydem.com', 'TR5235772378969998745414', 19527, 211332);


 -- Insert Payment Method Reference Codes
INSERT INTO "Ref_Payment_Methods"
(payment_method_code, payment_method_description) 
VALUES
(1, 'kredi karti'),
(2, 'banka karti'),
(3, 'havale/eft');


 -- Insert Product Categories Reference Codes
INSERT INTO "Ref_Product_Categories"
(product_category_code, parent_product_category_code, product_category_description)
VALUES
(100,NULL,'Elektronics'),
(200,NULL,'Fashion'),
(300,NULL,'Sports'),
(400,NULL,'Auto, Garden, Construction'),
(101,100,'Computer/Tablet'),
(102,100,'Mobile Phones'),
(201,200,'Accesories'),
(301,300,'Bicycle'),
(401,400,'Security');


 -- Insert Order Item Status Reference Codes
INSERT INTO "Ref_Order_Status_Codes"
(order_status_code, order_status_description)
VALUES
(1,'Waiting for approval.'),
(2,'Approved. Prepairing the order.'),
(3,'On shipment.'),
(4,'Delivered.'),
(5,'Returned to supplier');


 -- Insert Invoice Status Reference Codes
INSERT INTO "Ref_Invoice_Status_Codes"
(invoice_status_code, invoice_status_description)
VALUES
(1,'Prepairing.'),
(2,'Invoice prepaired.');


 -- Insert Order Status Reference Codes
INSERT INTO "Ref_Order_Item_Status_Codes"
(order_item_status_code, order_item_status_description)
VALUES
(1,'In stocks'),
(2,'Out of stocks');


 -- Insert Product Data
INSERT INTO "Products"
(product_id, product_category_code, product_name, product_description,product_rating)
VALUES
(1,102,'Sasmung Universe Note 100','The best Endroid phone for the lowest price', 3.9),
(2,301,'Nimbuls 2020','A bicycle that makes you fly',4.7),
(3,201,'Green Diamond Ultra Deluxe','Best gift to your beloved ones', 0.1);


 -- Insert Product Options
INSERT INTO "Product_Options"
(product_id, option_name)
VALUES
(1, 'robotic gray'),
(2, 'large size'),
(3, '20 grams');


 -- Insert Product Comments
INSERT INTO "Product_Comments"
(customer_id, product_id, comment_text, comment_date, comment_rating)
VALUES
(77,1,'The best phone I''ve ever had', '2020/03/12', 4.5),
(83,2, 'Fake description! I can not fly with it.', '2020/01/19', 1.5),
(90,3, 'Really beautiful. I can see my face on it.', '2020/04/20', 4.0);


 -- Insert Product Supplier's Data
INSERT INTO "Product_Supplier"
(product_id, supplier_id, rma_types, product_price, discounted_price, product_stock)
VALUES
(1,1,'A',8560,8559,1000),
(2,2,'B',1500,1500,350),
(3,3,'A',2550,2380,150),
(1,4,'B',8880,6660,666),
(2,5,'E',1625,1600,123);


 -- Insert Addresses Data
INSERT INTO "Addresses"
(address_id, customer_id, country, city, region, postal_code, street_no, apt_no, door_no)
VALUES
(1,77,'TR','Ankara','Yenimahalle',06370,1844,6,8),
(2,83,'TR','Istanbul','Kadikoy',34879,1547,'Gurses Apt',6),
(3,90,'TR','Izmir','Buca',36250,'Ataturk cd',15,7);


 -- Insert Order Data
INSERT INTO "Orders"
(order_id, customer_id, order_status_code, address_id, date_order_placed, order_details)
VALUES
(1,77,4,1,'2020/03/09',NULL),
(2,83,5,2,'2020/01/15',NULL),
(3,90,4,3,'2020/04/17',NULL);


 -- Insert Order Items Data
INSERT INTO "Order_Items"
(order_item_id, product_id, order_id, order_item_status_code, order_item_quantity, order_item_price, rma_type, rma_issued_by, rma_issued_date, other_order_item_details)
VALUES
(1,1,1,1,2, 17120.00, 'A', NULL, NULL, NULL),
(2,2,2,1,1, 1500.00, 'B',NULL, NULL, NULL),
(3,3,3,1,2, 5100.00, 'A', NULL, NULL, NULL);


 -- Insert Invoice Data
INSERT INTO "Invoices"
(invoice_id, order_id, invoice_status_code, address_id, invoice_date, invoice_details)
VALUES
(1,1,2,1,'2020/03/10','2x Sasmung Universe Note 100 for 17120.00 TL'),
(2,2,2,2,'2020/01/13','1x Nimbuls 2020 for 1500'),
(3,3,2,3,'2020/04/15','2x Green Diamond Ultra Deluxe');


 -- Insert Shipment Data
INSERT INTO "Shipments"
(shipment_tracking_number, order_id, invoice_id, shipment_date, shipment_status)
VALUES
(1111111111,1,1,'2020/03/11', 'Delivered'),
(2111111112,2,2,'20020/01/13', 'Returned'),
(3216549890,3,3,'2020/04/15', 'Delivered');


 -- Insert Shipment Items Data
INSERT INTO "Shipment_Items"
(shipment_tracking_number, order_item_id)
VALUES
(1111111111,1),
(2111111112,2),
(3216549890,3);


 -- Insert Fast Pay Methods
INSERT INTO "Payments"
(payment_id, invoice_id, payment_date, payment_amount)
VALUES
(1,1,'2020/03/09',17120.00),
(2,2,'2020/01/15', 1500.00),
(3,3,'2020/04/17', 5100.00);

 /*
 -- Insert Fast Pay Methods
 INSERT INTO "Fast_Pay_Method"
(method_id, customer_id, payment_method_code, credit_card_no, card_exp_date, card_sec_no, mobile_phone)
VALUES
(1,1,1,1111111111111111,'2024/05/00',111,1111111111),
(2,3,2,2222222222222222,'2023/08/00',222,2222222222),
(3,5,3,3333333333333333,'2024/07/00',333,3333333333);


 -- Insert Product Pictures
INSERT INTO "Product_Pictures"
(product_id)
VALUES
(1),
(2),
(3);
*/
