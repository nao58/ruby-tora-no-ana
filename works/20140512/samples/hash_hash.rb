# encoding: utf-8

res = {}
[1,2,3].each do |x|
  xs = {}
  [9,8,7].each do |y|
    xs[y] = x * y
  end
  res[x] = xs
end

res = {}
[1,2,3].each do |x|
  res[x] = [9,8,7].each_with_object({}){|y,res| res[y]=x*y}
end
