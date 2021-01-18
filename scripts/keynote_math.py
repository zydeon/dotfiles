#!/usr/bin/env python3
import sys


def convert(s, j):
  if s[j:] == '':
    return ''
  x = s.find('$', j)
  if x == -1:
    return '\\text{' + s[j:] + '}'
  y = s.find('$', x + 1)
  if y == -1:
    raise Exception('String not parsable')
  if j == x:
    return s[x + 1:y] + convert(s, y + 1)
  return '\\text{' + s[j:x] + '}' + s[x + 1:y] + convert(s, y + 1)

def test():
  def test_case(query, expected):
    print(f'Query:\t\t{query}')
    print(f'Expected:\t{expected}')
    actual = convert(query, 0)
    print(f'{"✅" if actual == expected else "❌"} Actual:\t{actual}\n')

  q = 'Assume $q$ not cyclic rotation of $p$.'
  e = '\\text{Assume }q\\text{ not cyclic rotation of }p\\text{.}'
  test_case(q, e)

  q = 'if $k>3$, then $|T|\ge 2|p|$'
  e = '\\text{if }k>3\\text{, then }|T|\ge 2|p|'
  test_case(q, e)

  q = 'so, $T$ has period $q_T$ of size'
  e = '\\text{so, }T\\text{ has period }q_T\\text{ of size}'
  test_case(q, e)

  q = '$\gcd(|p|,|q|)$, by Periodicity Lemma'
  e = '\gcd(|p|,|q|)\\text{, by Periodicity Lemma}'
  test_case(q, e)

  q = 'since $p\\neq q^c$, $|q_T|<|q|$'
  e = '\\text{since }p\\neq q^c\\text{, }|q_T|<|q|'
  test_case(q, e)

  q = 'contradiction, $q$ smallest period of $T$'
  e = '\\text{contradiction, }q\\text{ smallest period of }T'
  test_case(q, e)


if __name__ == '__main__':
  if len(sys.argv) == 2:
    if sys.argv[1] == 'test':
      test()
  else:
    s = input()
    print(convert(s, 0))
