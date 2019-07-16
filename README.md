# Data Structures in Ruby

## Hash table

[Wikipedia](https://en.wikipedia.org/wiki/Hash_table):

> In computing, a hash table (hash map) is a data structure used to implement an associative array, a structure that can map keys to values. A hash table uses a hash function to compute an index into an array of buckets or slots, from which the desired value can be found.

[Ruby documentation](https://ruby-doc.org/core-2.4.0/Hash.html):

> A Hash is a dictionary-like collection of unique keys and their values. Also called associative arrays, they are similar to Arrays, but where an Array uses integers as its index, a Hash allows you to use any object type.

Names of the structure:

- in Ruby, it's called `Hash`
- in Python, it's called `Dictionary`
- in JavaScript, it's called `Object Literals`

### Usage example

```
> irb
> load 'src/hash_table/separate_chaining.rb'
true
> hsh = SeparateChaining.new
#<SeparateChaining:0x00007fd1d50decc0 @slots_count=97, @size=0, @slots=[]>
> hsh.empty?
true
> hsh[:a] = 1
1
> hsh.empty?
false
> hsh[:b] = 2
2
> hsh[:b] = 222
222
> hsh[:a]
1
> hsh[:b]
222
> hsh.delete(:b)
222
> hsh.delete(:a)
1
> hsh.empty?
true
```

### Resources

- [Algorithms by Robert Sedgewick and Kevin Wayne - Hash Tables](http://algs4.cs.princeton.edu/34hash/)
