-- procedura wypisujaca do konsoli ciąg fibonacciego
-- procedura przyjmuje jako argument wejsciowa liczbe n
-- generowanie ciagu jako osobna funkcja wywolywana przez procedure


CREATE OR REPLACE FUNCTION Fibonacci(n IN integer)
RETURNS VOID 
AS $$

DECLARE
x integer:= 0;
xNext integer:= 1;
tempp integer:= 0;

BEGIN

if n = 0 THEN
    raise notice  'Wybrano 0 liczb';
elsif n = 1 THEN
    raise notice '%', x;
else
    for i in 1..n loop
        raise notice  '%', x;
        tempp:= xNext;
        xNext:= x + tempp;
        x := tempp;
    end loop;
end if;

end;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE Write (n  integer)
LANGUAGE SQL
AS $$
    SELECT fibonacci(n);
$$;

CALL  Write (5);

