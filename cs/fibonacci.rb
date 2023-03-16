def fibs(n) # while loop version
  result = [0, 1]
  while n > result.length
    result << result[-1] + result [-2]
  end
  result
end

def fibs_rec(n, result=[0, 1])
  result << (result[-1] + result[-2])
  n -= 1
  n > 2 ? fibs_rec(n, result) : result
end

puts fibs(8)
puts fibs_rec(12)