-- This package contains the node struct in a sense along with
-- the functions and procedures that will be written in the 
-- bigint.adb.

-- Stephen Corcoran
-- CS352, mp6
-- Package BigInt

package BigInt is

    type DNode;
    type NumList is access DNode;
    type Digit is range 0..9;
    type DNode is
      record
         Value : Digit;
         Next  : NumList;
      end record;
    type BigInteger is
      record
         Positive : Boolean;
         Numbers  : NumList;
      end record;

    -- Public functions.
    function read_input return BigInteger;
    function complex_add(num1 : BigInteger; num2 : BigInteger) return BigInteger;
    function complex_subtract(num1 : BigInteger; num2 : BigInteger) return BigInteger;
    procedure pprint(number_1 : BigInteger; number_2 : BigInteger; output : BigInteger; 
                     output2 : BigInteger; output3 : BigInteger; output4 : BigInteger);
                     
    -- Private functions.
    private
        function insertToLL(dig : Digit; list : NumList) return NumList;
        function truncateZeros(list : NumList) return NumList;
        function reverseLinkList(list : NumList) return NumList;
        procedure print_output(number : BigInteger);
        function simple_add( num1 : BigInteger; num2 : BigInteger) return BigInteger;
        function simple_subtract(num1 : BigInteger; num2 : BigInteger) return BigInteger;
        function checkLength(list : NumList) return Integer;
        function checkSize(num1 : BigInteger; num2 : BigInteger) return Integer;
        function Read_Nonspace return Character;
end BigInt;