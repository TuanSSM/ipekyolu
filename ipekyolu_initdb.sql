-- Create DATABASE
--SELECT 'CREATE DATABASE hepsiorada'
--WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'hepsiorada')
SET timezone = 'Europe/Istanbul';

-- Create types
CREATE TYPE sex AS ENUM ('M', 'F', 'O'); -- Male, Female, Others
CREATE TYPE rma_type AS ENUM ('A','B','C','D','E','BCDE');
CREATE TYPE ord_met AS ENUM ('CC','DC');        -- Credit Card, Debit Card
CREATE TYPE inv_stat AS ENUM ('A','S','C','R');      -- Awaiting, Shipped, Cancelled, Rewised
CREATE TYPE ship_stat AS ENUM ('A','P','T','D','R'); -- Awaiting, Processing, in Transit, Delivered, Returned
CREATE TYPE pay_stat AS ENUM ('P','S','C','R');      -- Pending Success Cancelled Rejected
CREATE TYPE ord_stat AS ENUM ('AP','OH','OR','OP','AS','S','D','C','R'); -- Awaiting Payment, On Hold, Order Received, Order Packed, Awaiting Shipment, Shipped, Delivered, Cancelled, Refunded


-- Create table Customers
CREATE TABLE "Customers" (
  "customer_id"   SERIAL PRIMARY KEY,
  "tr_id"         NUMERIC(11) NOT NULL,
  "email"         VARCHAR(50) NOT NULL,
  "joined_at"     DATE        NOT NULL,
  "name"          VARCHAR(35) NOT NULL,
  "surname"       VARCHAR(35) NOT NULL,
  "cryptpwd"      TEXT        NOT NULL,
  "md5pwd"        TEXT        NOT NULL,
  "birth_date"    DATE,
  "gender"        sex,
  "phone"         NUMERIC(10),
  "first_order"   BOOLEAN     NOT NULL DEFAULT '1',
  "tax_no"        NUMERIC(10),
  "tax_office"    VARCHAR(20)

-- Create table Suppliers
CREATE TABLE "Suppliers" (
  "supplier_id"      SERIAL PRIMARY KEY,
  "supplier_name"    VARCHAR(50)  NOT NULL,
  "owner_name"       VARCHAR(35)  NOT NULL,
  "registry_records" CHAR(26)     NOT NULL,
  "company_type"     VARCHAR(25)  NOT NULL,
  "company_profile"  VARCHAR(25)  NOT NULL,
  "stars"            NUMERIC(2,1),
  "points"           NUMERIC(4,1),
  "contact_info"     VARCHAR(50)  NOT NULL,
  "bank_account"     CHAR(26)     NOT NULL,
  "registry_records" CHAR(26)     NOT NULL,
  "tax_no"           NUMERIC(10)  NOT NULL,
  "tax_office"       VARCHAR(20)  NOT NULL
);

-- Create table Addresses
CREATE TABLE "Addresses" (
  "address_id"    SERIAL PRIMARY KEY,
  "customer_id"   INT,
  "supplier_id"   INT,
  "address_line1" VARCHAR(40) NOT NULL,
  "address_line2" VARCHAR(40) NOT NULL,
  "address_line3" VARCHAR(40) NOT NULL,
  "country"       CHAR(2) NOT NULL,
  "city"          VARCHAR(20) NOT NULL,
  "region"        VARCHAR(20),
  "postal_code"   NUMERIC(5) NOT NULL,
  FOREIGN KEY ("customer_id")
      REFERENCES  "Customers" ("customer_id")
      ON DELETE CASCADE,
  FOREIGN KEY ("supplier_id")
      REFERENCES  "Suppliers" ("supplier_id")
      ON DELETE CASCADE
);

/* This part is removed since necessary data types defined
-- Create table Ref_Invoice_Status_Codes
CREATE TABLE "Ref_Invoice_Status_Codes" (
  "invoice_status_code"        SERIAL PRIMARY KEY,
  "invoice_status_description" VARCHAR(50) NOT NULL
);

-- Create table Ref_Order_Status_Codes
CREATE TABLE "Ref_Order_Status_Codes" (
  "order_status_code"        SERIAL PRIMARY KEY,
  "order_status_description" VARCHAR(50) NOT NULL
);

-- Create table Ref_Order_Item_Status_Codes
CREATE TABLE "Ref_Order_Item_Status_Codes" (
  "order_item_status_code"        SERIAL PRIMARY KEY,
  "order_item_status_description" VARCHAR(50) NOT NULL
);

-- Create table Ref_Payment_Methods
CREATE TABLE "Ref_Payment_Methods" (
  "payment_method_code"        SERIAL PRIMARY KEY,
  "payment_method_description" VARCHAR(50) NOT NULL
);
*/

-- Create table Product_Categories
CREATE TABLE "Product_Categories" (
  "category_code"        SERIAL PRIMARY KEY,
  "category_description" VARCHAR(50) NOT NULL,
  "parent_category_code" INT REFERENCES  "Product_Categories" ("category_code")
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- Create table Products
CREATE TABLE "Products" (
  "product_id"            SERIAL PRIMARY KEY,
  "product_name"          VARCHAR(50) NOT NULL,
  "product_description"   TEXT,
  "product_rating"        NUMERIC(2,1),
  "category_code" INT REFERENCES "Product_Categories" ("category_code")
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

-- Create table Orders
CREATE TABLE "Orders" (
  "order_id"          SERIAL PRIMARY KEY,
  "customer_id"       INT NOT NULL,
  "order_status_code" ord_stat DEFAULT 'AP',
  "address_id"        INT NOT NULL,
  "order_date"        DATE NOT NULL,
  "order_time"        TIMESTAMP NOT NULL,
  "order_details"     VARCHAR(50),
  FOREIGN KEY ("customer_id")
      REFERENCES "Customers" ("customer_id"),
  FOREIGN KEY ("address_id")
      REFERENCES "Addresses" ("address_id")
      ON DELETE RESTRICT
);

-- Create table Invoices
CREATE TABLE "Invoices" (
  "invoice_id"          SERIAL PRIMARY KEY,
  "order_id"            INT NOT NULL,
  "invoice_status_code" inv_stat DEFAULT 'A',
  "address_id"          INT NOT NULL,
  "invoice_date"        DATE NOT NULL,
  "invoice_time"        TIMESTAMP NOT NULL,
  "e_invoice"           BOOLEAN DEFAULT 'FALSE',
  "invoice_details"     VARCHAR(50),
  FOREIGN KEY ("order_id")
      REFERENCES "Orders" ("order_id"),
  FOREIGN KEY ("address_id")
      REFERENCES "Addresses" ("address_id")
);

-- Create table Shipments
CREATE TABLE "Shipments" (
  "shipment_tracking_number" NUMERIC(10) PRIMARY KEY,
  "order_id"                 INT         NOT NULL,
  "invoice_id"               INT         NOT NULL,
  "shipment_company"         VARCHAR(20) NOT NULL,
  "shipment_date"            DATE        NOT NULL,
  "shipment_time"            TIMESTAMP   NOT NULL,
  "shipment_status"          ship_stat   DEFAULT 'A',
  FOREIGN KEY ("order_id")
      REFERENCES "Orders" ("order_id"),
  FOREIGN KEY ("invoice_id")
      REFERENCES  "Invoices" ("invoice_id")
);

-- Create table Fast_Pay_Method
CREATE TABLE "Fast_Pay_Method" (
  "method_id"           SERIAL PRIMARY KEY,
  "customer_id"         INT         NOT NULL,
  "payment_method_code" pay_met     NOT NULL,
  "cc_no_12"            bytea       NOT NULL, --Encrypted
  "cc_no_4"             NUMERIC(4)  NOT NULL,
  FOREIGN KEY ("customer_id")
      REFERENCES "Customers" ("customer_id"),
);

-- Create table Order_Items
CREATE TABLE "Order_Items" (
  "order_item_id"            SERIAL PRIMARY KEY,
  "product_id"               INT NOT NULL,
  "option_id"                INT NOT NULL,
  "order_id"                 INT NOT NULL,
  "order_item_status_code"   ord_stat DEFAULT 'AP',
  "order_item_quantity"      INT NOT NULL DEFAULT '1',
  "order_item_price"         MONEY NOT NULL CHECK ("order_item_price" >= 0.00),
  "rma_type"                 rma_type,
  "rma_issued_by"            INT,
  "rma_issued_date"          DATE,
  "other_order_item_details" VARCHAR(15),
  FOREIGN KEY ("product_id")
      REFERENCES "Products" ("product_id")
      ON UPDATE CASCADE,
  FOREIGN KEY ("order_id")
      REFERENCES "Orders" ("order_id")
      ON UPDATE CASCADE,
  FOREIGN KEY ("option_id")
      REFERENCES "Product_Options" ("option_id")
      ON UPDATE CASCADE
);

-- Create table Shipment_Items
CREATE TABLE "Shipment_Items" (
  "shipment_item_id"         SERIAL PRIMARY KEY,
  "shipment_tracking_number" NUMERIC(10) REFERENCES "Shipments" ("shipment_tracking_number"),
  "order_item_id" INT REFERENCES "Order_Items" ("order_item_id")
      ON UPDATE CASCADE
);

-- Create table Payments
CREATE TABLE "Payments" (
  "payment_id"     SERIAL PRIMARY KEY,
  "payment_amount" MONEY     NOT NULL,
  "payment_date"   DATE      NOT NULL,
  "payment_time"   TIMESTAMP NOT NULL,
  "payment_status" pay_stat DEFAULT 'P',
  "invoice_id"     INT REFERENCES  "Invoices" ("invoice_id")
);

-- Create table Product_Supplier
CREATE TABLE "Product_Supplier" (
  "product_supplier_id" SERIAL PRIMARY KEY,
  "product_id"          INT NOT NULL,
  "supplier_id"         INT NOT NULL,
  "rma_types"           rma_type,
  "product_price"       MONEY NOT NULL,
  "discounted_price"    MONEY,
  "product_stock"       INT NOT NULL,
  CONSTRAINT CHK_Product CHECK ("product_price" >= 0.00 AND "discounted_price" >= 0.00),
  FOREIGN KEY ("product_id")
      REFERENCES "Products" ("product_id")
      ON UPDATE CASCADE,
  FOREIGN KEY ("supplier_id")
      REFERENCES "Suppliers" ("supplier_id")
      ON DELETE CASCADE
      ON UPDATE CASCADE
);


-- Create table Product_Comments
CREATE TABLE "Product_Comments" (
  "comment_id"     SERIAL PRIMARY KEY,
  "customer_id"    INT NOT NULL,
  "product_id"     INT NOT NULL,
  "comment_text"   TEXT NOT NULL,
  "comment_date"   DATE NOT NULL,
  "comment_rating" NUMERIC(2,1),
  FOREIGN KEY ("customer_id")
      REFERENCES "Customers" ("customer_id")
      ON DELETE RESTRICT,
  FOREIGN KEY ("product_id")
      REFERENCES "Products" ("product_id")
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

-- Create table Product_Options
CREATE TABLE "Product_Options" (
  "option_id" SERIAL PRIMARY KEY,
  "option_name" VARCHAR(25) NOT NULL,
  "product_id" INT REFERENCES "Products" ("product_id")
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- Create table Product_Pictures
CREATE TABLE "Product_Pictures" (
  "picture_id" SERIAL PRIMARY KEY,
  "picture" BYTEA NOT NULL,
  "product_id" INT REFERENCES "Products" ("product_id")
      ON DELETE CASCADE
      ON UPDATE CASCADE
);
