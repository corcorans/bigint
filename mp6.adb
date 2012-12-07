with BigInt;
use BigInt;
with Text_Io;

-- Stephen Corcoran
-- CS352, mp6
-- Main procedure.

-- Procedure which will read in the two numbers from
-- the input, then perform calculations on the two
-- numbers by adding and subtracting in both 
-- directions.
procedure mp6 is
    number_1 : BigInteger;
    number_2 : BigInteger;
    output : BigInteger;
    output2 : BigInteger;
    output3 : BigInteger;
    output4 : BigInteger;
begin
    number_1 := read_input;
    number_2 := read_input;
    
    output := complex_add(number_1, number_2);
    output2 := complex_add(number_2, number_1);
    output3 := complex_subtract(number_1, number_2);
    output4 := complex_subtract(number_2, number_1);
    
    pprint(number_1, number_2, output, output2, output3, output4);
end mp6;