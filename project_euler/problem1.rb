def multiples_sum(divisor1, divisor2, ceiling)
  divisor1_results = (1..ceiling).select { |n| n % divisor1 == 0 }
  divisor2_results = (1..ceiling).select { |n| n % divisor2 == 0 }
  divisor1_results.sum + divisor2_results.sum
end
# puts multiples_sum(3,5,100)

def factorial(n, total=0)
  while n > 1
    total > 0 ? total = total * (n-1) : total += n * (n-1)
    n -= 1
    factorial(n, total)
  end
  total
end

def factorial1(n)
  n == 0 ? 1 : n * factorial(n-1)
end
puts factorial(5)