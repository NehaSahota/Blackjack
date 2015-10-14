--INSERT INTO CARDS TABLES
INSERT INTO cards(id,name,value) VALUES (1,'ace',1);
INSERT INTO cards(id,name,value) VALUES (2,'two',2);
INSERT INTO cards(id,name,value) VALUES (3,'three',3);
INSERT INTO cards(id,name,value) VALUES (4,'four',4);
INSERT INTO cards(id,name,value) VALUES (5,'five',5);
INSERT INTO cards(id,name,value) VALUES (6,'six',6);
INSERT INTO cards(id,name,value) VALUES (7,'seven',7);
INSERT INTO cards(id,name,value) VALUES (8,'eight',8);
INSERT INTO cards(id,name,value) VALUES (9,'nine',9);
INSERT INTO cards(id,name,value) VALUES (10,'ten',10);
INSERT INTO cards(id,name,value) VALUES (11,'jack',10);
INSERT INTO cards(id,name,value) VALUES (12,'queen',10);
INSERT INTO cards(id,name,value) VALUES (13,'king',10);


--CRUD FOR USER
CREATE OR REPLACE FUNCTION f_check_user(p_username IN users.username%TYPE,
 p_password IN users.password%TYPE)
RETURN NUMBER IS
v_count NUMBER;
BEGIN
  SELECT count(id)  INTO v_count FROM users
  WHERE username = p_username AND password = p_password;
RETURN v_count;
END;


CREATE OR REPLACE PROCEDURE sp_insert_user (p_id IN users.id%TYPE,
 p_name IN users.name%TYPE,
 p_username IN users.username%TYPE,
 p_email IN users.email%TYPE,
 p_password IN users.password%TYPE,
 p_score IN users.score%TYPE) IS
 v_count NUMBER;
BEGIN
  v_count := f_check_user(p_username , p_password);
  IF v_count =0 THEN
  INSERT INTO users (id , name , username , email, password, score )
   VALUES(p_id , p_name , p_username , p_email, p_password , p_score);
   DBMS_OUTPUT.PUT_LINE('Added User: '||p_id ||chr(10)||'Name : ' || p_name);
   ELSE 
   DBMS_OUTPUT.PUT_LINE('The user already exists');
  END IF;
END;

--TEST FOR EXISTING USER****************
 BEGIN 
sp_insert_user (9,'user1','user1', 'user@gmai.com', 'psw', 0);
END;

--*****INSERT A NEW USER *************
BEGIN 
sp_insert_user (8,'user1','user5', 'user@gmai.com', 'psw', 0);
END;

--***********GET PLAYER INFO*************
CREATE OR REPLACE PROCEDURE sp_get_player_info (
 p_username IN users.username%TYPE,
 p_password IN users.password%TYPE) IS
 v_user_rec users%ROWTYPE;
BEGIN
  SELECT * INTO v_user_rec FROM users
  WHERE username = p_username AND password = p_password;
  DBMS_OUTPUT.PUT_LINE('USER ID : '|| v_user_rec.id ||chr(10)||'USER Name : '|| v_user_rec.name ||chr(10)||'Username  : '|| v_user_rec.username ||chr(10)||'Password: '|| v_user_rec.password ||chr(10)||'Email : '|| v_user_rec.email||chr(10)||'Score : '|| v_user_rec.score ||chr(10));
END;

BEGIN 
sp_get_player_info ('user1', 'psw');
END;


--***********GET PLAYER INFO BY ID************
CREATE OR REPLACE PROCEDURE sp_get_player_info_from_id (
 p_id IN users.id%TYPE,
 p_name IN OUT users.name%TYPE) IS
BEGIN
  SELECT name INTO p_name FROM users WHERE id = p_id;
END;

--****************UPDATE PLAYR INFO****************
CREATE OR REPLACE PROCEDURE sp_update_player_info (
 p_username IN users.username%TYPE,
 p_password IN users.password%TYPE,
 p_email IN users.email%TYPE,
 p_score IN users.score%TYPE) IS
BEGIN
  UPDATE users SET username = p_username , 
                   password = p_password,
                   email = p_email,
                   score = p_score
  WHERE username = p_username AND password = p_password;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||' Rows Updated');
END;

BEGIN 
sp_update_player_info ('user1', 'psw', 'user@gmai.com', 10);
END;

--*****************PASSWORD CHANGE*****************

CREATE OR REPLACE PROCEDURE sp_change_password(
 p_username IN users.username%TYPE,
 p_password_old IN users.password%TYPE,
 p_password_new IN users.password%TYPE
 e_pass_not_updated EXCEPTION;
) IS
BEGIN
  UPDATE users SET  password = p_password_new
  WHERE username = p_username AND password = p_password_old;
   IF (SQL%ROWCOUNT = 1) THEN
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||' Rows Updated');
    ELSE
	  RAISE e_pass_not_updated;
   END IF;
   
  EXCEPTION
    WHEN e_pass_not_updated THEN
     DBMS_OUTPUT.PUT_LINE('Wrong User!');  	
END;
BEGIN 
sp_change_password('user1', 'psw' ,'psw1');
END;


--GAME INFO
--*************GET GAME INFO*************
CREATE OR REPLACE PROCEDURE sp_get_game_info (
 p_id IN users.username%TYPE) IS
 v_game_rec game%ROWTYPE;
BEGIN
  SELECT * INTO v_game_rec FROM game
  WHERE id = p_id;
  DBMS_OUTPUT.PUT_LINE('Game ID : '|| v_game_rec.id ||chr(10)||'Number of players: '|| v_game_rec.no_of_players ||chr(10)||'DATE : '|| v_game_rec.game_date ||chr(10)||'Status: '|| v_game_rec.status);
END;

--***************UPDATE GAME INFO**********
CREATE OR REPLACE PROCEDURE sp_update_game_info (
 p_id IN OUT game.id%TYPE,
 p_no_of_players IN OUT game.no_of_players%TYPE,
 p_game_date IN OUT game.game_date%TYPE,
 p_status IN OUT game.status%TYPE) IS
BEGIN
  UPDATE game SET no_of_players= p_no_of_players ,
                   game_date = p_game_date,
                   status = p_status
  WHERE id = p_id;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||' Rows Updated');
END;

BEGIN 
sp_update_game_info ();
END;

--****************DELETE GAME INFO
CREATE OR REPLACE PROCEDURE sp_delete_game_info (
 p_id IN game.id%TYPE) IS
BEGIN
  DELETE FROM game
  WHERE id = p_id;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||' Rows Updated');
END;

BEGIN 
sp_delete_game_info();
END;


--GAME PLAYER INFO
--****************GET GAME_PLAYER_INFO************
CREATE OR REPLACE PROCEDURE sp_get_game_player_info (
 p_id IN game_player.id%TYPE) IS
 v_game_player_rec game_player%ROWTYPE;
BEGIN
  SELECT * INTO v_game_player_rec FROM game_player
  WHERE id = p_id;
  DBMS_OUTPUT.PUT_LINE(' ID : '|| v_game_player_rec .id ||chr(10)||'Game ID: '|| v_game_player_rec.game_id ||chr(10)||'Player ID: '|| v_game_player_rec.player_id ||chr(10)||'Score: '|| v_game_player_rec.score);
END;

--************UPDATE GAME_PLAYER INFO*************
CREATE OR REPLACE PROCEDURE sp_update_game_player_info (
 p_id IN  game.id%TYPE,
 p_game_id IN OUT game_player.id%TYPE,
 p_player_id IN OUT game_player.game_id%TYPE,
 p_score IN OUT game_player.score%TYPE) IS
BEGIN
  UPDATE game_player SET  game_id= p_game_id ,
                   player_id = p_player_id,
                   score = p_score
  WHERE id = p_id;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||' Rows Updated');
END;


BEGIN 
sp_update_game_player_info ();
END;

--*************DELETE GAME_PLAYER INFO
CREATE OR REPLACE PROCEDURE sp_delete_game_player_info (
 p_id IN game_player.id%TYPE) IS
BEGIN
  DELETE FROM game_player
  WHERE id = p_id;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||' Rows Updated');
END;

BEGIN 
sp_delete_game_player_info();
END;

--*************DRAWN CARDS HISTORY
--*************GET DRAWN CARDS HISTORY******************
CREATE OR REPLACE PROCEDURE sp_get_drawn_cards_history (
 p_id IN drawn_cards_history.id%TYPE) IS
 v_drawn_cards_rec drawn_cards_history%ROWTYPE;
BEGIN
  SELECT * INTO v_drawn_cards_rec FROM drawn_cards_history
  WHERE id = p_id;
  DBMS_OUTPUT.PUT_LINE(' ID : '|| v_drawn_cards_rec.id ||chr(10)||'PLAYER GAME ID: '|| v_drawn_cards_rec.game_player_id ||chr(10)||'Name: '|| v_drawn_cards_rec.name ||chr(10)||'Symbol: '|| v_drawn_cards_rec.symbol);
END;

BEGIN
sp_get_drawn_cards_history() ;
END

--*******************UPDATE DRAWN CARDS HISTORY******************
CREATE OR REPLACE PROCEDURE sp_update_drawncards_history (
 p_id IN  drawn_cards_history.id%TYPE,
 p_game_player_id IN OUT drawn_cards_history.game_player_id%TYPE,
 p_name IN OUT drawn_cards_history.name%TYPE,
 p_symbol IN OUT drawn_cards_history.symbol%TYPE) IS
BEGIN
  UPDATE drawn_cards_history SET  game_player_id= p_game_player_id ,
                   name = p_name,
                   symbol = p_symbol
  WHERE id = p_id;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||' Rows Updated');
END;

BEGIN
sp_update_drawncards_history();
END

--********************DELETE DRAWN CARDS HISTORY************

CREATE OR REPLACE PROCEDURE sp_delete_drawncards_history (
 p_id IN game_player.id%TYPE) IS
BEGIN
  DELETE FROM drawn_cards_history
  WHERE id = p_id;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||' Rows Updated');
END;

BEGIN 
sp_delete_drawncards_history ();
END;

--SET INITIAL SCORE TO ZERO 
CREATE OR REPLACE PROCEDURE sp_make_score_zero IS
 v_users VARCHAR2(255); 
BEGIN
 v_users := 'UPDATE users SET score=0';
EXECUTE IMMEDIATE v_users ;
END sp_make_score_zero;



----***********DROP ALL TABLES***********
CREATE OR REPLACE PROCEDURE sp_drop_all_tables  IS
 v_cards VARCHAR2(255); 
 v_drawn_cards VARCHAR2(255); 
 v_drawn_cards_history VARCHAR2(255); 
 v_game VARCHAR2(255); 
 v_game_player VARCHAR2(255); 
 v_users VARCHAR2(255); 
 
BEGIN
  v_cards := 'DROP TABLE cards';
  v_drawn_cards := 'DROP TABLE drawn_cards';
  v_drawn_cards_history := 'DROP TABLE drawn_cards_history';
  v_game := 'DROP TABLE game';
  v_game_player := 'DROP TABLE game_player';
  v_users := 'DROP TABLE users';
EXECUTE IMMEDIATE v_cards;
EXECUTE IMMEDIATE v_drawn_cards;
EXECUTE IMMEDIATE v_drawn_cards_history;
EXECUTE IMMEDIATE v_game;
EXECUTE IMMEDIATE v_game_player;
EXECUTE IMMEDIATE v_users;
END sp_drop_all_tables;

--EXECUTE THIS PROCEDURE
BEGIN
sp_drop_all_tables;
END;



--***********DELETE DATA FROM ALL TABLES*******
CREATE OR REPLACE PROCEDURE sp_delete_data IS
 v_drawn_cards_history VARCHAR2(255); 
 v_game VARCHAR2(255); 
 v_game_player VARCHAR2(255); 

BEGIN

  v_drawn_cards_history := 'DELETE FROM drawn_cards_history';
  v_game := 'DELETE FROM game';
  v_game_player := 'DELETE FROM game_player';

EXECUTE IMMEDIATE v_drawn_cards_history;
EXECUTE IMMEDIATE v_game;
EXECUTE IMMEDIATE v_game_player;

END sp_delete_data ;


--EXECUTE THIS PROCEDURE
BEGIN
sp_delete_data;
END;




--ANONYMOUS BLOCK 
--EXECUTE PACKAGE FOR CREATING TABLES
BEGIN
 create_tab_pkg.sp_create_users_table;
 create_tab_pkg.sp_create_cards_table;
 create_tab_pkg.sp_create_drawn_cards_table;
 create_tab_pkg.sp_create_game_table;
 create_tab_pkg.sp_create_game_player_table;
 create_tab_pkg.sp_drawn_cards_history_table;
END


--INITIALIZING GAME
BEGIN
 create_game_pkg.sp_insert_user;
 create_game_pkg.sp_insert_into_game;
 create_game_pkg.sp_insert_into_game_player;
 create_game_pkg.sp_create_drawn_cards_history;
 create_game_pkg.sp_update_score;

END


