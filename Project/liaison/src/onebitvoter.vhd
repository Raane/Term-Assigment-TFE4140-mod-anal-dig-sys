library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity onebitvoter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           a : in STD_LOGIC;
           b : in STD_LOGIC;
           c : in STD_LOGIC;
           d : in STD_LOGIC;
           y : out STD_LOGIC;
           status : out STD_LOGIC_VECTOR(2 downto 0)
           
       );
    
end onebitvoter;

architecture Behavioral of onebitvoter is
    
    signal state_a: STD_LOGIC := '1';
    signal state_b: STD_LOGIC := '1';
    signal state_c: STD_LOGIC := '1';
    signal state_d: STD_LOGIC := '1';
    signal status_internal: STD_LOGIC_VECTOR(2 downto 0);
    signal last_status: STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal voted_data: STD_LOGIC;
    signal sum_of_inputs: STD_LOGIC_VECTOR(2 downto 0);
    signal number_of_winning_votes: STD_LOGIC_VECTOR(2 downto 0);
    signal extended_a: STD_LOGIC_VECTOR(2 downto 0);
    signal extended_b: STD_LOGIC_VECTOR(2 downto 0);
    signal extended_c: STD_LOGIC_VECTOR(2 downto 0);
    signal extended_d: STD_LOGIC_VECTOR(2 downto 0);
    signal extended_vote_a: STD_LOGIC_VECTOR(2 downto 0);
    signal extended_vote_b: STD_LOGIC_VECTOR(2 downto 0);
    signal extended_vote_c: STD_LOGIC_VECTOR(2 downto 0);
    signal extended_vote_d: STD_LOGIC_VECTOR(2 downto 0);
    
begin

-- Start of state machine back end
-- Update outputs when the clock tick occur
process (clk)
begin
    if (rising_edge(clk)) then
        if(reset='1') then
            state_a <= '1'; --default state on reset.
            state_b <= '1'; --default state on reset.
            state_c <= '1'; --default state on reset.
            state_d <= '1'; --default state on reset.
last_status <= "000";
        else
            status <= status_internal;
last_status <= status_internal;
            y <= voted_data;
            state_a <= state_a and (voted_data xnor a);
            state_b <= state_b and (voted_data xnor b);
            state_c <= state_c and (voted_data xnor c);
            state_d <= state_d and (voted_data xnor d);
        end if;
    end if;
end process;

-- End of state machine back end
-- Start of state machine front end

-- Filter out votes from failed micro controllers and extend the vote result to a 3 bit number
process (a, b, c, d, state_a, state_b, state_c, state_d)
begin
    extended_a <= "00"&(a and state_a);
    extended_b <= "00"&(b and state_b);
    extended_c <= "00"&(c and state_c);
    extended_d <= "00"&(d and state_d);
end process;

-- Calculate the sum of the inputs from all the non broken controllers
process (extended_a, extended_b, extended_c, extended_d)
begin
    sum_of_inputs <= std_logic_vector(
unsigned(extended_a) +
unsigned(extended_b) +
unsigned(extended_c) +
unsigned(extended_d));
end process;

-- Set the voted data based on the status and the sum of the input data
-- This is the core of the state machine driving the system
process (sum_of_inputs, last_status)
begin
    case last_status is
        when "000" =>
            case sum_of_inputs is
                when "100" =>
                    voted_data <= '1';
                when "011" =>
                    voted_data <= '1';
                when "010" =>
                    voted_data <= '1'; -- in 2v2 votes the data doesn't matter, we are going to status 111 anyway
                when "001" =>
                    voted_data <= '0';
                when "000" =>
voted_data <= '0';
when others =>
            end case;
        when "001" =>
            case sum_of_inputs is
                when "011" =>
                    voted_data <= '1';
                when "010" =>
                    voted_data <= '1';
                when "001" =>
                    voted_data <= '0';
                when "000" =>
voted_data <= '0';
when others =>
            end case;
        when "010" =>
            case sum_of_inputs is
                when "010" =>
                    voted_data <= '1';
                when "001" =>
                    voted_data <= '1'; -- in 2v2 votes the data doesn't matter, we are going to status 111 anyway
                when "000" =>
voted_data <= '0';
when others =>
            end case;
when others =>
    end case;
end process;

-- Filter out the votes that did not match the winning vote and extend them to a 3 bit number
process(voted_data, a, b, c, d, state_a, state_b, state_c, state_d)
begin
extended_vote_a <= "00"&(state_a and (voted_data xnor a));
extended_vote_b <= "00"&(state_b and (voted_data xnor b));
extended_vote_c <= "00"&(state_c and (voted_data xnor c));
extended_vote_d <= "00"&(state_d and (voted_data xnor d));
end process;

-- Calculate the number of votes that matched the vote outcome which came from an input with state '1'
process(extended_vote_a, extended_vote_b, extended_vote_c, extended_vote_d)
begin
number_of_winning_votes <= std_logic_vector(
unsigned( extended_vote_a ) +
            unsigned( extended_vote_b ) +
            unsigned( extended_vote_c ) +
            unsigned( extended_vote_d )
);
end process;

-- Calculate the internal status field based on the inputs matched with the voted data
process (number_of_winning_votes, last_status)
begin
if(number_of_winning_votes = "010" and last_status = "000") then
	status_internal <= "111";
else
     case number_of_winning_votes is
         when "100"=>
             status_internal <= "000";
         when "011"=>
             status_internal <= "001";
         when "010"=>
             status_internal <= "010";
         when "001"=>
             status_internal <= "111";
         when "000"=>
status_internal <= "111";
when others =>
end case;	
end if;
end process;
-- End of state machine front end

end Behavioral;
