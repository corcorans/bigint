with Text_Io;
use Text_Io;

-- Stephen Corcoran 
-- CS352, mp6
-- Body for package BigInt.
package body BigInt is
    package Int_IO   is new Text_Io.Integer_Io(Integer);
    package Digit_IO is new Text_Io.Integer_Io(Digit);
    
    -- Reads in a character unless it is a space.
    -- @return: a Character read in.
    function Read_Nonspace return Character is
       X : Character := ' ';
    begin
       while X = ' ' loop
          if Text_Io.End_Of_Line then
             Text_Io.Skip_Line;
          else
             Text_Io.Get(x);
          end if;
       end loop;
       return X;
    end Read_Nonspace;
    
    -- Reads in the input from the user and strips off any
    -- leading zeros and ignores spaces.
    -- @return: Returns a BigInteger.
    function read_input return BigInteger is
        char : character;
        number : BigInteger;
        list : NumList := null;
    begin
        number.Positive := true;
        char := Read_Nonspace;
        while char /= ' ' and not Text_Io.End_Of_Line loop
            if char = '-' then number.Positive := false;
            else list := InsertToLL(Digit(Character'Pos(char)-48), list);
            end if;
            Text_Io.get(char);
        end loop;
        if char /= ' ' then 
            list := insertToLL(Digit(Character'Pos(char)-48), list); 
        end if;
        number.Numbers := truncateZeros(list);
        if number.Numbers.Value = Digit(0) and number.Numbers.Next = null then
            number.Positive := true;
        end if;
        return number;
    end read_input;
 
    -- Will instead a specific digit into the linked list.
    -- @return: Returns the NumList.
    function insertToLL(dig : Digit; list : NumList) return NumList is
    begin
        if list = null then return new DNode'(dig, null);
        else return new DNode'(dig, list);
        end if;
    end insertToLL;
    
    -- Takes in a NumList and reverses it.
    -- @returns: The reversed NumList.
    function reverseLinkList(list : NumList) return NumList is
        llist : NumList := list;
        returnList : NumList := null;
    begin
        while llist /= null loop
            returnList := new DNode'(llist.Value, returnList);
            llist := llist.Next;
        end loop;
        return returnList;
    end reverseLinkList;
  
    -- Takes in a NumList and the removes all leading zeros.
    -- @return: Returns the linkedList without leading zeros.
    function truncateZeros(list : NumList) return NumList is
        llist : NumList := list;
        returnList : NumList := null;
    begin
        llist := reverseLinkList(llist);
        while llist /= null and then llist.Value = Digit(0) loop
            llist := llist.Next;
        end loop;
        while llist /= null loop
            returnList := new DNode'(llist.Value, returnList);
            llist := llist.Next;
        end loop;
        if returnList = null then
            returnList := insertToLL(Digit(0), returnList);
        end if;
        return returnList;
    end truncateZeros;

    -- Will check to see which number is the largest of the two passed in. 
    -- @return: Will return an integer to correspond with the number was larger.
    function checkSize(num1 : BigInteger; num2 : BigInteger) return Integer is
        op1_flag : Boolean := false;
        op2_flag : Boolean := false;
        number_1 : Integer := 0;
        number_2 : Integer := 0;
        flipped_1 : NumList;
        flipped_2 : NumList;
        tmpList1 : NumList;
        tmpList2 : NumList;
    begin
        number_1 := checkLength(num1.Numbers);
        number_2 := checkLength(num2.Numbers);
        if number_1 < number_2 then return 2;
        elsif number_1 > number_2 then return 1;
        else
            flipped_1 := reverseLinkList(num1.Numbers);
            flipped_2 := reverseLinkList(num2.Numbers);
            
            tmpList1 := flipped_1;
            tmpList2 := flipped_2;
            
            while op1_flag = false and op2_flag = false 
                  and tmpList1 /= null and tmpList2 /= null loop
                if tmpList1.Value > tmpList2.Value then
                    op1_flag := true;
                elsif tmpList1.Value < tmpList2.Value then
                    op2_flag := true;
                end if;
                tmpList1 := tmpList1.Next;
                tmpList2 := tmpList2.Next;
            end loop;
        end if;
        if op2_flag = true then return 2;
        else return 1;
        end if;
    end checkSize;
    
    -- Will check the length of the NumList passed in.
    -- @return: The length of the list passed in.
    function checkLength(list : NumList) return Integer is
        length : Integer := 0;
        llist : NumList := list;
    begin
        while llist /= null loop
            length := length + 1;
            llist := llist.Next;
        end loop;
        return length;
    end checkLength;
     
    -- Will compute the addition of two BigIntegers and return the value.
    -- @return: Will retrun the sum of the two numbers passed.
    function simple_add( num1 : BigInteger; num2 : BigInteger) return BigInteger is
        number_1 : NumList := num1.Numbers;
        number_2 : NumList := num2.Numbers;
        sum : Integer;
        return_sum : NumList := null;
        carry : Integer := 0;
        return_bigInt : BigInteger;
    begin
        while number_1 /= null or number_2 /= null or carry /= 0 loop
            if number_1 = null then number_1 := new DNode'(Digit(0), null); end if;
            
            if number_2 = null then number_2 := new DNode'(Digit(0), null); end if;
            
            sum := Integer(number_1.Value) + Integer(number_2.Value) + carry;
            
            if sum > 9 then
                carry := 1;
                sum := sum - 10;
            else
                carry := 0;
            end if;
            
            return_sum := New DNode'(Digit(sum), return_sum);
            
            number_1 := number_1.Next;
            number_2 := number_2.Next;

            return_bigInt := (true, return_sum);
        end loop;
        return return_bigInt;
    end simple_add;
    
    -- Will subtract two BigIntegers and return the result of such.
    -- @return: the difference of the two BigIntegers passed in.
    function simple_subtract(num1 : BigInteger; num2 : BigInteger) return BigInteger is
        number_1 : NumList := num1.Numbers;
        number_2 : NumList := num2.Numbers;
        difference : Integer;
        return_difference : NumList := null;
        borrow : Integer := 0;
        return_bigInt : BigInteger;
    begin
        while number_1 /= null or number_2 /= null or borrow /= 0 loop
            if number_1 = null then number_1 := new DNode'(Digit(0), null); end if;
            
            if number_2 = null then number_2 := new DNode'(Digit(0), null); end if;
            
            difference := Integer(number_1.Value) - Integer(number_2.Value) - borrow;
            
            if difference < 0 then
                borrow := 1;
                difference := difference + 10;
            else borrow := 0;
            end if;
            
            return_difference := New DNode'(Digit(difference), return_difference);
            
            number_1 := number_1.Next;
            number_2 := number_2.Next;
            
            return_bigInt := (true, return_difference);
        end loop;
        return return_bigInt;
    end simple_subtract;
       
    -- Will compute the addition of BigIntegers using the simple_add function and will
    -- then set the positive or negative flag for each result.
    -- @return: The final BigInteger with correct a correct sign associated with it.
    function complex_add(num1 : BigInteger; num2 : BigInteger) return BigInteger is
        size_difference : Integer := 0;
        result : BigInteger;
    begin
        if num1.Positive = true and num2.Positive = true then
            result := simple_add(num1, num2);
        elsif num1.Positive = false and num2.Positive = false then
            result := simple_add(num1, num2);
            result.Positive := false;
        else
            size_difference := checkSize(num1, num2);

            if size_difference = 2 then
                result := simple_subtract(num2, num1);
            else
                result := simple_subtract(num1, num2);
            end if;
            
            result.Numbers := truncateZeros(reverseLinkList(result.Numbers));
            result.Numbers := reverseLinkList(result.Numbers);
            
            if (num1.Positive = false and size_difference = 1 and result.Numbers.Value /= Digit(0))
               or (num2.Positive = false and size_difference = 2) then
               result.Positive := false;
            else result.Positive := true;
            end if;
        end if;
        return result;
    end complex_add;
    
    -- Will compute the complete BigInteger subtraction using the simple_subtract. Then 
    -- will place the signs for each difference correctly.
    -- @return: the final BigInteger number.
    function complex_subtract(num1 : BigInteger; num2 : BigInteger) return BigInteger is
        size_difference : Integer := 0;
        difference : BigInteger;
    begin
        if num1.Positive = true and num2.Positive = true then
            size_difference := checkSize(num1, num2);
            if size_difference = 2 then
                difference := simple_subtract(num2, num1);
                difference.Positive := false;
            else
                difference := simple_subtract(num1, num2);
            end if;
        elsif num1.Positive = false and num2.Positive = false then
            size_difference := checkSize(num1, num2);
            if size_difference = 2 then
                difference := simple_subtract(num2, num1);
            else
                difference := simple_subtract(num1, num2);
                if difference.Numbers.Value /= Digit(0) then
                    difference.Positive := false;
                end if;
            end if;
        else
            difference := simple_add(num1, num2);
            if num1.Positive = false then
                difference.Positive := false;
            end if;
        end if;
        difference.Numbers := truncateZeros(reverseLinkList(difference.Numbers));
        difference.Numbers := reverseLinkList(difference.Numbers); 
        return difference;
    end complex_subtract;
    
    -- Will print out the numbers in the correct order.
    -- @return: The number in the correct order with correct
    -- sign value.
    procedure print_output(number : BigInteger) is
        llist : NumList := number.Numbers;
    begin
        if number.Positive = false then Text_Io.put("-"); end if;
        while llist /= null loop
            Digit_Io.put(llist.Value, 1);
            llist := llist.Next;
        end loop;
    end print_output;
    
    -- Formats the output expected for the program and called 
    -- print_output to format the number correctly.
    procedure pprint(number_1 : BigInteger; number_2 : BigInteger;
                     output : BigInteger; output2 : BigInteger; 
                     output3 : BigInteger; output4 : BigInteger) is
        num1 : BigInteger := number_1;
        num2 : BigInteger := number_2;
    begin
        num1.Numbers := reverseLinkList(num1.Numbers);
        num2.Numbers := reverseLinkList(num2.Numbers);
    
        print_output(num1);
        Text_Io.put(" + " );
        print_output(num2);
        Text_Io.put(" = " );
        print_output(output);
        
        Text_Io.new_line;
        
        print_output(num2);
        Text_Io.put(" + " );
        print_output(num1);
        Text_Io.put(" = " );
        print_output(output2);
        
        Text_Io.new_line;
        
        print_output(num1);
        Text_Io.put(" - " );
        print_output(num2);
        Text_Io.put(" = " );
        print_output(output3);
        
        Text_Io.new_line;
        
        print_output(num2);
        Text_Io.put(" - " );
        print_output(num1);
        Text_Io.put(" = " );
        print_output(output4);
    end pprint;
end BigInt;
