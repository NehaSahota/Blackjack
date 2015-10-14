DECLARE
    card_number integer;
    card_name varchar2(10);
    card_symbol varchar2(10);
    user_id integer;
    game_id integer;
    v_game_player_id integer;
    user_score integer;
	player2_score integer;
	player2_name varchar2(30);
	player3_score integer;
	player3_name varchar2(30);
	dealer_score integer;
	user_name varchar2(30);
	dealer_name varchar2(30);
    drawn_cards_id integer;
	v_card_taken integer;
BEGIN
   dbms_output.put_line('----Bino - c0647015, Neha - c0646567, Revathi - c0643680-----');
   dbms_output.put_line('-------------------------------------------------------------');
   user_score := 0;
   dealer_score := 0;
   player2_score := 0;
   player3_score := 0;
   user_id :=0;
   game_id := 0;
   v_game_player_id := 0;
   -- created a user 
   dbms_output.put_line('---------------------PLAYER ONE GAME-----------------------');
   sp_insert_user(user_id , p_name => 'bino', p_username=> 'user1' , p_email=>'user1@gmail.com' , p_password=>'user1' , p_score=>0);
   

   -- created a 1 player game
   sp_insert_into_game(game_id,  p_no_of_players =>1, p_status =>0);

   -- created a game / player combination data
   sp_insert_into_game_player(v_game_player_id,  p_game_id =>game_id, p_player_id =>user_id, p_score => 0);

   -- get a random card
   randomCard(card_number, card_name, card_symbol);
   dbms_output.put_line('Your card is ' || card_name || ' of '|| card_symbol || '. Its value is ' || card_number);

   -- insert drawn card
   sp_create_drawn_cards_history(drawn_cards_id , p_game_player_id => v_game_player_id ,  p_name=> card_name, p_symbol=> card_symbol);

   -- update user score
   user_score := user_score + card_number;
   sp_update_score(user_score, user_id );

    -- while less than 17
	while user_score <= 16 
	loop
		-- get a randow card
		randomCard(card_number, card_name, card_symbol);
		dbms_output.put_line('Your card is ' || card_name || ' of '|| card_symbol || '. Its value is ' || card_number);

		select count(*) into v_card_taken from drawn_cards_history where NAME = card_name and SYMBOL = card_symbol;

		IF v_card_taken <= 0 THEN
			-- insert into drawn card table
			sp_create_drawn_cards_history(drawn_cards_id , p_game_player_id => v_game_player_id ,  p_name=> card_name, p_symbol=> card_symbol);

			-- update user score
			user_score := user_score + card_number;
			sp_update_score(user_score, user_id );
		ELSE
			dbms_output.put_line('Card is taken');
		END IF;
	end loop;

	-- check if score greater than 21
	sp_get_player_info_from_id(user_id, user_name);
	IF user_score > 21 THEN
		dbms_output.put_line(user_name ||' score is ' || user_score || ' You are Busted');
		user_score := 0;
	ELSIF user_score = 21 THEN
		dbms_output.put_line(user_name ||' is ' || user_score || ' BlackJack');
	ELSE
		dbms_output.put_line(user_name ||' score is ' || user_score);
	END IF;
	
	
   dbms_output.put_line('---------------------PLAYER TWO GAME-----------------------');
   user_id :=0;
   v_game_player_id := 0;
	
   sp_insert_user(user_id , p_name => 'Neha', p_username=> 'user1' , p_email=>'user1@gmail.com' , p_password=>'user1' , p_score=>0);
   

   -- created a game / player combination data
   sp_insert_into_game_player(v_game_player_id,  p_game_id =>game_id, p_player_id =>user_id, p_score => 0);

   -- get a random card
   randomCard(card_number, card_name, card_symbol);
   dbms_output.put_line('Your card is ' || card_name || ' of '|| card_symbol || '. Its value is ' || card_number);

   -- insert drawn card
   sp_create_drawn_cards_history(drawn_cards_id , p_game_player_id => v_game_player_id ,  p_name=> card_name, p_symbol=> card_symbol);

   -- update user score
   player2_score := player2_score + card_number;
   sp_update_score(player2_score, user_id );

    -- while less than 17
	while player2_score <= 16 
	loop
		-- get a randow card
		randomCard(card_number, card_name, card_symbol);
		dbms_output.put_line('Your card is ' || card_name || ' of '|| card_symbol || '. Its value is ' || card_number);

		select count(*) into v_card_taken from drawn_cards_history where NAME = card_name and SYMBOL = card_symbol;

		IF v_card_taken <= 0 THEN
			-- insert into drawn card table
			sp_create_drawn_cards_history(drawn_cards_id , p_game_player_id => v_game_player_id ,  p_name=> card_name, p_symbol=> card_symbol);

			-- update user score
			player2_score := player2_score + card_number;
			sp_update_score(player2_score, user_id );
		ELSE
			dbms_output.put_line('Card is taken');
		END IF;
	end loop;

	-- check if score greater than 21
	sp_get_player_info_from_id(user_id, player2_name);
	IF player2_score > 21 THEN
		dbms_output.put_line(player2_name ||' score is ' || player2_score || ' You are Busted');
		player2_score := 0;
	ELSIF player2_score = 21 THEN
		dbms_output.put_line(player2_name ||' score is ' || player2_score || ' BlackJack');
	ELSE
		dbms_output.put_line(player2_name ||' score is ' || player2_score);
	END IF;
	
	
	
	
	
	dbms_output.put_line('---------------------PLAYER THREE GAME-----------------------');
   user_id :=0;
   v_game_player_id := 0;
	
   sp_insert_user(user_id , p_name => 'Revathi', p_username=> 'user1' , p_email=>'user1@gmail.com' , p_password=>'user1' , p_score=>0);
   

   -- created a game / player combination data
   sp_insert_into_game_player(v_game_player_id,  p_game_id =>game_id, p_player_id =>user_id, p_score => 0);

   -- get a random card
   randomCard(card_number, card_name, card_symbol);
   dbms_output.put_line('Your card is ' || card_name || ' of '|| card_symbol || '. Its value is ' || card_number);

   -- insert drawn card
   sp_create_drawn_cards_history(drawn_cards_id , p_game_player_id => v_game_player_id ,  p_name=> card_name, p_symbol=> card_symbol);

   -- update user score
   player3_score := player3_score + card_number;
   sp_update_score(player3_score, user_id );

    -- while less than 17
	while player3_score <= 16 
	loop
		-- get a randow card
		randomCard(card_number, card_name, card_symbol);
		dbms_output.put_line('Your card is ' || card_name || ' of '|| card_symbol || '. Its value is ' || card_number);

		select count(*) into v_card_taken from drawn_cards_history where NAME = card_name and SYMBOL = card_symbol;

		IF v_card_taken <= 0 THEN
			-- insert into drawn card table
			sp_create_drawn_cards_history(drawn_cards_id , p_game_player_id => v_game_player_id ,  p_name=> card_name, p_symbol=> card_symbol);

			-- update user score
			player3_score := player3_score + card_number;
			sp_update_score(player3_score, user_id );
		ELSE
			dbms_output.put_line('Card is taken');
		END IF;
	end loop;

	-- check if score greater than 21
	sp_get_player_info_from_id(user_id, player3_name);
	IF player3_score > 21 THEN
		dbms_output.put_line(player3_name ||' score is ' || player3_score || ' You are Busted');
		player3_score := 0;
	ELSIF player3_score = 21 THEN
		dbms_output.put_line(player3_name ||' score is ' || player3_score || ' BlackJack');
	ELSE
		dbms_output.put_line(player3_name ||' score is ' || player3_score);
	END IF;
	
	
	
	
	
	
	
	
   dbms_output.put_line('---------------------DEALER GAME-----------------------');
   user_id :=0;
   v_game_player_id := 0;
	
   sp_insert_user(user_id , p_name => 'Dealer', p_username=> 'user1' , p_email=>'user1@gmail.com' , p_password=>'user1' , p_score=>0);
   

   -- created a game / player combination data
   sp_insert_into_game_player(v_game_player_id,  p_game_id =>game_id, p_player_id =>user_id, p_score => 0);

   -- get a random card
   randomCard(card_number, card_name, card_symbol);
   dbms_output.put_line('Your card is ' || card_name || ' of '|| card_symbol || '. Its value is ' || card_number);

   -- insert drawn card
   sp_create_drawn_cards_history(drawn_cards_id , p_game_player_id => v_game_player_id ,  p_name=> card_name, p_symbol=> card_symbol);

   -- update user score
   dealer_score := dealer_score + card_number;
   sp_update_score(dealer_score, user_id );

    -- while less than 17
	while dealer_score <= 16 
	loop
		-- get a randow card
		randomCard(card_number, card_name, card_symbol);
		dbms_output.put_line('Your card is ' || card_name || ' of '|| card_symbol || '. Its value is ' || card_number);

		select count(*) into v_card_taken from drawn_cards_history where NAME = card_name and SYMBOL = card_symbol;

		IF v_card_taken <= 0 THEN
			-- insert into drawn card table
			sp_create_drawn_cards_history(drawn_cards_id , p_game_player_id => v_game_player_id ,  p_name=> card_name, p_symbol=> card_symbol);

			-- update user score
			dealer_score := dealer_score + card_number;
			sp_update_score(dealer_score, user_id );
		ELSE
			dbms_output.put_line('Card is taken');
		END IF;
	end loop;

	-- check if score greater than 21
	sp_get_player_info_from_id(user_id, dealer_name);
	IF dealer_score > 21 THEN
		dbms_output.put_line(dealer_name ||' score is ' || dealer_score || ' You are Busted');
		dealer_score := 0;
	ELSIF dealer_score = 21 THEN
		dbms_output.put_line(dealer_name ||' score is ' || dealer_score || ' BlackJack');
	ELSE
		dbms_output.put_line(dealer_name ||' score is ' || dealer_score);
	END IF;
	
	dbms_output.put_line('---------------------FINAL SCORE-----------------------');
	
	IF user_score > player2_score THEN
	    IF user_score > player3_score THEN
			IF user_score > dealer_score THEN
				dbms_output.put_line(user_name ||' won with a score of ' || user_score );
			ELSIF user_score < dealer_score THEN
				dbms_output.put_line(dealer_name ||' won with a score of ' || dealer_score );
			ELSE
				dbms_output.put_line('It is a tie with ' || user_score);
			END IF;
		ELSIF user_score < player3_score THEN
			IF player3_score > dealer_score THEN
				dbms_output.put_line(player3_name ||' won with a score of ' || player3_score );
			ELSIF player3_score < dealer_score THEN
				dbms_output.put_line(dealer_name ||' won with a score of ' || dealer_score );
			ELSE
				dbms_output.put_line('It is a tie with ' || player3_score);
			END IF;
		ELSE
			dbms_output.put_line('It is a tie with ' || user_score);
		END IF;
	ELSIF player2_score > user_score THEN
	    IF player2_score > player3_score THEN
			IF player2_score > dealer_score THEN
				dbms_output.put_line(player2_name ||' won with a score of ' || player2_score );
			ELSIF user_score < dealer_score THEN
				dbms_output.put_line(dealer_name ||' won with a score of ' || dealer_score );
			ELSE
				dbms_output.put_line('It is a tie with ' || player2_score);
			END IF;
		ELSIF player2_score < player3_score THEN
			IF player3_score > dealer_score THEN
				dbms_output.put_line(player3_name ||' won with a score of ' || player3_score );
			ELSIF player3_score < dealer_score THEN
				dbms_output.put_line(dealer_name ||' won with a score of ' || dealer_score );
			ELSE
				dbms_output.put_line('It is a tie with ' || player3_score);
			END IF;
		ELSE
			dbms_output.put_line('It is a tie with ' || player2_score);
		END IF;
	ELSE
		dbms_output.put_line('It is a tie with ' || user_score);
	END IF;
	
	delete from drawn_cards_history;
	
END;

