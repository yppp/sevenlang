fib := method(n, 
    if(n < 2, n, fib(n - 1) + fib(n - 2))
)

fib := method(n,
    fir ::= 0
    sec ::= 1
    tmp ::= 0
    n repeat(
    tmp = sec
    sec = sec + fir
    fir = tmp
   )
fir
)


div := Number getSlot("/")
Number / := method(n, if(n == 0, 0, self div(n)))

dim2sum := method(n, n flatten sum)
dim2sum := method(n, n prepend(0) reduce(x, y, x = x + y sum))

List myAvg := method(reduce(x, y, if(y proto != Number, Exception raise("二度と数字以外を入れるんじゃねーぞ、バーカ！"), x + y))  / size)

Dim2list := Object clone do(
dim := method(x, y, result := list(); y repeat(nl := list(); x repeat(nl append(nil)); result append(nl)); self lis := result);
set := method(x, y, val, self lis at(y) atPut(x, val); self lis);
get := method(x, y, self lis at(y) at(x));
transpose := method(
			result := Dim2list clone;
			write(self lis at(0) size, self lis size, "\n");
	      		result dim(self lis size, self lis at(0) size);
			self lis at(0) size repeat(i,
			self lis size repeat(j,
			write(i,j,"\n");
			result set(j, i, self get(i, j)))));
)

maread := method(path, lis := list(); File open(path) readLines foreach(line, lis append(line split(" ") select(v, v != "") map(v, v asNumber))); File open(path) close; lis);
mawrite := method(path, lis, f := File open(path); lis foreach(v, f write(v join(" ") append("\n" at(0)))); File open(path) close;  lis);

fo := Dim2list clone
fo lis := maread("fafa.txt")
mawrite("foofoo.txt", fo transpose)

hitandblow := method(
	   f := File standardInput
	   num := (Random value(99) + 1) floor;
	   prev := 0;
	   10 repeat(i,
	   in := f readLine asNumber;
	   if(num == in, "hit!" println; break);
	   if(prev != 0, if(prev > ((num - in) abs), "near" println, "far" println));
	   prev = (num - in) abs;
	   if(i == 9, write("fail ", "atarinumber ", num));
	   );
)
