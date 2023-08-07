

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity haldAdder is
  Port (
  A: in std_logic ;
  B: in std_logic ;
  sum: out std_logic ;
  carry: out std_logic  
   );
end haldAdder;

architecture dataflow of haldAdder is
begin

carry <= A AND B ;
sum <= A XOR B;

end dataflow;
