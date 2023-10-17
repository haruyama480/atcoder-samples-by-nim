import harulib/utils

x := 3
echo x
x := 2
echo x
block:
  x := 1
echo x # 2

x := (block:
  if true:
    100
  else:
    99
)

echo x
