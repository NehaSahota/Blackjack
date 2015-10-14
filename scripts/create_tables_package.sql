 --***********************CREATE TABLES PACKAGE*****************

--**********PACKAGE SPECIFICATION***********
CREATE OR REPLACE PACKAGE create_tab_pkg IS
   PROCEDURE sp_create_users_table;
   PROCEDURE sp_create_cards_table;
   PROCEDURE sp_create_drawn_cards_table;
   PROCEDURE sp_create_game_table;
   PROCEDURE sp_create_game_player_table;
   PROCEDURE sp_drawn_cards_history_table;
   
END create_tab_pkg ;



--*********PACKAGE BODY****************

CREATE OR REPLACE PACKAGE BODY create_tab_pkg IS
	PROCEDURE sp_create_users_table IS
	v_table_name VARCHAR2(255); 
BEGIN
	v_table_name := 'CREATE TABLE users (
	 id NUMBER NOT NULL PRIMARY KEY , 
	 name VARCHAR2(30) NOT NULL, 
	 username VARCHAR2(30) NOT NULL, 
	 email VARCHAR2(30) NOT NULL, 
	 password VARCHAR2(30) NOT NULL, 
	 score NUMBER NOT NULL
	)';

EXECUTE IMMEDIATE v_table_name;
END sp_create_users_table;

PROCEDURE sp_create_cards_table IS
	v_table_name VARCHAR2(255); 
BEGIN
	v_table_name := 'CREATE TABLE cards(
	 id NUMBER NOT NULL PRIMARY KEY,
	name VARCHAR(8),
	value NUMBER
	)';
	EXECUTE IMMEDIATE v_table_name;
END sp_create_cards_table;


PROCEDURE sp_create_drawn_cards_table IS
	v_table_name VARCHAR2(255); 
BEGIN
	v_table_name := 'CREATE TABLE drawn_cards(
	 name VARCHAR2(10) NOT NULL PRIMARY KEY, 
	 suite VARCHAR2(10)
	)';
	EXECUTE IMMEDIATE v_table_name;
END sp_create_drawn_cards_table;

PROCEDURE sp_create_game_table IS
	v_table_name VARCHAR2(255); 
BEGIN
	v_table_name := 'CREATE TABLE game(
	 id NUMBER NOT NULL PRIMARY KEY, 
	 no_of_players NUMBER NOT NULL, 
	 game_date DATE NOT NULL, 
	 status VARCHAR2(30) NOT NULL
	)';
	EXECUTE IMMEDIATE v_table_name;
END sp_create_game_table;

PROCEDURE sp_create_game_player_table IS
	v_table_name VARCHAR2(255); 
BEGIN
	v_table_name := 'CREATE TABLE game_player(
	 id NUMBER NOT NULL PRIMARY KEY, 
	 game_id NUMBER NOT NULL, 
	 player_id NUMBER NOT NULL, 
	 score NUMBER NOT NULL
	)';
	EXECUTE IMMEDIATE v_table_name;
END sp_create_game_player_table ;

PROCEDURE sp_drawn_cards_history_table IS
	v_table_name VARCHAR2(255); 
BEGIN
	v_table_name := 'CREATE TABLE drawn_cards_history(
	 id NUMBER NOT NULL PRIMARY KEY, 
	 game_player_id NUMBER NOT NULL, 
	 name VARCHAR2(30) NOT NULL, 
	 symbol VARCHAR2(20) NOT NULL
	)';
	EXECUTE IMMEDIATE v_table_name;
END sp_drawn_cards_history_table ;


END create_tab_pkg ;

--EXECUTE THIS PACKAGE
BEGIN
 create_tab_pkg.sp_create_users_table;
 create_tab_pkg.sp_create_cards_table;
 create_tab_pkg.sp_create_drawn_cards_table;
 create_tab_pkg.sp_create_game_table;
 create_tab_pkg.sp_create_game_player_table;
 create_tab_pkg.sp_drawn_cards_history_table;
END



