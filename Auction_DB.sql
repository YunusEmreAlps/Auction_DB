-- Auction System   (Müzayede Sistemi)
                    
       
-- Drop Table       
DROP TABLE TblBuyer CASCADE CONSTRAINTS;
DROP TABLE TblSeller CASCADE CONSTRAINTS;
DROP TABLE TblModerator CASCADE CONSTRAINTS;
DROP TABLE TblObject CASCADE CONSTRAINTS;
DROP TABLE TblCategory CASCADE CONSTRAINTS;
DROP TABLE Object_Category CASCADE CONSTRAINTS;
DROP TABLE TblSeat CASCADE CONSTRAINTS;
DROP TABLE TblAuctionTicket CASCADE CONSTRAINTS;
DROP TABLE TblBuying CASCADE CONSTRAINTS;
DROP TABLE Buyer_Backup CASCADE CONSTRAINTS;


-- Alter Date Format (SQL Developer)     
-- ALTER SESSION SET nls_timestamp_format = 'YYYY/MM/DD HH24:MI:SS'; 
    
                       
-- Buyer Table      (Nesneyi Satýn Alan Kiþi)
CREATE TABLE TblBuyer (
    buyer_identity  VARCHAR(11),
    buyer_name      VARCHAR(50)  NOT NULL,
    buyer_surname   VARCHAR(50)  NOT NULL,  
    buyer_birthday  DATE         NOT NULL,
    buyer_address   VARCHAR(255) NOT NULL,   
    
    CONSTRAINT PK_buyer_identity PRIMARY KEY(buyer_identity)
);

-- Buyer Backup Table      (Buyer Tablosu Kaydýnýn Yedeði)
CREATE TABLE Buyer_Backup (
    backup_buyer_identity  VARCHAR(11),
    backup_buyer_name      VARCHAR(50)  NOT NULL,
    backup_buyer_surname   VARCHAR(50)  NOT NULL,  
    backup_buyer_birthday  DATE         NOT NULL,
    backup_buyer_address   VARCHAR(255) NOT NULL,
    backup_recordtime      DATE         NOT NULL,
    
    CONSTRAINT PK_backup_buyer_identity PRIMARY KEY(backup_buyer_identity )
);

-- Seller Table      (Nesneyi Satan Kiþi)
CREATE TABLE TblSeller (
    seller_identity  VARCHAR(11),
    seller_name      VARCHAR(50)  NOT NULL,
    seller_surname   VARCHAR(50)  NOT NULL,
    seller_birthday  DATE         NOT NULL,
    seller_address   VARCHAR(255) NOT NULL,
    
    CONSTRAINT PK_seller_identity PRIMARY KEY(seller_identity)
);


-- Moderator Table   (Müzayedeyi Yöneten Kiþi)  
CREATE TABLE TblModerator (
    moderator_identity  VARCHAR(11),
    moderator_name      VARCHAR(50)  NOT NULL,
    moderator_surname   VARCHAR(50)  NOT NULL,
    moderator_birthday  DATE         NOT NULL,
    moderator_address   VARCHAR(255) NOT NULL,
    
    CONSTRAINT PK_moderator_identity PRIMARY KEY(moderator_identity)
);


-- Object Table   (Müzayedede Satýlacak olan Nesne)     TblSeller (1) -> TblObject (n)
CREATE TABLE TblObject (
    object_id            VARCHAR(10),
    obj_seller_identity  VARCHAR(11),
    object_year          DATE         NOT NULL,
    object_price         NUMBER(10,2) NOT NULL,
    object_screen_time   NUMBER(5,2)  NOT NULL,
    -- object_history    VARCHAR(255) NOT NULL,   
    
    CHECK(object_price > 0),
    CHECK(object_screen_time  > 0), 
    CONSTRAINT PK_object_id PRIMARY KEY(object_id),
    CONSTRAINT FK_obj_seller_identity FOREIGN KEY(obj_seller_identity) REFERENCES TblSeller(seller_identity) ON DELETE CASCADE
);


-- Category Table   (Satýlacak Nesnenin Kategorisi)
CREATE TABLE TblCategory (
    category_id          VARCHAR(10),
    category_name        VARCHAR(50),   
    
    CONSTRAINT PK_category_id PRIMARY KEY(category_id)
);


-- Object-Category Table   TblObject (n) -> TblCategory(n)
CREATE TABLE Object_Category (
    objcat_object_id     VARCHAR(10),
    objcat_category_id   VARCHAR(10),
    
    CONSTRAINT FK_objcat_object_id  FOREIGN KEY(objcat_object_id) REFERENCES TblObject(object_id) ON DELETE CASCADE,
    CONSTRAINT FK_objcat_category_id FOREIGN KEY (objcat_category_id) REFERENCES TblCategory(category_id) ON DELETE CASCADE,
    CONSTRAINT UQ_object_category UNIQUE(objcat_object_id, objcat_category_id)
);


-- Seat Table       (Sandalye)
CREATE TABLE TblSeat (
    seat_id              VARCHAR(10),
    
    CONSTRAINT PK_seat_id PRIMARY KEY(seat_id)
);


-- Auction Ticket Table       (Müzayedeye Katýlmak için Bilet Alýnmalýdýr)
CREATE TABLE TblAuctionTicket (
    auction_id              VARCHAR(10),
    tkt_moderator_identity  VARCHAR(11),
    tkt_buyer_identity      VARCHAR(11),
    ticket_time             DATE,
    tkt_seat_id             VARCHAR(10),
    ticket_price            NUMBER(5,2),
    
    CONSTRAINT FK_tkt_moderator_identity  FOREIGN KEY(tkt_moderator_identity) REFERENCES TblModerator(moderator_identity) ON DELETE CASCADE,
    CONSTRAINT FK_tkt_buyer_identity  FOREIGN KEY(tkt_buyer_identity) REFERENCES TblBuyer(buyer_identity) ON DELETE CASCADE,
    CONSTRAINT FK_tkt_seat_id  FOREIGN KEY(tkt_seat_id) REFERENCES TblSeat(seat_id) ON DELETE CASCADE,
    CONSTRAINT UQ_ticket_seat_id UNIQUE(auction_id, tkt_buyer_identity, tkt_seat_id)
);


-- Buying Table       (Satýn Alma Ýþlemi)
CREATE TABLE TblBuying (
    buy_buyer_identity      VARCHAR(11),
    buy_object_id           VARCHAR(10),
    
    CONSTRAINT FK_buy_buyer_identity FOREIGN KEY(buy_buyer_identity) REFERENCES TblBuyer(buyer_identity) ON DELETE CASCADE,
    CONSTRAINT FK_buy_object_id FOREIGN KEY(buy_object_id) REFERENCES TblObject(object_id) ON DELETE CASCADE,
    CONSTRAINT PK_buy_object_id PRIMARY KEY(buy_object_id)
);


-- Insert Data      (TblBuyer)
INSERT INTO TblBuyer(buyer_identity, buyer_name, buyer_surname, buyer_birthday, buyer_address) 
VALUES('80351855702', 'John', 'Smith', TO_DATE('1996/04/23', 'YYYY/MM/DD'), '3071  Patterson Fork Road, Chicago/Illinois/60605');  

INSERT INTO TblBuyer(buyer_identity, buyer_name, buyer_surname, buyer_birthday, buyer_address) 
VALUES('73437138714', 'Sarah', 'Jones', TO_DATE('1994/06/25', 'YYYY/MM/DD'), '5022  Poplar Chase Lane, Arbon/Idaho/83212'); 

INSERT INTO TblBuyer(buyer_identity, buyer_name, buyer_surname, buyer_birthday, buyer_address) 
VALUES('20422210474', 'Oliver', 'Taylor', TO_DATE('1992/08/27', 'YYYY/MM/DD'), '4051  Burton Avenue, MILTON/Kentucky/40045');

INSERT INTO TblBuyer(buyer_identity, buyer_name, buyer_surname, buyer_birthday, buyer_address) 
VALUES('79428714776', 'Ella', 'Lewis', TO_DATE('1990/08/29', 'YYYY/MM/DD'), '4259  Graystone Lakes, Macon/Georgia/31210');

INSERT INTO TblBuyer(buyer_identity, buyer_name, buyer_surname, buyer_birthday, buyer_address) 
VALUES('38157286022', 'Ethan', 'Wood', TO_DATE('1993/08/24', 'YYYY/MM/DD'), '1076  Fancher Drive, Dallas/Texas/75234');

INSERT INTO TblBuyer(buyer_identity, buyer_name, buyer_surname, buyer_birthday, buyer_address) 
VALUES('38157286044', 'Michael', 'Davies', TO_DATE('1999/04/11', 'YYYY/MM/DD'), '4659  Conaway Street, Scipio/Indiana/47273');

INSERT INTO TblBuyer(buyer_identity, buyer_name, buyer_surname, buyer_birthday, buyer_address) 
VALUES('38157286066', 'Ada', 'Davies', TO_DATE('1993/04/11', 'YYYY/MM/DD'), '4659  Conaway Street, Scipio/Indiana/47273');


-- Insert Data      (TblSeller)    
INSERT INTO TblSeller(seller_identity, seller_name, seller_surname, seller_birthday, seller_address)
VALUES('94979130530', 'Margaret', 'Brown', TO_DATE('1986/04/23', 'YYYY/MM/DD') , '791  Powder House Road, West Palm Beach/Florida/33401');

INSERT INTO TblSeller(seller_identity, seller_name, seller_surname, seller_birthday, seller_address)
VALUES('53183578392', 'Jack', 'Evans', TO_DATE('1984/06/21', 'YYYY/MM/DD') , '1788  Memory Lane, Stockton/Illinois/61085');

INSERT INTO TblSeller(seller_identity, seller_name, seller_surname, seller_birthday, seller_address)
VALUES('50500143110', 'Alice', 'Wilson', TO_DATE('1982/08/19', 'YYYY/MM/DD') , '4163  Farm Meadow Drive, Show Low/Arizona/85901');


-- Insert Data      (TblModerator)
INSERT INTO TblModerator(moderator_identity, moderator_name, moderator_surname, moderator_birthday, moderator_address)
VALUES('59750768760', 'James', 'Hall', TO_DATE('1976/04/21', 'YYYY/MM/DD'), '3997  Comfort Court, Madison/Wisconsin/53718');

INSERT INTO TblModerator(moderator_identity, moderator_name, moderator_surname, moderator_birthday, moderator_address)
VALUES('43135042316', 'Eliza', 'Walker', TO_DATE('1974/03/19', 'YYYY/MM/DD'), '566  Stonepot Road, COUNCIL BLUFFS/Iowa/51501');

INSERT INTO TblModerator(moderator_identity, moderator_name, moderator_surname, moderator_birthday, moderator_address)
VALUES('66817349442', 'Oscar', 'Turner', TO_DATE('1972/02/18', 'YYYY/MM/DD'), '3072  Dennison Street, Snelling/California/95369');


-- Insert Data      (TblObject)
INSERT INTO TblObject(object_id, obj_seller_identity, object_year, object_price, object_screen_time)  
VALUES('1', '94979130530', TO_DATE('1945/04/21', 'YYYY/MM/DD'), 10000, 15);    --  15 minutes   (WW2 Money)

INSERT INTO TblObject(object_id, obj_seller_identity, object_year, object_price, object_screen_time)
VALUES('2', '53183578392', TO_DATE('1943/09/24', 'YYYY/MM/DD'), 100000, 25);    --  25 minutes  (WW2 Gun)

INSERT INTO TblObject(object_id, obj_seller_identity, object_year, object_price, object_screen_time)
VALUES('3', '53183578392', TO_DATE('1912/07/10', 'YYYY/MM/DD'), 50000, 20);    --  20 minutes  (Vase)


-- Insert Data      (TblCategory)
INSERT INTO TblCategory(category_id, category_name)
VALUES('1', 'Household Furniture');

INSERT INTO TblCategory(category_id, category_name)
VALUES('2', 'Farm Machinery');

INSERT INTO TblCategory(category_id, category_name)
VALUES('3', 'Painting');

INSERT INTO TblCategory(category_id, category_name)
VALUES('4', 'Sculpture');

INSERT INTO TblCategory(category_id, category_name)
VALUES('5', 'Antique');

INSERT INTO TblCategory(category_id, category_name)
VALUES('6', 'Stamp');

INSERT INTO TblCategory(category_id, category_name)
VALUES('7', 'Money');

INSERT INTO TblCategory(category_id, category_name)
VALUES('8', 'Book');

INSERT INTO TblCategory(category_id, category_name)
VALUES('9', 'Jewelry');

INSERT INTO TblCategory(category_id, category_name)
VALUES('10', 'Car');

INSERT INTO TblCategory(category_id, category_name)
VALUES('11', 'House');


-- Insert Data      (Object-Category Table)
INSERT INTO Object_Category(objcat_object_id, objcat_category_id)
VALUES('1', '7');

INSERT INTO Object_Category(objcat_object_id, objcat_category_id)
VALUES('2', '5');

INSERT INTO Object_Category(objcat_object_id, objcat_category_id)
VALUES('3', '1');


-- Insert Data      (TblSeat)
INSERT INTO TblSeat(seat_id)
VALUES('A1');

INSERT INTO TblSeat(seat_id)
VALUES('A2');

INSERT INTO TblSeat(seat_id)
VALUES('A3');

INSERT INTO TblSeat(seat_id)
VALUES('A4');

INSERT INTO TblSeat(seat_id)
VALUES('A5');

INSERT INTO TblSeat(seat_id)
VALUES('B1');

INSERT INTO TblSeat(seat_id)
VALUES('B2');

INSERT INTO TblSeat(seat_id)
VALUES('B3');

INSERT INTO TblSeat(seat_id)
VALUES('B4');

INSERT INTO TblSeat(seat_id)
VALUES('B5');


-- Insert Data      (TblTicket)
INSERT INTO TblAuctionTicket(auction_id, tkt_moderator_identity, tkt_buyer_identity, ticket_time, tkt_seat_id, ticket_price)
VALUES('TCT1', '59750768760', '80351855702', TO_DATE( '2020/07/15 20:00:00', 'YYYY/MM/DD HH24:MI:SS'), 'A1', 100);

INSERT INTO TblAuctionTicket(auction_id, tkt_moderator_identity, tkt_buyer_identity, ticket_time, tkt_seat_id, ticket_price)
VALUES('TCT1', '59750768760', '73437138714', TO_DATE( '2020/07/15 20:00:00', 'YYYY/MM/DD HH24:MI:SS'), 'A2', 100);

INSERT INTO TblAuctionTicket(auction_id, tkt_moderator_identity, tkt_buyer_identity, ticket_time, tkt_seat_id, ticket_price)
VALUES('TCT1', '59750768760', '20422210474', TO_DATE( '2020/07/15 20:00:00', 'YYYY/MM/DD HH24:MI:SS'), 'A3', 100);

INSERT INTO TblAuctionTicket(auction_id, tkt_moderator_identity, tkt_buyer_identity, ticket_time, tkt_seat_id, ticket_price)
VALUES('TCT2', '59750768760', '20422210474', TO_DATE( '2020/05/15 20:00:00', 'YYYY/MM/DD HH24:MI:SS'), 'A3', 100);


-- Insert Data      (TblBuying)
INSERT INTO TblBuying(buy_buyer_identity, buy_object_id)
VALUES('80351855702', '1');

INSERT INTO TblBuying(buy_buyer_identity, buy_object_id)
VALUES('73437138714', '2');

INSERT INTO TblBuying(buy_buyer_identity, buy_object_id)
VALUES('20422210474', '3');

-- Select Data
SELECT * FROM TblBuyer;
SELECT * FROM Buyer_Backup;
SELECT * FROM TblSeller;
SELECT * FROM TblModerator;
SELECT * FROM TblObject;
SELECT * FROM TblCategory;
SELECT * FROM Object_Category;
SELECT * FROM tblSeat;
SELECT * FROM TblAuctionTicket;
SELECT * FROM TblBuying;


-- Join Keyword     (Tablo Birleþtirme)

-- TblObject, Object-Category, TblCategory 
-- Nesneye Ait Tüm Bilgiler Listelenecektir. Bunlar Kategorilerine göre gruplanacaktýr. 
SELECT Obj.object_id, Obj.object_year, (TRUNC((SYSDATE - Obj.object_year)/365.25)) AS "Object Age" , Obj.object_price, Obj.object_screen_time, Ctg.category_name
FROM TblObject Obj
LEFT JOIN Object_Category ObjCtg
ON Obj.object_id = ObjCtg.objcat_object_id
INNER JOIN TblCategory Ctg 
ON ObjCtg.objcat_category_id = Ctg.category_id
ORDER BY Ctg.category_id desc;


-- TblBuyer, TblAuctionTicket, TblBuying, TblObject
-- Bu Query Yaþý 18'den büyük olan Kullanýcýlara ait Kiþisel,Bilet ve Satýn Aldýðý Nesneye ait Tüm Bilgileri Listelemektedir.
-- Fiyatýna göre sýralanacaktýr.
SELECT Byr.buyer_identity, Byr.buyer_name, Byr.buyer_surname, (TRUNC((SYSDATE - Byr.buyer_birthday)/365.25)) AS Age, 
       Tkt.auction_id, Tkt.ticket_time, Tkt.tkt_seat_id, Tkt.ticket_price,
       Bying.buy_object_id,
       Obj.obj_seller_identity, Obj.object_year, (TRUNC((SYSDATE - Obj.object_year)/365.25)) AS "Object Age", Obj.object_price
FROM TblBuyer Byr 
INNER JOIN TblAuctionTicket Tkt 
ON Byr.buyer_identity = Tkt.tkt_buyer_identity
INNER JOIN TblBuying Bying
ON Byr.buyer_identity = Bying.buy_buyer_identity
INNER JOIN TblObject Obj
ON Bying.buy_object_id = Obj.object_id
WHERE (TRUNC((SYSDATE - Byr.buyer_birthday)/365.25)) > 18
ORDER BY Obj.object_price, (TRUNC((SYSDATE - Obj.object_year)/365.25));


-- PL/SQL

-- User Defined Exception
DECLARE
    ex_custom EXCEPTION;             
    PRAGMA EXCEPTION_INIT(ex_custom, -20005);
BEGIN
   RAISE ex_custom; 
EXCEPTION
   WHEN ex_custom THEN
     DBMS_OUTPUT.put_line('This Is User Defined Exception.');
     DBMS_OUTPUT.put_line('You Cant Delete this Row');
     DBMS_OUTPUT.put_line(SQLERRM);
END;

-- Drop
DROP PROCEDURE Auction_timeout;
DROP FUNCTION total_object_value;
DROP TYPE Objinfo;
DROP TYPE rcrd_row;
DROP FUNCTION objFunc;
DROP TRIGGER TblBuyer_record_backup;
DROP TRIGGER TblBuyer_record_control;
DROP PACKAGE auction_package;


-- Procedures

-- Procedure 1     (TblAuctionTicket içerisinde bulunan ve Zaman Aþýmýna uðramýþ bilet kayýtlarýný silen prosedür)
CREATE OR REPLACE PROCEDURE Auction_timeout
AS
BEGIN
DELETE FROM  TblAuctionTicket WHERE (TRUNC(SYSDATE - ticket_time)) > 0; -- YYYY/MM/DD HH24:MI:SS (NLS Settings)
EXCEPTION
WHEN no_data_found THEN
DBMS_OUTPUT.put_line(' - Data not found.');
WHEN others THEN
DBMS_OUTPUT.put_line(' - Error ');
END;
/


-- Procedure 2     (Nesnenin Yýlýna, Nesne Sunum Zamanýna ve Fiyatýna göre Gösterilme Zamanýný ve fiyatýný guncelleyen procedur)
DECLARE
   c_object_id           tblObject.object_id%TYPE;
   c_object_year         tblObject.object_year%TYPE;
   c_object_price        tblObject.object_price%TYPE;
   c_object_screen_time  tblObject.object_screen_time%TYPE;
   CURSOR objectList IS
       SELECT object_id, object_year, object_price, object_screen_time  FROM tblObject;
BEGIN
   OPEN objectList;
   LOOP
   FETCH objectList INTO  c_object_id, c_object_year, c_object_price,  c_object_screen_time;
   EXIT WHEN objectList%NOTFOUND;
   
   IF(((TRUNC((SYSDATE -  c_object_year)/365.25)) < 40) AND (c_object_screen_time > 20) AND (c_object_price < 15000)) THEN
      UPDATE tblObject SET object_screen_time = 15, object_price = (object_price*2.5)  WHERE object_id = c_object_id;
      COMMIT;
      
   ELSIF ( (((TRUNC((SYSDATE -  c_object_year)/365.25)) >= 40) AND ((TRUNC((SYSDATE -  c_object_year)/365.25)) < 80)) AND (c_object_screen_time > 40) AND (c_object_price < 60000)) THEN
      UPDATE tblObject SET object_screen_time = 35, object_price = (object_price*3.5)  WHERE object_id = c_object_id;
      COMMIT;
   
   ELSIF (((TRUNC((SYSDATE -  c_object_year)/365.25)) >= 80) AND (c_object_screen_time > 60) AND (c_object_price < 150000)) THEN
       UPDATE tblObject SET object_screen_time = 55, object_price = (object_price*4.5)  WHERE object_id = c_object_id;
       COMMIT;
       
   END IF;
   DBMS_OUTPUT.put_line( c_object_id  || ' - ' || c_object_year || ' - ' || c_object_price || ' - ' || c_object_screen_time);
   END LOOP;
   CLOSE objectList;
END;

-- Functions

-- Function 1      (Müzayedede Satýlmýþ olan Tüm Nesneleri Fiyatlarýný Toplayan Fonksiyon)
CREATE FUNCTION total_object_value
RETURN NUMBER AS
tot_obj_price NUMBER := 0;
BEGIN
SELECT SUM(Obj.object_price) INTO tot_obj_price
FROM TblObject Obj 
INNER JOIN TblBuying Bying
ON Obj.object_id = Bying.buy_object_id;
RETURN tot_obj_price;
EXCEPTION
WHEN no_data_found THEN
    DBMS_OUTPUT.put_line(' - Data not found.');
WHEN others THEN
    DBMS_OUTPUT.put_line(' - Error');
END total_object_value;
/

-- Function 2

--Create table of the Type
CREATE OR REPLACE TYPE Objinfo AS OBJECT(
    objfunc_object_id       VARCHAR(10),
    objfunc_object_year     DATE,
    objfunc_object_price    NUMBER(10,2),
    objfunc_object_screen   NUMBER(5,2),
    objfunc_object_category VARCHAR(50)
);
/

--Create table of the Type
CREATE OR REPLACE TYPE rcrd_row AS TABLE OF Objinfo;
/

-- Nesneye Ait Tüm Bilgiler Listelenecektir.
CREATE OR REPLACE FUNCTION objFunc(ctgname IN VARCHAR) RETURN rcrd_row
IS
reslt rcrd_row := NEW rcrd_row();
BEGIN
FOR rw IN (SELECT Obj.object_id, Obj.object_year, Obj.object_price, Obj.object_screen_time, Ctg.category_name
  FROM TblObject Obj LEFT JOIN Object_Category ObjCtg
  ON Obj.object_id = ObjCtg.objcat_object_id
  INNER JOIN TblCategory Ctg 
  ON ObjCtg.objcat_category_id = Ctg.category_id
  WHERE Ctg.category_name = ctgname
  ORDER BY Ctg.category_id desc)
LOOP
reslt.extend;
reslt(reslt.count) := new Objinfo(
objfunc_object_id => rw.object_id, objfunc_object_year => rw.object_year, objfunc_object_price
=> rw.object_price, objfunc_object_screen => rw.object_screen_time, objfunc_object_category =>
rw.category_name
);
END LOOP;
RETURN reslt;
END;
/

-- Triggers

-- Trigger 1      (Yeni Alýcý Kaydý Yapýldýðýnda bunu Buyer_Backup Tablosuna eklyecektir.(Yedekleme Ýþlemi))
CREATE OR REPLACE TRIGGER TblBuyer_record_backup 
BEFORE INSERT OR UPDATE ON TblBuyer 
FOR EACH ROW 
BEGIN
    IF((TRUNC((SYSDATE - :NEW.buyer_birthday)/365.25)) > 18) THEN 
      INSERT INTO Buyer_Backup(backup_buyer_identity, backup_buyer_name, backup_buyer_surname, backup_buyer_birthday, backup_buyer_address, backup_recordtime) VALUES(:NEW.buyer_identity, :NEW.buyer_name, :NEW.buyer_surname, :NEW.buyer_birthday, :NEW.buyer_address, SYSDATE);
    END IF;  
END; 
/ 

-- Trigger 2      (TblBuyer Tablosuna Yaþý 18'den Küçük Kayýt Eklenmeyecektir)
CREATE OR REPLACE TRIGGER TblBuyer_record_control
BEFORE INSERT OR UPDATE ON TblBuyer 
FOR EACH ROW 
BEGIN 
    IF((TRUNC((SYSDATE - :NEW.buyer_birthday)/365.25)) < 18) THEN
     RAISE_APPLICATION_ERROR(-20000, 'Age Limit is 19 And Older');
    END IF;
END; 
/ 


-- Packages       (PL/SQL ile geliþtirilen procedur, fonksiyon gibi yapýlarý bir araya toplandýðý yapýya denir.)
--                (Tanýmlama ve Gövde Olmak üzere iki kýsýmdan oluþur)

-- declaration 
CREATE OR REPLACE PACKAGE auction_package
AS  
   -- Procedure      (Boþ Olan Sandalye Sayýsýný Yazan Procedure) Hata Veriyor
   -- PROCEDURE listESeat; 

   -- Function       (Müzayedede Satýlmýþ olan Tüm Biletlerin Fiyatlarýný Toplayan Fonksiyon)
   FUNCTION total_ticket_value RETURN NUMBER;
END auction_package;
/

-- body
CREATE OR REPLACE PACKAGE BODY auction_package
AS
   /*emp_seat_number := 0 NUMBER;  
   -- Procedure      (Boþ Olan Sandalye Sayýsýný Yazan Procedure)          
   PROCEDURE listESeat AS 
   BEGIN
      SELECT Count(TSt.seat_id) INTO emp_seat_number  FROM TblSeat TSt LEFT JOIN TblAuctionTicket Tkt
      ON TSt.seat_id = Tkt.tkt_seat_id WHERE Tkt.tkt_seat_id IS NULL;
      DBMS_OUTPUT.put_line(' - Empty Seat Number : ' || :emp_seat_number );
   COMMIT;
   END;*/
   
   -- Function       (Müzayedede Satýlmýþ olan Tüm Biletlerin Fiyatlarýný Toplayan Fonksiyon)
   FUNCTION total_ticket_value
   RETURN NUMBER AS
   tot_tck_price NUMBER := 0;
   BEGIN
   SELECT SUM(Tck.ticket_price) INTO tot_tck_price
   FROM TblAuctionTicket Tck;
   RETURN tot_tck_price;
   EXCEPTION
   WHEN no_data_found THEN
        DBMS_OUTPUT.put_line(' - Data not found.');
   WHEN others THEN
         DBMS_OUTPUT.put_line(' - Error');
   END total_ticket_value;
END auction_package; 
/



-- Job            (Her 24 saatte bir Zamaný geçmiþ olan Biletleri Silen Job)
-- Bu iþlemi PL/SQL içerisnde bulunan JOB oluþturma kýsmýndan yaptým.



-- Proceder Auction_timeout çalýþýr
-- Run              (SQL Developer)
-- EXECUTE Auction_timeout;            
BEGIN
Auction_timeout;
END; 

-- Fonskiyon Çalýþtýrma
SELECT total_object_value FROM DUAL;
SELECT * FROM TABLE(objfunc('Antique'));

-- Package içerisinde yer alan Fonksiyon Çalýþýr.
SELECT auction_package.total_ticket_value FROM DUAL;

