def fibs(n) # while loop version
  result = [0, 1]
  if n == 1
    return result[n-1]
  elsif n == 0  
    return
  else
    while n > result.length
      result << result[-1] + result [-2]
    end
  end
  result
end

# Have not catered for n < 2 in this case
def fibs_rec(n, result=[0, 1])
  result << (result[-1] + result[-2])
  n -= 1
  n > 2 ? fibs_rec(n, result) : result
end

puts fibs(23)
# puts fibs_rec(12)